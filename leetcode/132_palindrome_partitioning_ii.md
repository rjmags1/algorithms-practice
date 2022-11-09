# 132. Palindrome Partitioning II - Hard

Given a string `s`, partition `s` such that every substring of the partition is a palindrome.

Return the minimum cuts needed for a palindrome partitioning of `s`.

##### Example 1:

```
Input: s = "aab"
Output: 1
Explanation: The palindrome partitioning ["aa","b"] could be produced using 1 cut.
```

##### Example 2:

```
Input: s = "a"
Output: 0
```

##### Example 3:

```
Input: s = "ab"
Output: 1
```

##### Constraints:

- `1 <= s.length <= 2000`
- `s` consists of lowercase English letters only.

## Solution 1

```
# Time: O(n^3)
# Space: O(n^2)
class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)
        dp = [[False] * n for _ in range(n)]
        for sr in range(n):
            l, r = 0, sr
            while r < n:
                if l >= r - 1:
                    dp[l][r] = s[l] == s[r]
                else:
                    dp[l][r] = s[l] == s[r] and dp[l + 1][r - 1]
                l += 1
                r += 1
        
        @cache
        def rec(i, j):
            if i == n:
                return -1
            
            result = inf
            for k in range(j, n):
                if dp[i][k]:
                    result = min(result, 1 + rec(k + 1, k + 1))
            return result
        
        return rec(0, 0)
```

## Notes
- The idea behind this solution is to build a matrix `dp` that stores whether or not any possible substring in `s` is palindromic. We use this matrix to calculate the minimum cuts in a top down fashion. For a particular position in the matrix, which represents the start and stop of a particular palindromic substring (before which there may have been other palindromic substrings that have already been partitioned), we ask the minimum number of cuts to partition the rest of the string into palindrome substrings.

## Solution 2

```
# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)
        dp = [[False] * n for _ in range(n)]
        for sr in range(n):
            l, r = 0, sr
            while r < n:
                if l >= r - 1:
                    dp[l][r] = s[l] == s[r]
                else:
                    dp[l][r] = s[l] == s[r] and dp[l + 1][r - 1]
                l += 1
                r += 1
        
        dp2 = [inf] * n
        for i in reversed(range(n)):
            dp2[i] = n - i
            for j in range(i, n):
                if dp[i][j]:
                    dp2[i] = min(dp2[i], 0 if j == n - 1 else 1 + dp2[j + 1])
        
        return dp2[0]
```

## Notes
- This is essentially the same logic as in solution 1 except here we use a second dp array `dp2` to keep track of the minimum cuts for substrings ending at `n - 1`, and we populate `dp2` using the results we calculated for `dp`. This allows us to reduce our time complexity to quadratic from cubic because it gives us a way to avoid the loop in the recursive function of solution 1 that was giving cubic time complexity. Consider the following: in solution 1 we calculated at most the minimum number of cuts to partition `s` into palindromes, from the end of each palindrome substring once. This works, but it would be better to choose an alternative dp paradigm that could give us at least quadratic time complexity, and this is one - it allows us to use `O(n)` subproblems (the number of substrings ending at index `n - 1`) as opposed to <code>O(n<sup>2</sup>)</code> subproblems (the ends of all possible palindromic substrings).
- It is possible to reduce the space complexity to `O(n)` as well, because it is possible to build the first dp array `dp` bottom up, in the same direction that we iterate over `dp` to populate `dp2`. This allows us to employ the two-array-swap technique to remove the need for a full `m * n` matrix.