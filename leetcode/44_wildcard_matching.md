# 44. Wildcard Matching - Hard

Given an input string (`s`) and a pattern (`p`), implement wildcard pattern matching with support for `'?'` and `'*'` where:

- `'?'` Matches any single character.
- `'*'` Matches any sequence of characters (including the empty sequence).

The matching should cover the entire input string (not partial).

##### Example 1:

```
Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
```

##### Example 2:

```
Input: s = "aa", p = "*"
Output: true
Explanation: '*' matches any sequence.
```

##### Example 3:

```
Input: s = "cb", p = "?a"
Output: false
Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.
```

##### Constraints:

- `0 <= s.length, p.length <= 2000`
- `s` contains only lowercase English letters.
- `p` contains only lowercase English letters, `'?'` or `'*'`.

## Solution 1

```
# Time: O(m * n)
# Space: O(m * n)
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        dedupe = []
        for i, c in enumerate(p):
            if c == '*' and i > 0 and p[i - 1] == '*':
                continue
            dedupe.append(c)
        p = "".join(dedupe)
        m, n = len(p), len(s)
        
        @cache
        def rec(i, j):
            if j == n:
                return i == m or (i == m - 1 and p[m - 1] == '*')
            if i == m:
                return j == n
            
            if p[i] == '?':
                return rec(i + 1, j + 1)
            if p[i] == '*':
                return rec(i, j + 1) or rec(i + 1, j)
            return p[i] == s[j] and rec(i + 1, j + 1)
        
        return rec(0, 0)
```

## Notes
- The recurrence relation for this is straightforward, however it takes some experimentation to see that we must dedupe adjacent `'*'`s for this solution, otherwise the first base case will always fail for inputs like `s = "", p = "**"`.

# Solution 2

```
# Time: O(n * m)
# Space: O(n * m)
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        dedupe = []
        for i, c in enumerate(p):
            if c == '*' and i > 0 and p[i - 1] == '*':
                continue
            dedupe.append(c)
        p = "".join(dedupe)
        
        m, n = len(p), len(s)
        dp = [[False for _ in range(m + 1)] for _ in range(n + 1)]
        dp[0][0] = True
        if m > 0:
            dp[0][1] = p[0] == '*'
        for i in range(1, n + 1):
            for j in range(1, m + 1):
                pchar = p[j - 1]
                schar = s[i - 1]
                if pchar == '?':
                    dp[i][j] = dp[i - 1][j - 1]
                elif pchar == '*':
                    dp[i][j] = dp[i][j - 1] or dp[i - 1][j]
                else:
                    dp[i][j] = pchar == schar and dp[i - 1][j - 1]
        
        return dp[-1][-1]
```

## Notes
- If we didn't dedupe consecutive `'*'`s, would have to check entire top row of `dp` for matching with empty string.

# Solution 3

```
# Time: O(n * m)
# Space: O(m)
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        p = "".join([p[i] for i in range(len(p)) 
                     if i == 0 or (p[i] != '*' or p[i - 1] != '*')])
        m, n = len(p), len(s)
        i = j = 0
        prevJ = prevStarIdx = None
        while j < n:
            pchar = p[i] if i < m else None
            schar = s[j]
            if pchar == '?' or pchar == schar:
                i += 1
                j += 1
            elif pchar == '*':
                prevStarIdx, prevJ = i, j
                i += 1
            elif prevStarIdx is not None:
                i = prevStarIdx + 1
                j = prevJ + 1
                prevJ = j
            else:
                return False
        
        return i == m or (i == m - 1 and p[m - 1] == '*')
```

## Notes
- Could get this to be constant space if we didn't dedupe consecutive stars and did more extensive checking in the bottom return statement.
- The average and best case time complexity is much better than `O(n * m)`, but the analysis is outside the scope of most interviews. This solution achieves lower memory usage and improved runtime by iteratively backtracking on the number of absorbed `s` characters per `*`, starting from `0` and trying the next highest number each time a match with the previous number of absorbed characters fails. 
- It is not immediately obvious that once we get a match of `s` up to the next `*` in `p`, we can forget about the previous `*`, but it is true, and is the reason why this can be solved with the iterative backtracking approach in the above solution.