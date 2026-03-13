Linear regression is the smallest supervised learning system that still reveals
the full training loop. We make predictions with a line, measure error with mean
squared error, and update the parameters with gradient descent.

== What to watch

- The dataset is just a list of `(x, y)` points sampled from a hidden line.
- The model is only two numbers: `weight` and `bias`.
- Training computes the mean squared error gradients directly, without helpers.
- The logged loss now matches the parameters printed on the same line.

== Why this chapter matters

This chapter sets the tone for the book. It is short enough to read in one
sitting, but it already contains the full machine learning loop:

- define a model
- prepare data
- compute loss
- update parameters
- run inference on unseen inputs

Once this structure is clear, later chapters can swap in more interesting models
without changing the reader's mental frame.

== Suggested experiments

- Increase the learning rate and watch training diverge.
- Change the synthetic data generator to a different line.
- Print `weight_grad` and `bias_grad` each step and compare them with the loss.
