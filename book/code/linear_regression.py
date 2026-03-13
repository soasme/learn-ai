from __future__ import annotations


def make_dataset() -> tuple[list[float], list[float]]:
    xs = [value / 10 for value in range(-20, 21)]
    ys = [
        2.5 * x - 1.0 + 0.15 * ((index % 5) - 2)
        for index, x in enumerate(xs)
    ]
    return xs, ys


def predict(weight: float, bias: float, x: float) -> float:
    return weight * x + bias


def train(
    xs: list[float], ys: list[float], steps: int = 400, lr: float = 0.05
) -> tuple[float, float]:
    weight = 0.0
    bias = 0.0
    count = len(xs)
    scale = 2.0 / count

    for step in range(steps):
        loss = 0.0
        weight_grad = 0.0
        bias_grad = 0.0
        for x, y in zip(xs, ys):
            error = predict(weight, bias, x) - y
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
    xs, ys = make_dataset()
    weight, bias = train(xs, ys)

    print("\ninference")
    for x in (-1.5, 0.0, 1.5):
        y = predict(weight, bias, x)
        print(f"x={x:>4.1f} -> y={y:.3f}")


if __name__ == "__main__":
    main()
