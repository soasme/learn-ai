from __future__ import annotations

from statistics import mean


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

    for step in range(steps):
        predictions = [predict(weight, bias, x) for x in xs]
        errors = [prediction - y for prediction, y in zip(predictions, ys)]
        loss = mean(error * error for error in errors)

        # For mean squared error, the gradients stay simple and readable.
        weight_grad = 2.0 / count * sum(error * x for error, x in zip(errors, xs))
        bias_grad = 2.0 / count * sum(errors)

        weight -= lr * weight_grad
        bias -= lr * bias_grad

        if step % 100 == 0 or step == steps - 1:
            print(
                f"step={step:03d} loss={loss:.6f} "
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
