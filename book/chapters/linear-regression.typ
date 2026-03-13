Linear regression is the smallest model that still shows the complete learning loop:
make a prediction, measure the error, nudge the parameters to reduce it, repeat.
Every chapter in this book runs the same loop. What changes is what sits inside
`predict` — a line here, a neural network later, a transformer at the end.

This chapter predicts how long a visitor must wait for the next eruption of Old
Faithful geyser, given how long the current eruption lasted. The model is a single
line. The data is real.

== The data

Old Faithful, in Yellowstone National Park, erupts regularly. Rangers and visitors
have noticed that longer eruptions tend to be followed by longer waits. We download
272 recorded observations to find out exactly how strong that relationship is:

#oxdraw("
graph LR
    geyser[Old Faithful] --> csv[faithful.csv]
    csv --> xs[eruption durations]
    csv --> ys[waiting times]
    xs --> center[subtract mean]
    center --> xs_c[centered xs]
    xs_c --> train
    ys --> train
")

```python
if not os.path.exists('faithful.csv'):
    urllib.request.urlretrieve(
        'https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/faithful.csv',
        'faithful.csv',
    )

xs, ys = [], []
for line in open('faithful.csv').readlines()[1:]:
    _, eruption, waiting = line.strip().split(',')
    xs.append(float(eruption))   # duration in minutes
    ys.append(float(waiting))    # wait until next eruption (minutes)

print(f"num eruptions: {len(xs)}")
```

```
num eruptions: 272
```

Each row is one observation. `xs` holds eruption durations (1.6 – 5.1 minutes) and
`ys` holds the wait until the next eruption (43 – 96 minutes).

Before training we subtract the mean from every `x`:

```python
mu = sum(xs) / len(xs)
xs = [x - mu for x in xs]
```

The mean eruption is about 3.49 minutes, so after centering a 3.49-minute eruption
becomes 0.0, a 5.0-minute eruption becomes +1.51, and so on. The `ys` are left
unchanged.

Why center? When `x` is not centered, changing `weight` shifts every prediction,
which then forces a compensating change in `bias`, which shifts predictions again.
The two parameters chase each other. When `x` has mean zero, a change in `weight`
does not move the average prediction at all, so `bias` can learn its own value
independently. Convergence is much faster.

== The model

#oxdraw("
graph LR
    x[eruption duration] --> predict
    weight --> predict
    bias --> predict
    predict --> y_hat[predicted wait]
    y_hat --> error[error vs actual]
    error --> weight
    error --> bias
")

The model is one line of arithmetic:

```python
def predict(weight, bias, x):
    return weight * x + bias
```

`weight` is the slope — how many extra minutes of waiting each extra minute of
eruption predicts. `bias` is the baseline — the expected wait when `x` is zero,
which after centering means an average-length eruption. Both start at zero and are
adjusted by gradient descent.

== Gradient descent

We measure how wrong the model is by squaring each prediction error and averaging:

```python
loss = sum((predict(weight, bias, x) - y) ** 2 for x, y in zip(xs, ys)) / n
```

Squaring does two things: it makes all errors positive (otherwise positive and
negative errors cancel out and a terrible model can look fine), and it penalises
large errors more than small ones.

To reduce the loss we adjust `weight` and `bias` in the direction that makes it
smaller. For each data point:

```python
error = predict(weight, bias, x) - y
weight_grad += error * x
bias_grad   += error
```

`error` alone is the blame signal for `bias`: if the prediction is too high,
`bias` is too high, so subtract from it.

`error * x` is the blame signal for `weight`: weight's contribution to the prediction
was `weight * x`, so if the prediction is wrong by `error`, weight is responsible
for `error * x` of that. When `x` is large, weight had a big lever; when `x` is near
zero, weight barely mattered and its gradient is small.

After accumulating across all observations we subtract a scaled version from each
parameter:

```python
weight -= scale * weight_grad
bias   -= scale * bias_grad
```

`scale = 2.0 * lr / n`. The `n` normalises for dataset size so the step size does
not depend on how many rows are in the CSV. The `2.0` comes from differentiating the
squared error — squaring produces a factor of 2 in the derivative. The learning rate
`lr` is a dial: too small and training is slow, too large and the loss explodes
instead of falling.

== Training

We run 200 steps. The loss starts large and falls to a stable floor:

```
step=001  loss=4219.250  weight=1.393  bias=7.090
step=050  loss=34.852    weight=10.719  bias=70.532
step=100  loss=34.718    weight=10.730  bias=70.895
step=150  loss=34.718    weight=10.730  bias=70.897
step=200  loss=34.718    weight=10.730  bias=70.897
```

By step 100 the parameters have stopped changing. When the gradients reach zero the
parameters are at the bottom of the loss surface — there is no direction left to
move that reduces the error. For a straight-line model this bottom is guaranteed to
exist and to be unique: the loss surface is a smooth bowl with one lowest point.
Gradient descent always finds it. That guarantee does not hold for neural networks,
which is why later chapters need more careful treatment.

The remaining loss of 34.7 is noise: the data does not fall perfectly on a line, so
a line cannot fit it perfectly. It is not a sign of failure — it is the floor.

The slope of 10.73 means each extra minute of eruption predicts about 11 more minutes
of waiting. The bias of 70.90 is the expected wait after an average eruption.

== Inference

With training done the parameters are fixed and `predict` is called directly:

```
inference — how long to wait after an eruption?
  2.0 min eruption → 54.9 min wait
  3.0 min eruption → 65.7 min wait
  4.0 min eruption → 76.4 min wait
  5.0 min eruption → 87.1 min wait
```

A short 2-minute eruption predicts a ~55-minute wait. A long 5-minute eruption
predicts an ~87-minute wait. These numbers match the published guidance at the park
closely, which is not surprising: a linear fit of the same data is how that guidance
is computed.

== What the loop is doing

We started with two numbers at zero. We fed in 272 real observations, measured the
total prediction error, computed which direction to move each parameter, and moved.
After 200 repetitions, the parameters encoded the relationship between eruption
length and waiting time — without being told what that relationship was.

Later chapters replace `predict` with a neural network or a transformer. The loop
around it — forward pass, error, gradient, update — stays exactly the same.

== Suggested experiments

- *Remove the centering step* (`mu = 0`, skip the subtraction) and observe how many
  steps it takes to converge with the same `lr`, or whether it converges at all.
- *Raise `lr` to 0.5* and watch the loss explode on step one — this is what happens
  when the step size overshoots the bottom of the bowl.
- *Set `steps = 10`* and see how far from the final values the parameters land after
  only ten updates.
- *Predict for an eruption of 1.0 minutes* — the model will give an answer, but the
  shortest eruption in the data is 1.6 minutes. Note what extrapolation does.
