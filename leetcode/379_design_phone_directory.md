# 379. Design Phone Directory - Medium

Design a phone directory that initially has `maxNumbers` empty slots that can store numbers. The directory should store numbers, check if a certain slot is empty or not, and empty a given slot.

Implement the `PhoneDirectory` class:

- `PhoneDirectory(int maxNumbers)` Initializes the phone directory with the number of available slots `maxNumbers`.
- `int get()` Provides a number that is not assigned to anyone. Returns `-1` if no number is available.
- `bool check(int number)` Returns `true` if the slot number is available and `false` otherwise.
- `void release(int number)` Recycles or releases the slot `number`.


##### Example 1:

```
Input
["PhoneDirectory", "get", "get", "check", "get", "check", "release", "check"]
[[3], [], [], [2], [], [2], [2], [2]]
Output
[null, 0, 1, true, 2, false, null, true]

Explanation
PhoneDirectory phoneDirectory = new PhoneDirectory(3);
phoneDirectory.get();      // It can return any available phone number. Here we assume it returns 0.
phoneDirectory.get();      // Assume it returns 1.
phoneDirectory.check(2);   // The number 2 is available, so return true.
phoneDirectory.get();      // It returns 2, the only number that is left.
phoneDirectory.check(2);   // The number 2 is no longer available, so return false.
phoneDirectory.release(2); // Release number 2 back to the pool.
phoneDirectory.check(2);   // Number 2 is available again, return true.
```

##### Constraints:

- <code>1 <= maxNumbers <= 10<sup>4</sup></code>
- <code>0 <= number < maxNumbers</code>
- At most <code>2 * 10<sup>4</sup></code> calls will be made to `get`, `check`, and `release`.

## Solution

```
# Overall Space: O(n)
class PhoneDirectory:

    def __init__(self, maxNumbers: int):
        self.q = [i for i in range(maxNumbers)]
        self.taken = [False] * maxNumbers

    # Time: O(1)
    def get(self) -> int:
        if len(self.q) == 0:
            return -1
        number = self.q.pop()
        self.taken[number] = True
        return number

    # Time: O(1)
    def check(self, number: int) -> bool:
        return not self.taken[number]

    # Time: O(1)
    def release(self, number: int) -> None:
        if self.taken[number]:
            self.taken[number] = False
            self.q.append(number)
```

## Notes
- Use an `O(1)` removal data structure to hold available numbers and an `O(1)` lookup data structure to keep track of which numbers are not in the set of available numbers. Be sure to avoid releasing non-taken numbers.