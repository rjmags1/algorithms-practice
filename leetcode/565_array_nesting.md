# 565. Array Nesting - Medium

You are given an integer array `nums` of length `n` where `nums` is a permutation of the numbers in the range `[0, n - 1]`.

You should build a set `s[k] = {nums[k], nums[nums[k]], nums[nums[nums[k]]], ... }` subjected to the following rule:

- The first element in `s[k]` starts with the selection of the element `nums[k]` of `index = k`.
- The next element in `s[k]` should be `nums[nums[k]]`, and then `nums[nums[nums[k]]]`, and so on.
- We stop adding right before a duplicate element occurs in `s[k]`.

Return the longest length of a set `s[k]`.

##### Example 1:

```
Input: nums = [5,4,0,3,1,6,2]
Output: 4
Explanation: 
nums[0] = 5, nums[1] = 4, nums[2] = 0, nums[3] = 3, nums[4] = 1, nums[5] = 6, nums[6] = 2.
One of the longest sets s[k]:
s[0] = {nums[0], nums[5], nums[6], nums[2]} = {5, 6, 2, 0}
```

##### Example 2:

```
Input: nums = [0,1,2]
Output: 1

```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>0 <= nums[i] < nums.length</code>
- All the values of `nums` are unique.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def arrayNesting(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [0] * n
        def dfs(i):
            if dp[i] == -1:
                return 0
            if dp[i] > 0:
                return dp[i]
            dp[i] = -1
            dp[i] = 1 + dfs(nums[i])
            return dp[i]
        return max(dfs(i) for i in range(n))
```

## Notes
- Sets described in the prompt are akin to components in a graph where each node has one outgoing edge. We can solve this problem using dfs, memoizing the path lengths of previously explored nodes. We mark a node as in the current path being explored by setting `dp[i] = -1`. It is possible to come up with a constant space solution if we irreversibly mutate the input, which is generally a bad idea, so not showing that here.