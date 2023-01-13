# 384. Shuffle an Array - Medium

Given an integer array `nums`, design an algorithm to randomly shuffle the array. All permutations of the array should be equally likely as a result of the shuffling.

Implement the `Solution` class:

- `Solution(int[] nums)` Initializes the object with the integer array `nums`.
- `int[] reset()` Resets the array to its original configuration and returns it.
- `int[] shuffle()` Returns a random shuffling of the array.


##### Example 1:

```
Input
["Solution", "shuffle", "reset", "shuffle"]
[[[1, 2, 3]], [], [], []]
Output
[null, [3, 1, 2], [1, 2, 3], [1, 3, 2]]

Explanation
Solution solution = new Solution([1, 2, 3]);
solution.shuffle();    // Shuffle the array [1,2,3] and return its result.
                       // Any permutation of [1,2,3] must be equally likely to be returned.
                       // Example: return [3, 1, 2]
solution.reset();      // Resets the array back to its original configuration [1,2,3]. Return [1, 2, 3]
solution.shuffle();    // Returns the random shuffling of array [1,2,3]. Example: return [1, 3, 2]
```

##### Constraints:

- <code>1 <= nums.length <= 50</code>
- <code>-10<sup>6</sup> <= nums[i] <= 10<sup>6</sup></code>
- All the elements of `nums` are unique.
- At most <code>10<sup>4</sup></code> calls in total will be made to `reset` and `shuffle`.

## Solution

```
# Overall Space: O(n)
class Solution:
    # Time: O(n)
    def __init__(self, nums: List[int]):
        self.orig = nums
        self.n = len(nums)
        self.copy = nums[:]

    # Time: O(1)
    def reset(self) -> List[int]:
        return self.orig

    # Time: O(n)
    def shuffle(self) -> List[int]:
        for i in range(self.n):
            k = random.randrange(i, self.n)
            self.copy[i], self.copy[k] = self.copy[k], self.copy[i]
        return self.copy
```

## Notes
- Fisher-Yates. This algorithm guarantees randomness by choosing a new random element from the 'hat' of remaining elements to place in the next index. 