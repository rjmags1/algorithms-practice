# 581. Shortest Unsorted Continuous Subarray - Medium

Given an integer array `nums`, you need to find one continuous subarray that if you only sort this subarray in ascending order, then the whole array will be sorted in ascending order.

Return the shortest such subarray and output its length.

##### Example 1:

```
Input: nums = [2,6,4,8,10,9,15]
Output: 5
Explanation: You need to sort [6, 4, 8, 10, 9] in ascending order to make the whole array sorted in ascending order.
```

##### Example 2:

```
Input: nums = [1,2,3,4]
Output: 0
```

##### Example 3:

```
Input: nums = [1]
Output: 0
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>-10<sup>5</sup> <= nums[i] <= 10<sup>5</sup></code>

Follow up: Can you solve it in `O(n)` time complexity?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def findUnsortedSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        l = r = None
        for i, num in enumerate(nums):
            if i < n - 1 and num > nums[i + 1]:
                l = i
                break
        if l is None:
            return 0
        for i, num in enumerate(reversed(nums)):
            k = n - i - 1
            if k > 0 and nums[k - 1] > num:
                r = k
                break
        unsortedmin = min(nums[i] for i in range(l, r + 1))
        unsortedmax = max(nums[i] for i in range(l, r + 1))
        l = r = -1
        for i, num in enumerate(nums):
            if num > unsortedmin:
                l = i
                break
        for i, num in enumerate(reversed(nums)):
            k = n - i - 1
            if num < unsortedmax:
                r = k
                break
        return r - l + 1
```

## Notes
- To get linear time and constant space, we need to realize the left element of the first descending pair LTR and the right element of the first ascending pair RTL mark the boundaries of the subarray of `nums` containing the smallest and largest unsorted elements. The sorted indices of the smallest and the largest unsorted elements mark the boundaries of the subarray of `nums` that needs to be sorted for `nums` to be sorted, and so we just return the size of that subarray.