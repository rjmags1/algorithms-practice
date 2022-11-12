# 170. Two Sum III - Data Structure Design - Easy

Design a data structure that accepts a stream of integers and checks if it has a pair of integers that sum up to a particular value.

Implement the `TwoSum` class:

- `TwoSum()` Initializes the `TwoSum` object, with an empty array initially.
- `void add(int number)` Adds `number` to the data structure.
- `boolean find(int value)` Returns `true` if there exists any pair of numbers whose sum is equal to value, otherwise, it returns `false`.

##### Example 1:

```
Input
["TwoSum", "add", "add", "add", "find", "find"]
[[], [1], [3], [5], [4], [7]]
Output
[null, null, null, null, true, false]

Explanation
TwoSum twoSum = new TwoSum();
twoSum.add(1);   // [] --> [1]
twoSum.add(3);   // [1] --> [1,3]
twoSum.add(5);   // [1,3] --> [1,3,5]
twoSum.find(4);  // 1 + 3 = 4, return true
twoSum.find(7);  // No two integers sum up to 7, return false
```

##### Constraints:

- <code>-10<sup>5</sup> <= number <= 10<sup>5</sup></code>
- <code>-2<sup>31</sup> <= value <= 2<sup>31</sup> - 1</code>
- At most <code>10<sup>4</sup></code> calls will be made to add and find.

## Solution

```
# Time: O(n)
# Space: O(n)
class TwoSum:
    def __init__(self):
        self.freqs = defaultdict(int)

    def add(self, number: int) -> None:
        self.freqs[number] += 1
        
    def find(self, value: int) -> bool:
        for num, freq in self.freqs.items():
            diff = value - num
            if diff in self.freqs:
                if diff != num or freq > 1 :
                    return True
        return False
```

## Notes
- Pretty straightforward, could also sort a list of added nums for each call to `find` but would not be as efficient.