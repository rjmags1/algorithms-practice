# 139. Word Break - Medium

Given a string `s` and a dictionary of strings `wordDict`, return `true` if `s` can be segmented into a space-separated sequence of one or more dictionary words.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

##### Example 1:

```
Input: s = "leetcode", wordDict = ["leet","code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".
```

##### Example 2:

```
Input: s = "applepenapple", wordDict = ["apple","pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
Note that you are allowed to reuse a dictionary word.
```

##### Example 3:

```
Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: false
```

##### Constraints:

- `1 <= s.length <= 300`
- `1 <= wordDict.length <= 1000`
- `1 <= wordDict[i].length <= 20`
- `s` and `wordDict[i]` consist of only lowercase English letters.
- All the strings of `wordDict` are unique.

## Solution 1

```
# Time: O(n^3)
# Space: O(n + m)
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        words = set()
        maxLen, minLen = -inf, inf
        n = len(s)
        for w in wordDict:
            maxLen = max(maxLen, len(w))
            minLen = min(minLen, len(w))
            words.add(w)
        
        @cache
        def rec(i):
            if i == n:
                return True
            
            for j in range(i + minLen - 1, min(n, i + maxLen)):
                if s[i:j + 1] in words and rec(j + 1):
                    return True
                
            return False
        
        return rec(0)
```

## Notes
- Top-down recursive dp approach. As is typical for this type of approach, we memoize results of recursive calls. When we call `rec(i)`, we are asking, "is it possible to partition the substring `s[i:]` into words in `wordDict`?" The space complexity on leetcode for this same strategy is just `O(n)` but I think that is wrong because we also convert `wordDict` to a set, which bumps the space complexity to `O(n + m)`. 


## Solution 2

```
# Time: O(n^3)
# Space: O(n + m)
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        words = set(wordDict)
        n = len(s)
        dp = [False] * (n + 1)
        dp[0] = True
        for j in range(n):
            for i in range(j + 1):
                if s[i:j + 1] in words:
                    k = j + 1
                    l = j - i + 1
                    dp[k] = dp[k - l]
                    if dp[k]:
                        break
                        
        return dp[-1]
```

## Notes
- Bottom-up dp approach. `dp[k]` represents whether or not the substring `s[:k]` is able to be partitioned using words in `wordDict`. The recurrence relation depends on two things: 
1. If a word `w` in wordDict, with length `l`, matches the end of `s[:k]` 
2. `dp[k - l]` (if beginning of `s[:k]` not covered by `w` is also able to be partitioned using words in wordDict, base case is `w` covers entirety of `s[:k]`, hence the extra `True` at the start of `dp`).