# 215. Largest Element in an Array - Medium

Given an integer array `nums` and an integer `k`, return the `kth` largest element in the array.

Note that it is the `kth` largest element in the sorted order, not the `kth` distinct element.

You must solve it in `O(n)` time complexity.

##### Example 1:

```
Input: nums = [3,2,1,5,6,4], k = 2
Output: 5
```

##### Example 2:

```
Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
Output: 4
```

##### Constraints:

- <code>1 <= k <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n) average, O(n^2) worst
# Space: O(1)
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        n = len(nums)
        target = n - k
        start, stop = 0, n - 1
        while start < stop:
            p, pivot = start, nums[start]
            l, r = start + 1, stop
            while l <= r:
                left, right = nums[l], nums[r]
                if left > pivot and right < pivot:
                    nums[l], nums[r] = nums[r], nums[l]
                if left <= pivot:
                    l += 1
                if right >= pivot:
                    r -= 1
            nums[r], nums[p] = nums[p], nums[r]
            if r == target:
                return nums[r]
            elif r < target:
                start = r + 1
            else:
                stop = r - 1
                
        return nums[start]
```

## Notes
- It seems like quickselect should be `n * log(n)` on average but it is actually linear in the average case, and quadratic in the worst case. This solution does not pick a random pivot for ease of implementation so depending on test cases could perform better or worse than average; however, if on each main iteration we picked a truly random pivot we would perform linearly most of the time. The average time complexity is linear because a random pivots will on average split the search space in half on each iteration. `n + n/2 + n/4 + ... = 2n` which is `O(n)`.
- There is also a trivial `O(n * log(k))` solution involving a heap but will not include that here.