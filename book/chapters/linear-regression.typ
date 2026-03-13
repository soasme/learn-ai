Linear regression is the smallest supervised learning system that still shows
the whole training loop. We fit a line, measure mean squared error, and move two
parameters downhill with gradient descent.

== What to watch

- The dataset is just a list of `(x, y)` points sampled from a hidden line.
- The model is only two numbers: `weight` and `bias`.
- Training makes one pass over the data to accumulate loss and gradients.
- The logged loss, learned line, and target line give you a quick convergence check.

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

The synthetic dataset is a noisy line, so the learned parameters should settle
near `weight = 2.5` and `bias = -1.0`. That gives the reader an immediate check
that gradient descent is moving in the right direction.

== Suggested experiments

- Remove the synthetic noise and watch the line fit almost perfectly.
- Increase the learning rate and watch training diverge.
- Change the synthetic data generator to a different line.
- Print `weight_grad` and `bias_grad` each step and compare them with the loss.
