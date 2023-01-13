# 392. Is Subsequence - Easy

Given two strings `s` and `t`, return `true` if `s` is a subsequence of `t`, or `false` otherwise.

A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., `"ace"` is a subsequence of `"abcde"` while `"aec"` is not).

##### Example 1:

```
Input: s = "abc", t = "ahbgdc"
Output: true
```

##### Example 2:

```
Input: s = "axc", t = "ahbgdc"
Output: false
```

##### Constraints:

- <code>0 <= s.length <= 100</code>
- <code>0 <= t.length <= 10<sup>4</sup></code>
- `s` and `t` consist only of lowercase English letters.

Follow-up: Suppose there are lots of incoming `s`, say `s1, s2, ..., sk` where <code>k >= 10<sup>9</sup></code>, and you want to check one by one to see if `t` has its subsequence. In this scenario, how would you change your code? 

## Solution

```
from collections import defaultdict

# Time: O(mn)
# Space: O(m)
class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        ti = defaultdict(list)
        for i, c in enumerate(t):
            ti[c].append(i)

        prevIdx = -1
        for c in s:
            issub = False
            for idx in ti[c]:
                if idx > prevIdx:
                    prevIdx = idx
                    issub = True
                    break
            if not issub:
                return False
        return True
```

## Notes
- This solution addresses the followup, although if `isSubsequence` were called many times for any `s` with an instance level `t` the code would look slightly different though core logic would remain the same. Linear search on `ti[c]` is fine here because of small input constraints but could be trivially optimized with binary search to `O(nlog(m))`.