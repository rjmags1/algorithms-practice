# 316. Remove Duplicate Letters - Medium

Given a string `s`, remove duplicate letters so that every letter appears once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.

##### Example 1:

```
Input: s = "bcabc"
Output: "abc"
```

##### Example 2:

```
Input: s = "cbacdcbc"
Output: "acdb"

```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` consists of lowercase English letters.

## Solution

```
# Time: O(26n) -> O(n)
# Space: O(26 + n) -> O(n)
class Solution:
    def removeDuplicateLetters(self, s: str) -> str:
        distinct = set(s)
        def rec(s):
            if not s:
                return ""

            n = len(s)
            freqs = Counter(s)
            minc, mini = s[0], 0
            for i, c in enumerate(s):
                if freqs[c] == 1:
                    break
                else:
                    freqs[c] -= 1
                    nxtc = None if i == n - 1 else s[i + 1]
                    if nxtc is not None and nxtc < minc:
                        minc, mini = nxtc, i + 1
                        
            distinct.remove(minc)
            sp = "".join([s[i] for i in range(mini + 1, n) if s[i] in distinct])
            return minc + self.removeDuplicateLetters(sp)
        
        return rec(s)
```

## Notes
- This is a tricky implementation of a simple idea. To get the lowest lexicographical order subsequence of the original `s`, we need to get the lowest (lexicographically speaking) letter `l` such that if we cut all the letters before it to make `l` the next character in our final subsequence, we will not lose any distinct characters. We will do this at most `26` times, and each time we will do at most `n` iterations.