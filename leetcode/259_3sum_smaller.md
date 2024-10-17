# 259. 3Sum Smaller - Medium

Given an array of `n` integers `nums` and an integer `target`, find the number of index triplets `i`, `j`, `k` with `0 <= i < j < k < n` that satisfy the condition `nums[i] + nums[j] + nums[k] < target`.

##### Example 1:

```
Input: nums = [-2,0,1,3], target = 2
Output: 2
Explanation: Because there are two triplets which sums are less than 2:
[-2,0,1]
[-2,0,3]
```

##### Example 2:

```
Input: nums = [], target = 0
Output: 0
```

##### Example 3:

```
Input: nums = [0], target = 0
Output: 0
```

##### Constraints:

- `n == nums.length`
- `0 <= n <= 3500`
- `-100 <= nums[i] <= 100`
- `-100 <= target <= 100`

## Solution 1

```
# Time: O(n^2 * log(n))
# Space: O(n) (timsort)
class Solution:
    def threeSumSmaller(self, nums: List[int], target: int) -> int:
        nums.sort()
        result, n = 0, len(nums)
        for r in reversed(range(2, n)):
            right = nums[r]
            for l in range(r - 1):
                left = nums[l]
                i, j = l + 1, r - 1
                t = target - right - left
                while i < j:
                    m = (i + j) // 2
                    mid = nums[m]
                    if mid >= t:
                        j = m
                    else:
                        i = m + 1
                result += i - l
                if nums[i] >= t:
                    result -= 1
            
        return result
```

## Notes
- For each possible pair of indices, the number of triplets containing this pair is equal to the number of indices between the index-pair that is less than `target - firstinpair - secondinpair`. To avoid cubic time, we can do binary search for the smallest element that is `>= target - firstinpair - secondinpair`.

## Solution 2

```
# Time: O(n^2)
# Space: O(n) (timsort)
class Solution:
    def threeSumSmaller(self, nums: List[int], target: int) -> int:
        nums.sort()
        result, n = 0, len(nums)
        for r in range(2, n):
            maxpair = target - nums[r] - 1
            l, m = 0, r - 1
            while l < m:
                pair = nums[l] + nums[m]
                if pair <= maxpair:
                    result += m - l
                    l += 1
                else:
                    m -= 1
        return result
```

## Notes
- Reduce the problem to two-sum smaller; it can be difficult to see how this works, in particular, why we do `result += m - l`. Whenever we find a `pair` that has a sum less than `target - nums[r]`, there may be elements with indices in the exclusive range `(l, m)` that could also constitute a valid triplet using the current `l` and `r` indices. Consider the case `nums = [2, 0, 1, 3], target = 4`.