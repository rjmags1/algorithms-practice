# 362. Design Hit Counter - Medium

Design a hit counter which counts the number of hits received in the past `5` minutes (i.e., the past `300` seconds).

Your system should accept a `timestamp` parameter (in seconds granularity), and you may assume that calls are being made to the system in chronological order (i.e., `timestamp` is monotonically increasing). Several hits may arrive roughly at the same time.

Implement the `HitCounter` class:

- `HitCounter()` Initializes the object of the hit counter system.
- `void hit(int timestamp)` Records a hit that happened at `timestamp` (in seconds). Several hits may happen at the same `timestamp`.
- `int getHits(int timestamp)` Returns the number of hits in the past 5 minutes from `timestamp` (i.e., the past `300` seconds).


##### Example 1:

```
Input
["HitCounter", "hit", "hit", "hit", "getHits", "hit", "getHits", "getHits"]
[[], [1], [2], [3], [4], [300], [300], [301]]
Output
[null, null, null, null, 3, null, 4, 3]

Explanation
HitCounter hitCounter = new HitCounter();
hitCounter.hit(1);       // hit at timestamp 1.
hitCounter.hit(2);       // hit at timestamp 2.
hitCounter.hit(3);       // hit at timestamp 3.
hitCounter.getHits(4);   // get hits at timestamp 4, return 3.
hitCounter.hit(300);     // hit at timestamp 300.
hitCounter.getHits(300); // get hits at timestamp 300, return 4.
hitCounter.getHits(301); // get hits at timestamp 301, return 3.
```

##### Constraints:

- <code>1 <= timestamp <= 2 * 10<sup>9</sup></code>
- All the calls are being made to the system in chronological order (i.e., `timestamp` is monotonically increasing).
- At most `300` calls will be made to `hit` and `getHits`.

Follow-up: What if the number of hits per second could be huge? Does your design scale?

## Solution

```
from collections import deque, OrderedDict

# Overall Space: O(k) where k is the time range in seconds
class HitCounter:
    TRANGE = 300
    
    # Time: O(1)
    def __init__(self):
        self.window = deque([])
        self.stamps = OrderedDict()

    # Time: O(k)
    def clean(self, timestamp):
        while self.window and self.window[0] <= timestamp - self.TRANGE:
            self.window.popleft()
            self.stamps.popitem(last=False)

    # Time: O(1) amortized
    def hit(self, timestamp: int) -> None:
        self.clean(timestamp)
        if timestamp in self.stamps:
            self.stamps[timestamp] += 1
        else:
            self.stamps[timestamp] = 1
            self.window.append(timestamp)

    # Time: O(k)
    def getHits(self, timestamp: int) -> int:
        self.clean(timestamp)
        return sum([self.stamps[ts] for ts in self.window])
```

## Notes
- We only want to keep the relevant timestamps and their associated hit counts in memory; if we wanted to store all recorded hits we could do an asynchronous db/file write before removing irrelevant timestamps from memory via the pop operations in the above solutions. `OrderedDict` is perfect for this task, and we use a double ended queue to keep track of timestamps in the current 5-minute time range because the `OrderedDict` is not order-indexable (at least in the typical way).
- Could easily optimize getHits to be O(1) amortized if we kept an instance level stampsinwindow variable.