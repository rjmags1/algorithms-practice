# 416. Partition Equal Subset Sum - Medium

Given a non-empty array `nums` containing only positive integers, find if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

##### Example 1:

```
Input: nums = [1,5,11,5]
Output: true
Explanation: The array can be partitioned as [1, 5, 5] and [11].
```

##### Example 2:

```
Input: nums = [1,2,3,5]
Output: false
Explanation: The array cannot be partitioned into equal sum subsets.
```

##### Constraints:

- `1 <= nums.length <= 200`
- `1 <= nums[i] <= 100`

## Solution

```
# Time: O(mn)
# Space: O(m)
class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        s = sum(nums)
        if s & 1:
            return False
        
        target, n = s // 2, len(nums)
        sset = set([0])
        sums = [0]
        for num in nums:
            k = len(sums)
            for i in range(k):
                curr = num + sums[i]
                if curr == target:
                    return True
                if curr > target or curr in sset:
                    continue
                sset.add(curr)
                sums.append(curr)
                
        return False
```

## Notes
- First to solve this problem we need to realize that if `s = sum(nums)` is odd, there is no partition to a pair of sets whose sums equal `sum(nums)` - intuitively, the target sum for partitioning will be half of `sum(nums)` because we are told to partition `nums` into `2` sets such that their sums are equal. Thus, all we need to do is look for a subset whose sum is equal to `m == s // 2`.