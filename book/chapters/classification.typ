Classification is the smallest step from fitting numbers to choosing between
labels. This chapter builds a tiny 2D dataset from a hidden straight boundary,
turns each score into a probability with a sigmoid, and learns the boundary
with binary cross-entropy.

== What to read in the code

- `make_dataset` creates labeled points from a hidden linear separator, then
  flips two close calls so the fit has a small amount of label noise.
- `predict_prob` is the whole model: two weights, one bias, then a sigmoid.
- `train` uses the logistic regression gradient `probability - label`, which is
  the same error signal larger classifiers use at their output layer.
- The learned line `wx * x + wy * y + bias = 0` is the decision boundary.

== Why logistic regression here

This keeps the training loop tiny while introducing the two ideas regression
does not need: probabilities and cross-entropy. Later chapters keep this same
loss-driven update pattern while replacing a line with deeper networks.

== Suggested experiments

- Remove the two flipped labels and watch the classifier become more confident.
- Lower the learning rate and compare how quickly the boundary settles down.
- Change `TARGET_WX`, `TARGET_WY`, or `TARGET_BIAS` and see how the separator
  rotates.
