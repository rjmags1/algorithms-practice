# 72. Edit Distance - Hard

Given two strings `word1` and `word2`, return the minimum number of operations required to convert `word1` to `word2`.

You have the following three operations permitted on a word:

- Insert a character
- Delete a character
- Replace a character


##### Example 1:

```
Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation: 
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')
```

##### Example 2:

```
Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation: 
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')
```

##### Constraints:

- `0 <= word1.length, word2.length <= 500`
- `word1` and `word2` consist of lowercase English letters.

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        m, n = len(word1), len(word2)
        dp = [[0] * (m + 1) for _ in range(n + 1)]
        for i in range(1, n + 1):
            dp[i][0] = dp[i - 1][0] + 1
        for j in range(1, m + 1):
            dp[0][j] = dp[0][j - 1] + 1
        for i in range(1, n + 1):
            for j in range(1, m + 1):
                replace = dp[i - 1][j - 1] + 1
                insert = dp[i][j - 1] + 1
                delete = dp[i - 1][j] + 1
                if word1[j - 1] == word2[i - 1]:
                    dp[i][j] = min(delete, insert, replace - 1)
                else:
                    dp[i][j] = min(delete, insert, replace)
        
        return dp[-1][-1]
```

## Notes
- The first time I attempted this I jumped to a problem-specific formula that turned out to be incorrect: `minDistance = abs(m - n) + (min(m, n) - longestCommonSubsequence(word1, word2))`. This is wrong for multiple reasons, one being that correct answers often need their common subsequence in `word1` to be edited.
- Whenever we need to compare a couple string inputs it is usually a good idea to at least attempt a 2D matrix approach.