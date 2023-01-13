# 491. Non-decreasing Subsequences - Medium

Given an integer array `nums`, return all the different possible non-decreasing subsequences of the given array with at least two elements. You may return the answer in any order.

##### Example 1:

```
Input: nums = [4,6,7,7]
Output: [[4,6],[4,6,7],[4,6,7,7],[4,7],[4,7,7],[6,7],[6,7,7],[7,7]]
```

##### Example 2:

```
Input: nums = [4,4,3,2,1]
Output: [[4,4]]
```

##### Constraints:

- `1 <= nums.length <= 15`
- `-100 <= nums[i] <= 100`

## Solution

```
# Time: O(n * 2^n)
# Space: O(n * 2^n)
class Solution:
    def findSubsequences(self, nums: List[int]) -> List[List[int]]:
        def rec(i):
            if i == 0:
                return set()

            subseqs = rec(i - 1)
            newsubseqs = set()
            for ss in subseqs:
                if ss[-1] <= nums[i]:
                    newsubseqs.add(ss + (nums[i],))
            for j, num in enumerate(nums):
                if j == i:
                    break
                if num <= nums[i]:
                    newsubseqs.add((num, nums[i]))
            return subseqs | newsubseqs
        
        return list(list(ss) for ss in rec(len(nums) - 1))
```

## Notes
- There are `2^n` subsets creatable from an initial set of size `n`. Enumerating all possible subsequences is essentially the same as enumerating all possible subsets (using indices) because we are concerned with the combination of indices of the elements in a subset/subsequence being different than that of all the other subsets/subsequences. With subsequences we are just adding the additional requirement that when we collect subsets, the subsets should store their elements in index order even though it is the unique index combination that matters. 
- For this problem, a naive approach would be to explore all subsequences but do not collect into the result subsequences that have decreasing element magnitude. In this solution, we do not consider all possible subsequences, but rather only previously constructed subsequences that are non-decreasing, as well as all possible `2` length subsequences where the current `i` is the last in the subsequence.