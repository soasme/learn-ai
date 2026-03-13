Linear regression is the smallest supervised learning system that still shows
the whole training loop. We fit a line, measure mean squared error, and move two
parameters downhill with gradient descent.

== What to watch

- The model is only two numbers: `weight` and `bias`.
- Each step accumulates loss, the weight gradient, and the bias gradient.
- The inference path is the same equation used during training.

== Why this chapter matters

This chapter sets the tone for the book. It is short enough to read in one
sitting, but it already contains the full machine learning loop:

- define a model
- prepare data
- compute loss
- update parameters
- run inference on unseen inputs

Once this structure is clear, later chapters can replace the line with more
interesting models without changing the reader's mental frame.

== Suggested experiments

- Remove the synthetic noise and watch the line fit almost perfectly.
- Increase the learning rate and watch training diverge.
- Change the synthetic data generator to a different line.
- Print the gradients each step and compare them with the loss curve.
