Linear regression is the smallest supervised learning loop that still contains
the whole machine: data, model, loss, gradient descent, and inference. The
model itself is only one line: `y = weight * x + bias`.

== What to watch

- `make_dataset` generates noisy points from a hidden line.
- `predict` is the whole model: two parameters and one multiply-add.
- `train` writes the mean squared error gradients out by hand.

Because the gradients are explicit, you can see exactly what later chapters
will hand over to backpropagation and autograd.

== Suggested experiments

- Increase the learning rate and watch training diverge.
- Change the synthetic data generator to a different line.
- Print the gradients each step and compare them with the loss curve.
