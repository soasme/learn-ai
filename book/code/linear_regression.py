TARGET_WEIGHT = 2.5
TARGET_BIAS = -1.0


def make_dataset() -> tuple[list[float], list[float]]:
    xs = [x / 10 for x in range(-20, 21)]
    return xs, [TARGET_WEIGHT * x + TARGET_BIAS + 0.15 * (i % 5 - 2) for i, x in enumerate(xs)]


def predict(weight: float, bias: float, x: float) -> float:
    return weight * x + bias


def train(
    xs: list[float], ys: list[float], steps: int = 200, lr: float = 0.05
) -> tuple[float, float]:
    weight = bias = 0.0
    count = len(xs)
    scale = 2.0 * lr / count

    for step in range(1, steps + 1):
        weight_grad = bias_grad = 0.0
        for x, y in zip(xs, ys):
            error = predict(weight, bias, x) - y
            weight_grad += error * x
            bias_grad += error

        weight -= scale * weight_grad
        bias -= scale * bias_grad

        if step == 1 or step % 50 == 0 or step == steps:
            loss = sum((predict(weight, bias, x) - y) ** 2 for x, y in zip(xs, ys)) / count
            print(
                f"step={step:03d} loss={loss:.6f} "
                f"weight={weight:.3f} bias={bias:.3f}"
            )

    return weight, bias


def main() -> None:
    xs, ys = make_dataset()
    weight, bias = train(xs, ys)

    print(f"\nlearned line: y = {weight:.3f}x {bias:+.3f}")
    print(f"target  line: y = {TARGET_WEIGHT:.3f}x {TARGET_BIAS:+.3f}")
    print("\ninference")
    for x in (-1.5, 0.0, 1.5):
        print(f"x={x:>4.1f} -> y={predict(weight, bias, x):.3f}")


if __name__ == "__main__":
    main()
