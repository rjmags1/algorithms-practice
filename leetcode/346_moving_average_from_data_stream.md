# 346. Moving Average From Data Stream - Easy

Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

Implement the `MovingAverage` class:

- `MovingAverage(int size)` Initializes the object with the size of the window `size`.
- `double next(int val)` Returns the moving average of the last `size` values of the stream.


##### Example 1:

```
Input
["MovingAverage", "next", "next", "next", "next"]
[[3], [1], [10], [3], [5]]
Output
[null, 1.0, 5.5, 4.66667, 6.0]

Explanation
MovingAverage movingAverage = new MovingAverage(3);
movingAverage.next(1); // return 1.0 = 1 / 1
movingAverage.next(10); // return 5.5 = (1 + 10) / 2
movingAverage.next(3); // return 4.66667 = (1 + 10 + 3) / 3
movingAverage.next(5); // return 6.0 = (10 + 3 + 5) / 3
```

##### Constraints:

- `1 <= size <= 1000`
- <code>-10<sup>5</sup> <= val <= 10<sup>5</sup></code>
- At most <code>10<sup>4</sup></code> calls will be made to next.

## Solution

```
# Time: O(1) all methods
# Space: O(k) if k == size
class MovingAverage:
    def __init__(self, size: int):
        self.q = deque([])
        self.cap = size
        self.sum = 0

    def next(self, val: int) -> float:
        self.q.append(val)
        self.sum += val
        if len(self.q) == self.cap + 1:
            self.sum -= self.q.popleft()
        return self.sum / len(self.q)
```

## Notes
- To know the `size + 1`th value to remove from a `MovingAverage` instance when we exceed `size`, we need a queue.