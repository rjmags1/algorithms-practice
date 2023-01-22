# 548. Split Array with Equal Sum - Hard

Given an integer array `nums` of length `n`, return `true` if there is a triplet `(i, j, k)` which satisfies the following conditions:

- `0 < i, i + 1 < j, j + 1 < k < n - 1`
- The sum of subarrays `(0, i - 1)`, `(i + 1, j - 1)`, `(j + 1, k - 1)` and `(k + 1, n - 1)` is equal.

A subarray `(l, r)` represents a slice of the original array starting from the element indexed `l` to the element indexed `r`. 

##### Example 1:

```
Input: nums = [1,2,1,2,1,2,1]
Output: true
Explanation:
i = 1, j = 3, k = 5. 
sum(0, i - 1) = sum(0, 0) = 1
sum(i + 1, j - 1) = sum(2, 2) = 1
sum(j + 1, k - 1) = sum(4, 4) = 1
sum(k + 1, n - 1) = sum(6, 6) = 1
```

##### Example 2:

```
Input: nums = [1,2,1,2,1,2,1,2]
Output: false
```

##### Constraints:

- `n == nums.length`
- `1 <= n <= 2000`
- <code>-10<sup>6</sup> <= nums[i] <= 10<sup>6</sup></code>

## Solution

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def splitArray(self, nums: List[int]) -> bool:
        n = len(nums)
        if n < 7:
            return False

        pre = [nums[0]]
        for i in range(1, n):
            pre.append(pre[-1] + nums[i])

        for j in range(3, n - 3):
            leftequalsubs = {}
            for i in range(1, j - 1):
                a, b = pre[i - 1], pre[j - 1] - pre[i]
                if a == b:
                    leftequalsubs[a] = i
            for k in range(j + 2, n - 1):
                c, d = pre[k - 1] - pre[j], pre[-1] - pre[k]
                if c == d and c in leftequalsubs:
                    return True
        return False
```

## Notes
- Instead of naively examining all `(i, j, k)` partitions of `nums` in cubic time using prefix sums, we can get quadratic time by checking, for all `j`, if there is an `i` to the left of it and a `k` to the right of it that split the left and right halves such that the resulting `4` subarrays have equivalent sums. This strategy could be similarly applied to problems like `4Sum`.