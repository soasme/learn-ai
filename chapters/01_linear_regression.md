# Chapter 1: Linear Regression

This chapter teaches the smallest possible supervised learning loop:
fit a line by gradient descent.

The runnable artifact is [`01_linear_regression.py`](/Users/soasme/.codex/worktrees/865b/learn-ml/chapters/01_linear_regression.py).
It generates toy data from `y = 3x + 1 + noise`, learns `w` and `b` with manual
gradients, and prints predictions for a few test points. The implementation uses
only the Python standard library so it runs in a bare environment.

What to inspect:

- `pred = [xi * w + b for xi in x]`: the model is just a line.
- `loss = sum(e * e for e in error) / n`: mean squared error in direct Python.
- `error = [pi - yi for pi, yi in zip(pred, y)]`: one residual list drives the whole update.
- `grad_w` and `grad_b`: the two scalar gradients for `y = wx + b`.
- the `learned line` and `target line` printout: a quick sanity check that training worked.

Try changing the noise level, learning rate, initial `w`, or number of steps and rerun the file.
