Linear regression is the smallest model that still shows the complete learning loop.
We define data, make predictions, measure error, compute gradients, and update
parameters — the same cycle that trains neural networks and transformers.

This chapter trains a line `y = weight * x + bias` on synthetic noisy data, then
uses the learned parameters to make predictions. No libraries required: pure Python
arithmetic throughout.

== The data

We generate 41 points from a hidden target line `y = 2.5x − 1.0` with a small
repeating wobble added, so the fit is never exact:

```python
TARGET_WEIGHT = 2.5
TARGET_BIAS   = -1.0

def make_dataset():
    xs = [x / 10 for x in range(-20, 21)]
    return xs, [TARGET_WEIGHT * x + TARGET_BIAS + 0.15 * (i % 5 - 2)
                for i, x in enumerate(xs)]
```

The wobble term `0.15 * (i % 5 − 2)` cycles through `{−0.30, −0.15, 0.00, 0.15, 0.30}`.
It is small enough that gradient descent can recover the target, but large enough that
the learned line differs slightly from the exact values.

Because we generated the data ourselves, we know the right answer. Training should
recover something close to `weight = 2.5, bias = −1.0`. That lets us verify the
learning loop is working correctly.

== The model

The model is a single line of arithmetic:

```python
def predict(weight, bias, x):
    return weight * x + bias
```

There are only two parameters. `weight` controls the slope: how much `y` changes
when `x` increases by 1. `bias` shifts the line up or down. The goal of training
is to find the values of these two numbers that best fit the data.

== Gradient descent

We measure how wrong the model is using *mean squared error* (MSE):

$ "loss" = 1/n sum_(i) ("predict"(w, b, x_i) - y_i)^2 $

To reduce the loss, we compute how it changes with respect to each parameter. For
a single training point with `error = predict(w, b, x) − y`:

$ (partial "loss") / (partial w) = "error" dot x $

$ (partial "loss") / (partial b) = "error" $

We accumulate these contributions across all points and subtract a scaled version
from each parameter:

```python
for x, y in zip(xs, ys):
    error = predict(weight, bias, x) - y
    weight_grad += error * x
    bias_grad   += error

weight -= (2.0 * lr / count) * weight_grad
bias   -= (2.0 * lr / count) * bias_grad
```

The factor `2.0 / count` normalises for batch size and absorbs the constant from
differentiating the squared error. The learning rate `lr` controls how far we move
each step. Too large and the loss explodes; too small and training stalls.

This is the same idea that trains every model in this book. Later chapters replace
`predict` with a neural network and `weight_grad` with backpropagation — but the
outer structure stays identical.

== Training

The `train` function runs this loop for `steps` iterations and prints the loss at
key points so you can watch it fall:

```python
def train(xs, ys, steps=200, lr=0.05):
    weight = bias = 0.0
    count  = len(xs)
    scale  = 2.0 * lr / count

    for step in range(1, steps + 1):
        weight_grad = bias_grad = 0.0
        for x, y in zip(xs, ys):
            error = predict(weight, bias, x) - y
            weight_grad += error * x
            bias_grad   += error

        weight -= scale * weight_grad
        bias   -= scale * bias_grad

        if step == 1 or step % 50 == 0 or step == steps:
            loss = sum((predict(weight, bias, x) - y) ** 2
                       for x, y in zip(xs, ys)) / count
            print(f"step={step:03d} loss={loss:.6f} "
                  f"weight={weight:.3f} bias={bias:.3f}")

    return weight, bias
```

Both parameters start at zero. After the very first step the loss is already lower
because the model has moved in the direction that reduces error. By step 50 the
parameters are close to the target and refinements become increasingly small.

Over 200 steps the loss falls from a large initial value to a small residual:

```
step=001 loss=7.393518 weight=0.351 bias=-0.101
step=050 loss=0.045920 weight=2.509 bias=-1.002
step=100 loss=0.045891 weight=2.510 bias=-1.007
step=150 loss=0.045891 weight=2.510 bias=-1.007
step=200 loss=0.045891 weight=2.510 bias=-1.007
```

The loss does not reach zero because the wobble is real noise. But the learned
parameters settle close to the hidden target `weight = 2.5, bias = −1.0`. The
training loop has recovered the signal.

== Inference

With training done, the parameters are fixed and we call `predict` directly on
new inputs:

```python
for x in (-1.5, 0.0, 1.5):
    print(f"x={x:>4.1f} -> y={predict(weight, bias, x):.3f}")
```

```
learned line: y = 2.510x -1.007
target  line: y = 2.500x -1.000

inference
x=-1.5 -> y=-4.773
x= 0.0 -> y=-1.007
x= 1.5 -> y= 2.758
```

The model extrapolates cleanly beyond the training range. That is a property of
linear models: the line extends infinitely in both directions.

== What the loop is doing

It is worth pausing on what just happened.

We started with two numbers: `weight = 0, bias = 0`. We fed in 41 data points,
measured the total error, computed which direction to move each parameter, and
moved. We repeated that 200 times. At the end, the parameters encoded the hidden
line `y = 2.5x − 1.0` without ever being told what it was.

This is the essence of machine learning: iterative error reduction guided by
gradients. Every chapter in this book extends or replaces one piece of this loop,
but the loop itself never changes.

== Suggested experiments

- *Remove the wobble* and watch the loss fall to nearly zero and the parameters
  land almost exactly on `weight = 2.5, bias = −1.0`.
- *Raise `lr` to 0.5* and observe the loss exploding instead of falling — this is
  the learning rate instability that kills real training runs.
- *Set `steps = 10`* and compare how far from the target the model lands after
  only ten updates.
- *Change `TARGET_WEIGHT` and `TARGET_BIAS`* and verify that training recovers the
  new hidden line.
