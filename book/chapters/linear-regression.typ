Linear regression is the smallest supervised learning system that still shows
the whole loop: data, prediction, loss, parameter updates, and inference.

== What to read in the code

- `make_dataset` creates a noisy line to fit.
- `predict` is the entire model: `weight * x + bias`.
- `train` computes mean squared error gradients and applies gradient descent.

== Why this chapter matters

Even with only two parameters, this chapter already has the structure used by
every later model in the book. Once that loop is clear here, deeper systems are
just richer versions of the same pattern.

== Suggested experiments

- Increase the learning rate until training diverges.
- Change the target line in `make_dataset`.
- Print the gradients inside `train` and compare them with the loss curve.
