# 291. Word Pattern II - Medium

Given a `pattern` and a string `s`, return `true` if `s` matches the `pattern`.

A string `s` matches a `pattern` if there is some bijective mapping of single characters to strings such that if each character in `pattern` is replaced by the string it maps to, then the resulting string is `s`. A bijective mapping means that no two characters map to the same string, and no character maps to two different strings.

##### Example 1:

```
Input: pattern = "abab", s = "redblueredblue"
Output: true
Explanation: One possible mapping is as follows:
'a' -> "red"
'b' -> "blue"
```

##### Example 2:

```
Input: pattern = "aaaa", s = "asdasdasdasd"
Output: true
Explanation: One possible mapping is as follows:
'a' -> "asd"
```

##### Example 3:

```
Input: pattern = "aabb", s = "xyzabcxzyabc"
Output: false
```

##### Constraints:

- 1 <= pattern.length, s.length <= 20
- pattern and s consist of only lowercase English letters.

## Solution

```
# Time: O(m^(n / m))
# Space: O(n + m)
class Solution:
    def wordPatternMatch(self, pattern: str, s: str) -> bool:
        m, n = len(pattern), len(s)
        freqs = Counter(pattern)
        maxmaplengths = {}
        for c, f in freqs.items():
            noncpatternchars = m - f
            maxmaplen = (n - noncpatternchars) // f
            maxmaplengths[c] = maxmaplen
        
        pw, words = {}, set()
        def rec(i, j):
            if i == m or j == n:
                return i == m and j == n
            
            p = pattern[i]
            if p in pw:
                w = pw[p]
                return w == s[j:j + len(w)] and rec(i + 1, j + len(w))
                
            for l in range(1, maxmaplengths[p] + 1):
                w = s[j:j + l]
                if w in words:
                    continue
                words.add(w)
                pw[p] = w
                if rec(i + 1, j + l):
                    return True
                words.remove(w)
                pw.pop(p)
            
            return False
        
        return rec(0, 0)
```

## Notes
- Trickiest part of this problem is computing the max substring lengths for each pattern character. This is necessary so that when we backtrack, we only consider substring maps that could possibly lead to a valid bijective mapping. This single measure will reduce the time complexity from <code>O(m<sup>n</sup>)</code> to <code>O(m<sup>(n/m)</sup>)</code>.
- We are dealing with __bijective mapping__ here, so we need to make sure we only recurse forward on mappings as we backtrack that are valid in both directions; i.e., we have not seen the current substring and current pattern before, we have seen the current pattern and it maps to the current substring. To this end, we also need to make sure we never map `2` pattern characters to the same substring, hence the need for the `words` set.