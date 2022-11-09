# 140. Word Break II - Hard

Given a string `s` and a dictionary of strings `wordDict`, add spaces in `s` to construct a sentence where each word is a valid dictionary word. Return all such possible sentences in any order.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

##### Example 1:

```
Input: s = "catsanddog", wordDict = ["cat","cats","and","sand","dog"]
Output: ["cats and dog","cat sand dog"]
```

##### Example 2:

```
Input: s = "pineapplepenapple", wordDict = ["apple","pen","applepen","pine","pineapple"]
Output: ["pine apple pen apple","pineapple pen apple","pine applepen apple"]
Explanation: Note that you are allowed to reuse a dictionary word.
```

##### Example 3:

```
Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: []
```

##### Constraints:

- `1 <= s.length <= 20`
- `1 <= wordDict.length <= 1000`
- `1 <= wordDict[i].length <= 10`
- `s` and `wordDict[i]` consist of only lowercase English letters.
- All the strings of `wordDict` are unique.

## Solution 1

```
# Time: O(n^2 * 2^n + m)
# Space: O(n * 2^n + m)
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        words = set(wordDict)
        n = len(s)
        
        @cache
        def rec(i):
            if i == n:
                return [[]]
            
            partitions = []
            for j in range(i, n):
                w = s[i:j + 1]
                if w in words:
                    subparts = rec(j + 1)
                    for sub in subparts:
                        partitions.append([w] + sub)
                        
            return partitions
        
        return [" ".join(part) for part in rec(0)]
```

## Notes
- The main thing for not getting TLE on this problem is converting `wordDict` to a set, and and caching the subpartitions returned from our top down recursive dp calls. See the previous problem for a more in depth explanation of how the recursive function works and an explanation of how top-down dp applies to this problem.
- The time complexity for this problem is what it is because it depends on the number of subpartitions that can be formed at each index. In each recursive call, the total number of which is `O(n)` due to memoization, we make an `O(n)` loop to check for substrings present in `wordDict`. In the worst case for an input like `s = "aaaaa", wordDict = ["a", "aa", "aaa", "aaaa", "aaaaa"]`, there are <code>O(2<sup>n</sup>)</code> (for each letter after `w` in `s`, each letter could be added to the previous word in the partition or added as its own word) subpartitions for each substring `w` in `s[i:]` that is in `wordDict`, hence the massive time complexity.  