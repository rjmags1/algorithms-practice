# 115. Distinct Subsequences - Hard

Given two strings `s` and `t`, return the number of distinct subsequences of `s` which equals `t`.

The test cases are generated so that the answer fits on a 32-bit signed integer.

##### Example 1:

```
Input: s = "rabbbit", t = "rabbit"
Output: 3
```

##### Example 2:

```
Input: s = "babgbag", t = "bag"
Output: 5
```

##### Constraints:

- `1 <= s.length, t.length <= 1000`
- `s` and `t` consist of English letters.

## Solution 1

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        m, n = len(s), len(t)
        
        @cache
        def rec(i, j):
            if j == n:
                return 1
            if i == m:
                return 0
            
            a, b = s[i], t[j]
            withoutA = rec(i + 1, j)
            return withoutA if a != b else withoutA + rec(i + 1, j + 1)
        
        return rec(0, 0)
```

## Notes
- This is a pretty straightforward translation of the recurrence relation for this problem, which you often see in top-down versions solutions to problems like this. Starting at the beginning of `s` and `t`, we can either choose to include the current character of `s` in the sequence that we will attempt to match with `t`, or we can exclude it. Regardless of if the characters match or not, it is always valid to skip a character as we build our sequence (even if they match, maybe there will be another character in `s` to the right that matches the current character of `t`). If the characters do match, we can consider the case where we do include the current character of `s` in the sequence we build to attempt to match `t`.
- Also note the order of the base cases in this solution. If we reach the end of `t`, that means we have found `1` valid subsequence of `s` that matches `t`. If we haven't reached the end of `t` but reached the end of `s`, we skipped over too many characters as we attempted to build the current sequence, and so we return `0` (it is impossible to form more than `0` valid subsequences in this case).

## Solution 2

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        m, n = len(s), len(t)
        if n > m:
            return 0
        
        dp = [[0] * (m + 1) for _ in range(n + 1)]
        dp[0][0] = 1
        for j in range(1, m + 1):
            dp[1][j] = 1 + dp[1][j - 1] if s[j - 1] == t[0] else dp[1][j - 1]
        for i in range(2, n + 1):
            for j in range(1, m + 1):
                if i > j:
                    dp[i][j] = 0
                elif i == j:
                    dp[i][j] = 1 if dp[i - 1][j - 1] > 0 and s[j - 1] == t[i - 1] else 0
                else:
                    if s[j - 1] != t[i - 1]:
                        dp[i][j] = dp[i][j - 1]
                    else:
                        dp[i][j] = dp[i][j - 1] + dp[i - 1][j - 1]
        
        return dp[-1][-1]
```

## Notes
- Like many forward looking top-down recursive approaches to such problems, there also exists an iterative bottom-up dp solution for this one that involves a 2D matrix. It can be tricky to translate top-down recursive to bottom-up dp without much experience, so for the case of speed it is often easier to simply iterate quickly on a few examples, drawing a 2D matrix of appropriate size and filling the cells with the correct values for the problem. Then attempt to discern a pattern that works on all cells and is some kind of reflection of the more intuitive top-down recurrence relation.

## Solution 3

```
# Time: O(mn)
# Space: O(m)
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        m, n = len(s), len(t)
        if n > m:
            return 0
        
        prev = [0] * (m + 1)
        curr = prev[:]
        for j in range(1, m + 1):
            prev[j] = prev[j - 1]
            if s[j - 1] == t[0]:
                prev[j] += 1
        for i in range(2, n + 1):
            for j in range(1, m + 1):
                if i > j:
                    curr[j] = 0
                elif i == j:
                    curr[j] = 1 if prev[j - 1] > 0 and s[j - 1] == t[i - 1] else 0
                else:
                    if s[j - 1] != t[i - 1]:
                        curr[j] = curr[j - 1]
                    else:
                        curr[j] = prev[j - 1] + curr[j - 1]
                        
            prev, curr = curr, prev
            
        return prev[-1]
```

## Notes
- Like many 2D matrix problems where the recurrence relation for cells only depends on the current previous row, we can optimize space complexity very easily by only using `prev` and `curr` arrays.