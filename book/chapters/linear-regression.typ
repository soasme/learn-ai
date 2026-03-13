Linear regression is the smallest supervised learning loop that still feels like
real machine learning. We fit a line, measure mean squared error, and move the
parameters downhill with gradient descent.

== What to watch

- `make_dataset` builds a fixed line plus a small deterministic wobble.
- `train` computes loss and both gradients in one pass over the data.
- `predict` is the same equation used during training and inference.

== Why this chapter matters

This chapter sets the pattern for the rest of the book. In one small file you
can already see the whole workflow:

- choose parameters
- score predictions against data
- update them with gradients
- reuse the trained model on new inputs

Later chapters swap in richer models, but the loop stays recognizable.

== Suggested experiments

- Remove the wobble and watch the fit land almost exactly on `2.5x - 1`.
- Increase the learning rate until the updates start to overshoot.
- Print `weight_grad` and `bias_grad` each step to watch training settle.
