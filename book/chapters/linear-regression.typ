Linear regression is the smallest supervised learning loop. This chapter builds a
tiny dataset from a hidden line, measures mean squared error, and learns
`weight` and `bias` with hand-written gradients.

== What to watch

- `make_dataset` adds a fixed noise pattern, so every run fits the same target.
- `weight` and `bias` are the whole model.
- `error = weight * x + bias - y` feeds both gradients.
- `2 / n` turns the accumulated residuals into mean squared error gradients.
- The logged loss and final predictions should settle near `weight = 2.5` and
  `bias = -1.0`.

== Suggested experiments

- Remove the noise pattern and watch the fit land almost exactly on the target.
- Increase the learning rate and watch the line overshoot.
- Change the target weight or bias and rerun the file.
