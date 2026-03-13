import os
import urllib.request

# Download Old Faithful geyser observations (272 eruptions, Yellowstone 1990)
if not os.path.exists('faithful.csv'):
    urllib.request.urlretrieve(
        'https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/faithful.csv',
        'faithful.csv',
    )

xs, ys = [], []
for line in open('faithful.csv').readlines()[1:]:
    _, eruption, waiting = line.strip().split(',')
    xs.append(float(eruption))   # duration in minutes
    ys.append(float(waiting))    # wait until next eruption (minutes)

print(f"num eruptions: {len(xs)}")

# Center eruption durations around their mean so gradient descent converges faster
mu = sum(xs) / len(xs)
xs = [x - mu for x in xs]


def predict(weight, bias, x):
    return weight * x + bias


def train(xs, ys, steps=200, lr=0.05):
    weight = bias = 0.0
    n = len(xs)
    scale = 2.0 * lr / n

    for step in range(1, steps + 1):
        weight_grad = bias_grad = 0.0
        for x, y in zip(xs, ys):
            error = predict(weight, bias, x) - y
            weight_grad += error * x
            bias_grad   += error

        weight -= scale * weight_grad
        bias   -= scale * bias_grad

        if step == 1 or step % 50 == 0 or step == steps:
            loss = sum((predict(weight, bias, x) - y) ** 2 for x, y in zip(xs, ys)) / n
            print(f"step={step:03d}  loss={loss:.3f}  weight={weight:.3f}  bias={bias:.3f}")

    return weight, bias


def main():
    weight, bias = train(xs, ys)

    print(f"\nlearned:  waiting = {weight:.2f} \u00d7 (eruption \u2212 {mu:.2f}) + {bias:.2f}")
    print(f"\ninference \u2014 how long to wait after an eruption?")
    for duration in (2.0, 3.0, 4.0, 5.0):
        wait = predict(weight, bias, duration - mu)
        print(f"  {duration:.1f} min eruption \u2192 {wait:.1f} min wait")


if __name__ == "__main__":
    main()
