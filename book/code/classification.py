import math

TARGET_WX = 1.8
TARGET_WY = -1.2
TARGET_BIAS = -0.4


def make_dataset() -> tuple[list[tuple[float, float]], list[int]]:
    points = [(x / 2, y / 2) for x in range(-4, 5, 2) for y in range(-4, 5, 2)]
    noisy_points = {(-1.0, -2.0), (0.0, 0.0)}
    labels = []
    for x, y in points:
        label = int(TARGET_WX * x + TARGET_WY * y + TARGET_BIAS > 0)
        labels.append(1 - label if (x, y) in noisy_points else label)
    return points, labels


def sigmoid(value: float) -> float:
    if value >= 0:
        return 1.0 / (1.0 + math.exp(-value))
    exp_value = math.exp(value)
    return exp_value / (1.0 + exp_value)


def predict_prob(wx: float, wy: float, bias: float, point: tuple[float, float]) -> float:
    x, y = point
    return sigmoid(wx * x + wy * y + bias)


def evaluate(
    wx: float,
    wy: float,
    bias: float,
    points: list[tuple[float, float]],
    labels: list[int],
) -> tuple[float, float]:
    loss = correct = 0.0

    for point, label in zip(points, labels):
        prob = min(max(predict_prob(wx, wy, bias, point), 1e-6), 1 - 1e-6)
        loss -= label * math.log(prob) + (1 - label) * math.log(1 - prob)
        correct += int((prob >= 0.5) == bool(label))

    count = len(points)
    return loss / count, correct / count


def train(
    points: list[tuple[float, float]], labels: list[int], steps: int = 200, lr: float = 0.8
) -> tuple[float, float, float]:
    wx = wy = bias = 0.0
    scale = lr / len(points)

    for step in range(1, steps + 1):
        wx_grad = wy_grad = bias_grad = 0.0

        for point, label in zip(points, labels):
            x, y = point
            error = predict_prob(wx, wy, bias, point) - label
            wx_grad += error * x
            wy_grad += error * y
            bias_grad += error

        wx -= scale * wx_grad
        wy -= scale * wy_grad
        bias -= scale * bias_grad

        if step == 1 or step % 50 == 0 or step == steps:
            loss, acc = evaluate(wx, wy, bias, points, labels)
            print(
                f"step={step:03d} loss={loss:.4f} "
                f"acc={acc:.2f} wx={wx:.3f} wy={wy:.3f} bias={bias:.3f}"
            )

    return wx, wy, bias


def main() -> None:
    points, labels = make_dataset()
    wx, wy, bias = train(points, labels)

    print(f"\ndecision boundary: {wx:.3f}x {wy:+.3f}y {bias:+.3f} = 0")
    print("\ninference")
    for point in [(-1.5, 1.0), (0.0, 0.0), (1.5, -1.0)]:
        prob = predict_prob(wx, wy, bias, point)
        print(f"point={point} -> p(class 1)={prob:.3f} class={int(prob >= 0.5)}")


if __name__ == "__main__":
    main()
