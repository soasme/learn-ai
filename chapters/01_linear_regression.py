from random import Random


rng = Random(7)
x = [(-1 + 2 * i / 31) for i in range(32)]
y = [3 * xi + 1 + 0.1 * rng.gauss(0, 1) for xi in x]

w, b = rng.gauss(0, 1), 0.0
lr = 0.2

for step in range(200):
    pred = [xi * w + b for xi in x]
    error = [pi - yi for pi, yi in zip(pred, y)]
    loss = sum(e * e for e in error) / len(error)
    w -= lr * sum(2 * xi * e for xi, e in zip(x, error)) / len(x)
    b -= lr * sum(2 * error) / len(error)
    if step in {0, 1, 2, 5, 10, 50, 199}:
        print(f"step={step:>3} loss={loss:.4f} w={w:.3f} b={b:.3f}")

print("\npredictions:")
for xi in (-0.5, 0.0, 0.5):
    yi = xi * w + b
    print(f"x={xi:>4.1f} -> y={yi:.3f}")
