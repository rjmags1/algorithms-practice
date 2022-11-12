# 161. One Edit Distance - Medium

Given two strings `s` and `t`, return `true` if they are both one edit distance apart, otherwise return `false`.

A string `s` is said to be one distance apart from a string `t` if you can:

- Insert exactly one character into `s` to get `t`.
- Delete exactly one character from `s` to get `t`.
- Replace exactly one character of `s` with a different character to get `t`.

##### Example 1:

```
Input: s = "ab", t = "acb"
Output: true
Explanation: We can insert 'c' into s to get t.
```

##### Example 2:

```
Input: s = "", t = ""
Output: false
Explanation: We cannot get t from s by only one step.
```

##### Constraints:

- <code>0 <= s.length, t.length <= 10<sup>4</sup></code>
- `s` and `t` consist of lowercase letters, uppercase letters, and digits.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isOneEditDistance(self, s: str, t: str) -> bool:
        m, n = len(s), len(t)
        if n > m:
            return self.isOneEditDistance(t, s)
        if m - n > 1:
            return False
        
        diff = j = 0
        for i in range(m):
            if m - n == 1:
                if j < n and s[i] == t[j]:
                    j += 1
                    continue
                diff += 1
            else:
                if s[i] != t[i]:
                    diff += 1
            if diff == 2:
                break
                
        return diff == 1
```

## Notes
- The most important aspect of this problem is realizing that if `m == n`, the two strings can only be one edit distance apart if there is a single character-index difference between them. If their lengths have a difference of `1`, the strings characters must match as we iterate over them at the same time, except we must skip one character of the longer string. If their lengths have a difference `> 1`, it is impossible for the two strings to have a single edit distance. We also need to make sure identical strings return `False` because they have an edit distance of `0`.