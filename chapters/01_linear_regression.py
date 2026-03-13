from random import Random


rng = Random(7)
true_w, true_b = 3.0, 1.0
x = [(-1 + 2 * i / 31) for i in range(32)]
y = [true_w * xi + true_b + 0.1 * rng.gauss(0, 1) for xi in x]

w, b = rng.gauss(0, 1), 0.0
lr, steps = 0.2, 200
n = len(x)
checkpoints = {0, 1, 2, 5, 10, 50, steps - 1}

for step in range(steps):
    pred = [xi * w + b for xi in x]
    error = [pi - yi for pi, yi in zip(pred, y)]
    loss = sum(e * e for e in error) / n
    grad_w = 2 * sum(xi * e for xi, e in zip(x, error)) / n
    grad_b = 2 * sum(error) / n
    w -= lr * grad_w
    b -= lr * grad_b
    if step in checkpoints:
        print(f"step={step:>3} loss={loss:.4f} w={w:.3f} b={b:.3f}")

final_pred = [xi * w + b for xi in x]
final_loss = sum((pi - yi) ** 2 for pi, yi in zip(final_pred, y)) / n
print(f"\nlearned line: y = {w:.3f}x + {b:.3f}")
print(f"target line:  y = {true_w:.1f}x + {true_b:.1f}")
print(f"final mse:    {final_loss:.4f}")

print("\npredictions:")
for xi in (-0.5, 0.0, 0.5):
    yi = xi * w + b
    print(f"x={xi:>4.1f} -> y={yi:.3f}")
