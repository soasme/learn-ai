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
    weight = bias = 0.0
    scale = 2.0 / len(xs)

    for step in range(steps):
        errors = [predict(weight, bias, x) - y for x, y in zip(xs, ys)]
        loss = sum(error * error for error in errors) / len(errors)

        # For mean squared error, the gradients stay simple and readable.
        weight -= lr * scale * sum(error * x for error, x in zip(errors, xs))
        bias -= lr * scale * sum(errors)

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
