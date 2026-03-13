Linear regression is the smallest model that still shows the whole learning
loop. This file fits `y = weight * x + bias` to synthetic points, measures mean
squared error, and updates the two parameters with hand-written gradients.

== What to watch

- `make_dataset` creates noisy points near one line, so we know what training
  should recover.
- `train` keeps the whole algorithm in view: predict, measure error, take one
  gradient step.
- `predict` is reused for both training and inference, so there is no hidden
  second code path.

== Why gradient descent here

Linear regression also has a closed-form solution, but gradient descent is the
better teaching tool. The same loop survives when later chapters replace a line
with a neural network or a transformer.

== Suggested experiments

- Raise `lr` until the loss starts exploding.
- Change the slope or intercept inside `make_dataset` and see what training
  recovers.
- Remove the noise term and notice how close the learned parameters get to the
  exact line.
