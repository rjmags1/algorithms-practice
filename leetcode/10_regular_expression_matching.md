# 10. Regular Expression Matching - Hard

Given an input string `s` and a pattern `p`, implement regular expression matching with support for `'.'` and `'*'` where:

- `'.'` Matches any single character.​​​​
- `'*'` Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

##### Example 1:

```
Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
```

##### Example 2:

```
Input: s = "aa", p = "a*"
Output: true
Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
```

##### Example 3:

```
Input: s = "ab", p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".
```


##### Constraints:

- `1 <= s.length <= 20`
- `1 <= p.length <= 30`
- `s` contains only lowercase English letters.
- `p` contains only lowercase English letters, `'.'`, and `'*'`.
- It is guaranteed for each appearance of the character `'*'`, there will be a previous valid character to match.


## Solution
```
# Time: O(m * n)
# Space: O(m * n)
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s), len(p)

        @cache
        def dp(i, j):
            if j == n:
                return i == m
            
            match = i < m and (p[j] == s[i] or p[j] == '.')
            if j + 1 < n and p[j + 1] == '*':
                return dp(i, j + 2) or (match and dp(i + 1, j))
            return match and dp(i + 1, j + 1)
        
        return dp(0, 0)
```

## Notes
- Good example of top-down recursive solution that can be optimized with caching. We check each possible pair of text and pattern indices once with appropriate caching. At each representative subpattern and substring we can make a determination about if the current subpattern matches the current substring based on `i`, `j`, and the results of forward calls down the recursive call tree.
- This is pretty tough to come up with without a good bit of DP practice. Getting the recurrence relationship (a topdown one) translated into code is tricky especially for people who don't know right away that this is topdown. Hard for people who have solved a lot of other DP questions with bottom up solutions, which seems pretty common.