from __future__ import annotations

TARGET_WEIGHT = 2.5
TARGET_BIAS = -1.0


def make_dataset() -> list[tuple[float, float]]:
    return [
        (x, TARGET_WEIGHT * x + TARGET_BIAS + 0.15 * ((index % 5) - 2))
        for index, x in enumerate(value / 10 for value in range(-20, 21))
    ]


def train(
    points: list[tuple[float, float]], steps: int = 400, lr: float = 0.05
) -> tuple[float, float]:
    weight = bias = 0.0
    count = len(points)
    scale = 2.0 / count

    for step in range(steps):
        loss = weight_grad = bias_grad = 0.0
        for x, y in points:
            error = weight * x + bias - y
            loss += error * error
            weight_grad += error * x
            bias_grad += error

        weight -= lr * scale * weight_grad
        bias -= lr * scale * bias_grad

        if step % 100 == 0 or step == steps - 1:
            print(
                f"step={step:03d} loss={loss / count:.6f} "
                f"weight={weight:.3f} bias={bias:.3f}"
            )

    return weight, bias


def main() -> None:
    weight, bias = train(make_dataset())

    print(f"\nlearned line: y = {weight:.3f}x {bias:+.3f}")
    print(f"target  line: y = {TARGET_WEIGHT:.3f}x {TARGET_BIAS:+.3f}")
    print("\ninference")
    for x in (-1.5, 0.0, 1.5):
        print(f"x={x:>4.1f} -> y={weight * x + bias:.3f}")


if __name__ == "__main__":
    main()
