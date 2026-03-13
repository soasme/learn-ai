Linear regression is the smallest supervised learning loop that still shows the
whole machine: data, model, loss, gradient descent, and inference. This chapter
builds a tiny dataset from a hidden line and learns `weight` and `bias` with
hand-written gradients.

== What to watch

- `make_dataset` adds a fixed noise pattern, so every run fits the same target.
- `weight * x + bias` is the whole model.
- `error = weight * x + bias - y` feeds both gradients.
- `2 / n` turns the accumulated residuals into mean squared error gradients.
- The learned line should settle near `2.5x - 1.0`.

Because the gradients are explicit, you can see exactly what later chapters
will hand over to backpropagation and autograd.

== Suggested experiments

- Remove the noise pattern and watch the fit land almost exactly on the target.
- Increase the learning rate and watch the line overshoot.
- Change the target weight or bias and rerun the file.
