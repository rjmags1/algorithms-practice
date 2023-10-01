# 1493. Longest Subarray of 1s After Deleting One Element - Medium

Given a binary array `nums`, you should delete one element from it.

Return the size of the longest non-empty subarray containing only `1`'s in the resulting array. Return `0` if there is no such subarray.

##### Example 1:

```
Input: nums = [1,1,0,1]
Output: 3
Explanation: After deleting the number in position 2, [1,1,1] contains 3 numbers with value of 1's.
```

##### Example 2:

```
Input: nums = [0,1,1,1,0,1,1,0,1]
Output: 5
Explanation: After deleting the number in position 4, [0,1,1,1,1,1,0,1] longest subarray with value of 1's is [1,1,1,1,1].
```

##### Example 3:

```
Input: nums = [1,1,1]
Output: 2
Explanation: You must delete one element.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- `nums[i]` is either `0` or `1`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def longestSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        result = 0
        first = second = -1
        for i, num in enumerate(nums):
            if num == 1:
                continue
            if first == -1:
                result = first = i
                continue
            if second == -1:
                result = max(result, i - 1)
                second = i
                continue
            result = max(result, i - first - 2)
            first, second = second, i

        return n - 1 if second == -1 else max(result, n - first - 2)
```

## Notes
- Just test all subarrays containing `0`, `1`, or `2` zeroes.