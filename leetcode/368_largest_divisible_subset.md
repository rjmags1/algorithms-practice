# 368. Largest Divisible Subset - Medium

Given a set of distinct positive integers `nums`, return the largest subset `answer` such that every pair `(answer[i], answer[j])` of elements in this subset satisfies:

- `answer[i] % answer[j] == 0`, or
- `answer[j] % answer[i] == 0`

If there are multiple solutions, return any of them.

##### Example 1:

```
Input: nums = [1,2,3]
Output: [1,2]
Explanation: [1,3] is also accepted.
```

##### Example 2:

```
Input: nums = [1,2,4,8]
Output: [1,2,4,8]
```

##### Constraints:

- `1 <= nums.length <= 1000`
- <code>1 <= nums[i] <= 2 * 10<sup>9</sup></code>
- All the integers in `nums` are unique.

## Solution

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def largestDivisibleSubset(self, nums: List[int]) -> List[int]:
        nums.sort()
        n = len(nums)
        size, previ, maxsizei = [1] * n, [-1] * n, 0
        for i, curr in enumerate(nums):
            for j in range(i - 1, -1, -1):
                if curr % nums[j] == 0 and size[j] + 1 > size[i]:
                    size[i], previ[i] = size[j] + 1, j
                    if size[i] > size[maxsizei]:
                        maxsizei = i

        result = [0] * size[maxsizei]
        k, curr = size[maxsizei] - 1, maxsizei
        while curr > -1:
            result[k] = nums[curr]
            curr = previ[curr]
            k -= 1
            
        return result
```

## Notes
- We use the same technique for building the longest increasing subsequence of an array to build the longest increasing factor subsequence such that each element in the sequence is divisible by all the ones before it. Consider the following: if `a % b == 0`, then `a >= b` and `b` is a factor of `a`. If `c % a == 0`, then `c >= a` and `a` is a factor of `c`. If `a` is a factor of `c`, then `b` must also be a factor of `c`: i.e. if `xb == a` and `ya == c`, then `yxb == c`.