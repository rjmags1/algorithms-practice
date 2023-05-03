# 2439. Minimize Maximum of Array - Medium

You are given a 0-indexed array `nums` comprising of `n` non-negative integers.

In one operation, you must:

- Choose an integer `i` such that `1 <= i < n` and `nums[i] > 0`.
- Decrease `nums[i]` by `1`.
- Increase `nums[i - 1]` by `1`.

Return the minimum possible value of the maximum integer of `nums` after performing any number of operations.

##### Example 1:

```
Input: nums = [3,7,1,6]
Output: 5
Explanation:
One set of optimal operations is as follows:
1. Choose i = 1, and nums becomes [4,6,1,6].
2. Choose i = 3, and nums becomes [4,6,2,5].
3. Choose i = 1, and nums becomes [5,5,2,5].
The maximum integer of nums is 5. It can be shown that the maximum number cannot be less than 5.
Therefore, we return 5.
```

##### Example 2:

```
Input: nums = [10,1]
Output: 10
Explanation:
It is optimal to leave nums as is, and since 10 is the maximum value, we return 10.
```

##### Constraints:

- <code>n == nums.length</code>
- <code>2 <= n <= 10<sup>5</sup></code>
- <code>0 <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minimizeArrayValue(self, nums: List[int]) -> int:
        prefix, result = 0, -1
        for prefixsize, num in enumerate(nums, start=1):
            prefix += num
            result = max(result, math.ceil(prefix / prefixsize))
        return result
```

## Notes
- Pretty tricky for a medium. Problem phrased in a way that makes it harder to notice the solution; it is best to think about each operation as sliding differences between adjacent numbers to the left. If we could shift diffs to the left or right, the answer would simply be the ceiling of the average of array values. But since we only can slide to the left, we need to consider only prefix sum averages (ceil'd still), taking the max of all of them.