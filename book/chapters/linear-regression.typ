Linear regression is the smallest supervised learning system that still shows
the whole loop: data, prediction, loss, parameter updates, and inference. This
chapter builds a tiny dataset from a hidden line and learns `weight` and `bias`
with hand-written gradients.

== What to read in the code

- `make_dataset` creates a fixed noisy line, so every run fits the same target.
- `predict` is the entire model: `weight * x + bias`.
- `train` turns residuals into mean squared error gradients and applies gradient descent.
- The learned line should settle near `2.5x - 1.0`.

== Why this chapter matters

Even with only two parameters, this chapter already has the structure used by
every later model in the book. Once that loop is clear here, deeper systems are
just richer versions of the same pattern.

== Suggested experiments

- Remove the noise pattern and watch the fit land almost exactly on the target.
- Increase the learning rate until training diverges.
- Change the target line in `make_dataset`.
