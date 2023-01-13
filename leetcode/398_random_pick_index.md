# 398. Random Pick Index - Medium

Given an integer array `nums` with possible duplicates, randomly output the index of a given `target` number. You can assume that the given target number must exist in the array.

Implement the `Solution` class:

- `Solution(int[] nums)` Initializes the object with the array `nums`.
- `int pick(int target)` Picks a random index `i` from nums where `nums[i] == target`. If there are multiple valid `i`'s, then each index should have an equal probability of returning.


##### Example 1:

```
Input
["Solution", "pick", "pick", "pick"]
[[[1, 2, 3, 3, 3]], [3], [1], [3]]
Output
[null, 4, 0, 2]

Explanation
Solution solution = new Solution([1, 2, 3, 3, 3]);
solution.pick(3); // It should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
solution.pick(1); // It should return 0. Since in the array only nums[0] is equal to 1.
solution.pick(3); // It should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
```

##### Constraints:

- <code>1 <= nums.length <= 2 * 10<sup>4</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>
- `target` is an integer from `nums`.
- At most <code>10<sup>4</sup></code> calls will be made to `pick`.

## Solution 1

```
from collections import defaultdict

# Space: O(n)
class Solution:
    # Time: O(n)
    def __init__(self, nums: List[int]):
        self.idxs = defaultdict(list)
        for i, num in enumerate(nums):
            self.idxs[num].append(i)

    # Time: O(1)
    def pick(self, target: int) -> int:
        return random.choice(self.idxs[target])
```

## Notes
- If we cared about not storing refs to elements of `nums` in our `Solution` instances, we would want to use modified reservoir sampling (only add desired numbers to the reservoir) to solve this problem, with the drawback that `pick` method would be have linear runtime. 