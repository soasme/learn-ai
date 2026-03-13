Linear regression is the smallest supervised learning system that still reveals
the full training loop. We make predictions with a line, measure error with mean
squared error, and update the parameters with gradient descent.

== What to watch

- The model is only two numbers: `weight` and `bias`.
- Training computes gradients directly from the mean squared error.
- The inference path is the same equation used during training.

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
- Print the gradients each step and compare them with the loss curve.
