Linear regression is the smallest model that still shows the complete learning loop.
We define data, make predictions, measure error, compute gradients, and update
parameters — the same cycle that trains neural networks and transformers.

This chapter predicts how long a visitor must wait for the next eruption of Old
Faithful geyser, given how long the current eruption lasted. The model is a single
line. The data is real.

== The data

Old Faithful, in Yellowstone National Park, erupts regularly. Rangers and visitors
have noticed that longer eruptions tend to be followed by longer waits. We download
272 recorded observations to find out exactly how strong that relationship is:

```mermaid
flowchart LR
    geyser[Old Faithful] --> csv[faithful.csv]
    csv --> xs[eruption durations]
    csv --> ys[waiting times]
    xs --> center[subtract mean]
    center --> xs_c[centered xs]
    xs_c --> train
    ys --> train
```


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
`ys` holds the wait until the next eruption (43 – 96 minutes). Eruption durations
cluster around two modes: short eruptions (~2 min) and long ones (~4.5 min), which
is the famous bimodal pattern of Old Faithful.

Before training we center the eruption durations around their mean. This decouples
the weight and bias updates, so gradient descent converges in far fewer steps:

```python
mu = sum(xs) / len(xs)
xs = [x - mu for x in xs]
```

After centering, `xs` has mean zero. The mean eruption duration is about 3.49 minutes.

== The model

```mermaid
flowchart LR
    x[eruption duration] --> predict
    weight --> predict
    bias --> predict
    predict --> y_hat[predicted wait]
    y_hat --> error[error vs actual]
    error --> weight
    error --> bias
```

The model is one line of arithmetic:

```python
def predict(weight, bias, x):
    return weight * x + bias
```

`x` is the centered eruption duration. `weight` is the slope — how many extra
minutes of waiting each extra minute of eruption buys. `bias` is the baseline
waiting time for an average-length eruption. Both start at zero and are adjusted
by gradient descent.

== Gradient descent

The loss is the average squared prediction error across all observations. We want to
reduce it by adjusting `weight` and `bias`. For each data point, the error is:

```python
error = predict(weight, bias, x) - y
```

If `error` is positive the prediction is too high; if negative, too low. The key
insight is that `error * x` tells us how much `weight` is to blame, and `error`
alone tells us how much `bias` is to blame. We accumulate those blame signals across
all 272 eruptions and subtract a scaled version from each parameter:

```python
for x, y in zip(xs, ys):
    error = predict(weight, bias, x) - y
    weight_grad += error * x
    bias_grad   += error

weight -= scale * weight_grad
bias   -= scale * bias_grad
```

`scale = 2.0 * lr / n` bundles the learning rate and the batch size into one factor.
The learning rate `lr` controls how far we move each step.

== Training

We run 200 steps. The loss starts large (parameters are wrong) and falls to a
stable floor — the irreducible noise in the data:

```
step=001  loss=4219.250  weight=1.393  bias=7.090
step=050  loss=34.852    weight=10.719  bias=70.532
step=100  loss=34.718    weight=10.730  bias=70.895
step=150  loss=34.718    weight=10.730  bias=70.897
step=200  loss=34.718    weight=10.730  bias=70.897
```

By step 100 the parameters have stopped changing. The slope of 10.73 means each
extra minute of eruption predicts about 11 more minutes of waiting. The bias of
70.90 is the expected wait after an average-length eruption. This matches what a
least-squares solver would give — gradient descent found the same answer through
repeated nudges.

== Inference

With training done we make predictions for new eruption durations — including values
the model was never explicitly asked to fit:

```
inference — how long to wait after an eruption?
  2.0 min eruption → 54.9 min wait
  3.0 min eruption → 65.7 min wait
  4.0 min eruption → 76.4 min wait
  5.0 min eruption → 87.1 min wait
```

A visitor who just watched a short 2-minute eruption can expect to wait about
55 minutes. A visitor who watched the full 5-minute show should plan for 87 minutes.
Rangers post these predictions at the geyser. The model we just trained is, roughly,
what they use.

== What the loop is doing

We started with two numbers at zero. We fed in 272 real observations, measured the
total prediction error, computed which direction to move each parameter, and moved.
After 200 repetitions, the parameters encoded the relationship between eruption
length and waiting time — without being told what that relationship was.

This is the heart of machine learning. Every chapter in this book extends or replaces
one piece of this loop, but the loop itself does not change.

== Suggested experiments

- *Print the first few rows* to see what the raw data looks like before centering.
- *Remove the centering step* and watch how many steps it takes to converge —
  or whether it converges at all with the same learning rate.
- *Raise `lr` to 0.5* and observe the loss exploding instead of falling.
- *Predict for an eruption of 1.0 minutes* — does the model's answer seem reasonable
  given the data range?
