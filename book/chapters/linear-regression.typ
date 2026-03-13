Linear regression is the smallest supervised learning loop that still feels like
real machine learning. This chapter builds a tiny fixed dataset from a hidden
line, measures mean squared error, and learns `weight` and `bias` with direct
gradient updates.

== What to read in the code

- `make_dataset` creates a repeatable noisy line from `TARGET_WEIGHT` and `TARGET_BIAS`.
- `predict` is the whole model: `weight * x + bias`.
- `train` computes loss and both gradients in one pass over the data.
- The learned line should settle near `2.5x - 1.0`.

== Why this chapter matters

Even with only two parameters, this chapter already shows the full pattern used
throughout the book: choose parameters, score predictions, update them with
gradients, then reuse the trained model for inference.

== Suggested experiments

- Remove the wobble term and watch the fit land almost exactly on the target.
- Increase the learning rate until the updates start to overshoot.
- Print `weight_grad` and `bias_grad` each step to watch training settle.
