Linear regression is the smallest supervised learning system that still shows
the full training loop. We fit a line, measure mean squared error, and move the
parameters with gradient descent.

== What to watch

- The whole model is just `weight` and `bias`.
- Each step makes one pass over the data, accumulating loss and gradients
  together.
- The synthetic data comes from a noisy version of `y = 2.5x - 1.0`, so we know
  what the fit should recover.

== Why this chapter matters

This chapter sets the tone for the book. It is short enough to read in one
sitting, but it already contains the full machine learning loop:

- define a model
- prepare data
- compute loss
- update parameters
- run inference on unseen inputs

Once this loop is familiar, later chapters mainly replace the line with richer
models.

== Suggested experiments

- Remove the repeating noise term and watch the fit land almost exactly on the
  target line.
- Increase the learning rate and watch the loss stop settling down.
- Print `weight_grad` and `bias_grad` to see why the updates shrink near
  convergence.
