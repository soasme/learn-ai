Linear regression is the smallest model that still shows the whole learning
loop. This chapter builds a repeatable noisy line from a hidden target,
measures mean squared error, and learns `weight` and `bias` with direct
gradient updates.

== What to read in the code

- `make_dataset` creates a noisy line from `TARGET_WEIGHT` and `TARGET_BIAS`,
  so we know what training should recover.
- `predict` is the whole model: `weight * x + bias`.
- `train` computes both gradients directly, updates the parameters, then
  reports the loss of the updated model.
- The learned line should settle near `2.5x - 1.0`.

== Why gradient descent here

Linear regression has a closed-form solution, but gradient descent is the
better teaching tool. The same loop survives when later chapters replace a line
with a neural network or a transformer.

== Suggested experiments

- Remove the wobble term and watch the fit land almost exactly on the target.
- Raise `lr` until the loss starts exploding.
- Change `TARGET_WEIGHT` or `TARGET_BIAS` and see what training recovers.
