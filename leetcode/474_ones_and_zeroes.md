# 474. Ones and Zeroes - Medium

You are given an array of binary strings `strs` and two integers `m` and `n`.

Return the size of the largest subset of `strs` such that there are at most `m` `0`'s and `n` `1`'s in the subset.

A set `x` is a subset of a set `y` if all elements of `x` are also elements of `y`.

##### Example 1:

```
Input: strs = ["10","0001","111001","1","0"], m = 5, n = 3
Output: 4
Explanation: The largest subset with at most 5 0's and 3 1's is {"10", "0001", "1", "0"}, so the answer is 4.
Other valid but smaller subsets include {"0001", "1"} and {"10", "1", "0"}.
{"111001"} is an invalid subset because it contains 4 1's, greater than the maximum of 3.
```

##### Example 2:

```
Input: strs = ["10","0","1"], m = 1, n = 1
Output: 2
Explanation: The largest subset is {"0", "1"}, so the answer is 2.
```

##### Constraints:

- `1 <= strs.length <= 600`
- `1 <= strs[i].length <= 100`
- `1 <= m, n <= 100`
- `strs[i]` consists only of digits `'0'` and `'1'`.

## Solution

```
from functools import cache

# Time: O(m * n * len(strs))
# Space: O(m * n * len(strs))
class Solution:
    def count(self, s):
        n = len(s)
        nz = s.count("0")
        return nz, n - nz

    def findMaxForm(self, strs: List[str], m: int, n: int) -> int:
        counts = [self.count(s) for s in strs]

        @cache
        def rec(i, zeroes, ones):
            if i == len(strs):
                return 0
            
            currzeroes, currones = counts[i]
            result = 0
            if currzeroes + zeroes <= m and currones + ones <= n:
                result = 1 + rec(i + 1, currzeroes + zeroes, currones + ones)
            return max(result, rec(i + 1, zeroes, ones))
        
        return rec(0, 0, 0)
```

## Notes
- This is one of those questions where a naive recursive solution will TLE due to large input range upper bounds but passes if we correctly apply memoization. The trick is figuring out how to apply memoization and often follows from considering the brute force solution. 
- The brute force solution involves exploring all possible subsets of `strs`, which is `O(2^len(strs))`, and search pruning once the subset we are building has an excessive number of ones and/or zeroes. To search prune, we would need to keep track of zeroes and ones used already in our recursive calls that generate subsets, and revisiting the problem constraints, if we cache on `(i, zeroes, ones)` we can avoid redundant recursive calls and reduce time and space complexity to a reasonable `O(len(strs) * m * n)`, which is the number of possible combinations of zeroes and ones with `n - i` words in `strs` left to use.