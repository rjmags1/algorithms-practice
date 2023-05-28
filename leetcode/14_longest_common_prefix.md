# 14. Longest Common Prefix - Easy

Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string `""`.

##### Example 1:

```
Input: strs = ["flower","flow","flight"]
Output: "fl"
```

##### Example 2:

```
Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
```

##### Constraints:

- `1 <= strs.length <= 200`
- `0 <= strs[i].length <= 200`
- `strs[i]` consists of only lowercase English letters.

## Solution

```
# Time: O(c) (where c is total chars in strs)
# Space: O(c) 
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        shortestLen = inf
        shortest = None
        for i, s in enumerate(strs):
            if len(s) < shortestLen:
                shortestLen, shortest = len(s), s
        
        end = 0
        for i in range(shortestLen):
            stop = False
            for s in strs:
                if s[i] != shortest[i]:
                    stop = True
            
            if stop:
                break
            end += 1
        
        return shortest[:end] if end > 0 else ""
```

## Notes
- We do an extra `O(n)` pass to obtain the length of the shortest string in the array for vertical scanning.
- Vertical scanning is useful in a problem like this where every word in the input array must have the same prefix for a given prefix to be a valid answer. It allows us to avoid extra comparisons between two strings in the input that may have a longer common prefix than the answer.