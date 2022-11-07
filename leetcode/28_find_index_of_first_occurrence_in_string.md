# 28. Find the Index of the First Occurrence in a String - Easy

Given two strings `needle` and `haystack`, return the index of the first occurrence of `needle` in `haystack`, or `-1` if `needle` is not part of `haystack`.

##### Example 1:

```
Input: haystack = "sadbutsad", needle = "sad"
Output: 0
Explanation: "sad" occurs at index 0 and 6.
The first occurrence is at index 0, so we return 0.
```

##### Example 2:

```
Input: haystack = "leetcode", needle = "leeto"
Output: -1
Explanation: "leeto" did not occur in "leetcode", so we return -1.
```

##### Constraints:

- <code>1 <= haystack.length, needle.length <= 10<sup>4</sup></code>
- `haystack` and `needle` consist of only lowercase English characters.

## Solution

```
# Time: O(n + m)
# Space: O(n)
class Solution:
    def strStr(self, haystack: str, needle: str) -> int:
        m, n = len(needle), len(haystack)
        i, j, lps = 1, 0, [-1] + [0] * m
        while i < m:
            if j == -1 or needle[i] == needle[j]:
                i += 1
                j += 1
                lps[i] = j
            else:
                j = lps[j]
        
        i = j = 0
        while i < n and j < m:
            if j == -1 or haystack[i] == needle[j]:
                i += 1
                j += 1
            else:
                j = lps[j]
        
        return i - j if j == m else -1
```

## Notes
- This is an implementation of the KMP substring matching algorithm. Basically impossible to come up with on your own naively. If people want to see a linear solution to this problem in an interview, you must know about this algorithm and understand how the `lps` (longest prefix suffix) array allows us to drop from a quadratic time complexity to linear.