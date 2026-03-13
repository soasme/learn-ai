from __future__ import annotations


def make_dataset() -> tuple[list[float], list[float]]:
    xs = [x / 10 for x in range(-20, 21)]
    return xs, [2.5 * x - 1.0 + 0.15 * ((i % 5) - 2) for i, x in enumerate(xs)]


def predict(weight: float, bias: float, x: float) -> float:
    return weight * x + bias


def train(
    xs: list[float], ys: list[float], steps: int = 400, lr: float = 0.05
) -> tuple[float, float]:
    weight = bias = 0.0
    count = len(xs)
    scale = 2.0 / count

    for step in range(1, steps + 1):
        errors = [predict(weight, bias, x) - y for x, y in zip(xs, ys)]
        weight -= lr * scale * sum(error * x for error, x in zip(errors, xs))
        bias -= lr * scale * sum(errors)

        if step == 1 or step % 100 == 0 or step == steps:
            errors = [predict(weight, bias, x) - y for x, y in zip(xs, ys)]
            loss = sum(error * error for error in errors) / count
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
        print(f"x={x:>4.1f} -> y={predict(weight, bias, x):.3f}")


if __name__ == "__main__":
    main()
