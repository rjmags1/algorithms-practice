# 516. Longest Palindromic Subsequence - Medium

Given a string `s`, find the longest palindromic subsequence's length in `s`.

A subsequence is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.

##### Example 1:

```
Input: s = "bbbab"
Output: 4
Explanation: One possible longest palindromic subsequence is "bbbb".
```

##### Example 2:

```
Input: s = "cbbd"
Output: 2
Explanation: One possible longest palindromic subsequence is "bb".
```

##### Constraints:

- `1 <= s.length <= 1000`
- `s` consists only of lowercase English letters.

## Solution

```
# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def longestPalindromeSubseq(self, s: str) -> int:
        n, k = len(s), 0
        dp = [[0] * n for _ in range(n)]
        while k < n:
            i, j = 0, k
            while j < n:
                if i == j:
                    dp[i][j] = 1
                else:
                    a = 0 if i == n - 1 else dp[i + 1][j]
                    b = 0 if j == 0 else dp[i][j - 1]
                    c = dp[i + 1][j - 1] 
                    if s[i] == s[j]:
                        c += 2
                    dp[i][j] = max(a, b, c)
                i += 1
                j += 1
            k += 1

        return dp[0][-1]
```

## Notes
- Familiar recurrence relation, difficult part is figuring out how to iterate in a way that allows building of `dp` matrix. If we iterate `for i in n - 1..0, for j in i..n` this could be optimized to linear space.