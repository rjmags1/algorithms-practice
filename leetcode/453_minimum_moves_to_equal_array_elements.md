# 453. Minimum Moves to Equal Array Elements - Medium

Given an integer array `nums` of size `n`, return the minimum number of moves required to make all array elements equal.

In one move, you can increment `n - 1` elements of the array by `1`.

##### Example 1:

```
Input: nums = [1,2,3]
Output: 3
Explanation: Only three moves are needed (remember each move increments two elements):
[1,2,3]  =>  [2,3,3]  =>  [3,4,3]  =>  [4,4,4]
```

##### Example 2:

```
Input: nums = [1,1,1]
Output: 0
```

##### Constraints:

- `n == nums.length`
- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>
- The answer is guaranteed to fit in a 32-bit integer.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minMoves(self, nums: List[int]) -> int:
        minnum = min(nums)
        result = 0
        for num in nums:
            result += num - minnum
        return result
```

## Notes
- Tricky math intuition problem, at least to get the optimal solution. Since we are only concerned with __relative distances__ between element magnitudes, incrementing all elements except one is equivalent to decrementing the single element we wouldn't increment in a 'move' described in the prompt.
- Another approach that doesn't rely on the aforementioned math intuition follows a greedy process for spending moves: if we sort the array, we will always know the minimum element and maximum element between 'rounds' of move spending. For the first round, the minimum element is at index `0`, and the maximum element is at index `n - 1`. We need `nums[n - 1] - nums[0]` moves to equalize these two elements in the current round, not incrementing `nums[n - 1]` each move for this first round. In the next round, the new max will be `nums[n - 2]`, and `nums[n - 1]` and `nums[0]` will be the mins. We can continue in this fashion, determining the number of moves to be spent in `n - 1` rounds in constant time; this algorithm's time and space complexity are dominated by the sorting preprocessing step.