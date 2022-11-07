# 97. Interleaving String - Medium

Given strings `s1`, `s2`, and `s3`, find whether `s3` is formed by an interleaving of `s1` and `s2`.

An interleaving of two strings `s` and `t` is a configuration where `s` and `t` are divided into `n` and `m` substrings respectively, such that:

- `s = s1 + s2 + ... + sn`
- `t = t1 + t2 + ... + tm`
- `|n - m| <= 1`
- The interleaving is `s1 + t1 + s2 + t2 + s3 + t3 + ... or t1 + s1 + t2 + s2 + t3 + s3 + ...`

Note: `a + b` is the concatenation of strings `a` and `b`.

##### Example 1:

```
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
Output: true
Explanation: One way to obtain s3 is:
Split s1 into s1 = "aa" + "bc" + "c", and s2 into s2 = "dbbc" + "a".
Interleaving the two splits, we get "aa" + "dbbc" + "bc" + "a" + "c" = "aadbbcbcac".
Since s3 can be obtained by interleaving s1 and s2, we return true.
```

##### Example 2:

```
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
Output: false
Explanation: Notice how it is impossible to interleave s2 with any other string to obtain s3.
```

##### Example 3:

```
Input: s1 = "", s2 = "", s3 = ""
Output: true
```

##### Constraints:

- `0 <= s1.length, s2.length <= 100`
- `0 <= s3.length <= 200`
- `s1`, `s2`, and `s3` consist of lowercase English letters.

Follow-up: Could you solve it using only O(s2.length) additional memory space?

## Solution 1

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        n, m, p = len(s1), len(s2), len(s3)
        if n + m != p:
            return False
        
        @cache
        def rec(i, j):
            if i + j == p:
                return True
            
            c1 = s1[i] if i < n else None
            c2 = s2[j] if j < m else None
            c3 = s3[i + j]
            if c1 == c3 and rec(i + 1, j):
                return True
            if c2 == c3 and rec(i, j + 1):
                return True
            
            return False
        
        return rec(0, 0)
```

## Notes
- There are `n * m` possible pairs of indices of `s1` and `s2` to check. This is a top-down recursive dp approach.

## Solution 2

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        n, m, p = len(s1), len(s2), len(s3)
        if n + m != p:
            return False
        
        dp = [[False] * (n + 1) for _ in range(m + 1)]
        for i in range(m + 1):
            for j in range(n + 1):
                if i == 0:
                    dp[i][j] = j == 0 or (s1[j - 1] == s3[j - 1] and dp[i][j - 1])
                elif j == 0:
                    dp[i][j] = s2[i - 1] == s3[i - 1] and dp[i - 1][j]
                else:
                    c1, c2, c3 = s1[j - 1], s2[i - 1], s3[i + j - 1]
                    canEndPrefixWithC1 = dp[i][j - 1]
                    canEndPrefixWithC2 = dp[i - 1][j]
                    dp[i][j] = (c1 == c3 and canEndPrefixWithC1) or (c2 == c3 and canEndPrefixWithC2) 
                    
        return dp[-1][-1]
```

## Notes
- This is a bottom-up iterative dp approach with a 2D matrix. The recurrence relation for bottom-up is much more subtle in my opinion than the top-down in Solution 1, heavily struggled with coming up with this solution my first time despite getting the top-down right away. The key thing to notice here is how we index `s3` in the main loop. We do not look to match `c1` or `c2` with `s3[i + j - 2]`, rather, we look to match with `s3[i + j - 1]`. This is because `dp[i][j]` represents whether or not we are able to use `c1` or `c2` to complete an interleaved prefix of `s3`. 

## Solution 3

```
# Time: O(mn)
# Space: O(n)
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        n, m, p = len(s1), len(s2), len(s3)
        if n + m != p:
            return False
        
        prev = [False] * (n + 1)
        curr = prev[:]
        for j in range(n + 1):
            prev[j] = j == 0 or (prev[j - 1] and s1[j - 1] == s3[j - 1])
        for i in range(1, m + 1):
            c2 = s2[i - 1]
            curr[0] = prev[0] and c2 == s3[i - 1]
            for j in range(1, n + 1):
                c1, c3 = s1[j - 1], s3[i + j - 1]
                matchWithC1AsLast = c1 == c3 and curr[j - 1]
                matchWithC2AsLast = c2 == c3 and prev[j]
                curr[j] = matchWithC1AsLast or matchWithC2AsLast
            curr, prev = prev, curr
        
        return prev[-1]
```

## Notes
- For recurrence relations in 2D matrix problems that do not depend on all previous rows, we can usually optimize space using strategies similar to above by only keeping in memory previous dp rows needed to calculate the current row. 