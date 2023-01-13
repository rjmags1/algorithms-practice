# 459. Repeated Substring Pattern - Easy

Given a string `s`, check if it can be constructed by taking a substring of it and appending multiple copies of the substring together.

##### Example 1:

```
Input: s = "abab"
Output: true
Explanation: It is the substring "ab" twice.
```

##### Example 2:

```
Input: s = "aba"
Output: false
```

##### Example 3:

```
Input: s = "abcabcabcabc"
Output: true
Explanation: It is the substring "abc" four times or the substring "abcabc" twice.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` consists of lowercase English letters.

## Solution 1

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def repeatedSubstringPattern(self, s: str) -> bool:
        n = len(s)
        for l in range(1, n // 2 + 1):
            if n % l == 0:
                ss = s[:l]
                if ss * (n // l) == s:
                    return True
        return False
```

## Notes
- One check for repeats if the current repeat length cleanly divides `n`, the length of `s`. Interestingly this solution passes LC test cases faster on average than the asympotically linear KMP based solution below.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def repeatedSubstringPattern(self, s: str) -> bool:
        n = len(s)
        lps = [0] * n
        i, j = 1, 0
        while i < n:
            if s[i] == s[j]:
                j += 1
                lps[i] = j
                i += 1
            elif j > 0:
                j = lps[j - 1]
            else:
                lps[i] = 0
                i += 1
        return lps[n - 1] and n % (n - lps[n - 1]) == 0
```

## Notes
- This solution utilizes the idea of longest proper prefix suffix, ie substrings that are prefixes that are also suffixes of some larger substring `x`, such that the length of the prefix/suffix is less than the length of `x`. If there is a substring of `s` that when concatenated some integer number of times forms `s`, the lps will have a distinguishing form such that we will always know if `s` has such a substring or not. Consider `s = "abcabcabc"`; `lps` will be `[0, 0, 0, 1, 2, 3, 4, 5, 6]`.