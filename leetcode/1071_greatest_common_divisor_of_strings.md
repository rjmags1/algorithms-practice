# 1071. Greatest Common Divisor of Strings - Easy

For two strings `s` and `t`, we say "`t` divides `s`" if and only if `s = t + ... + t` (i.e., `t` is concatenated with itself one or more times).

Given two strings `str1` and `str2`, return the largest string `x` such that `x` divides both `str1` and `str2`.

##### Example 1:

```
Input: str1 = "ABCABC", str2 = "ABC"
Output: "ABC"
```

##### Example 2:

```
Input: str1 = "ABABAB", str2 = "ABAB"
Output: "AB"
```

##### Example 3:

```
Input: str1 = "LEET", str2 = "CODE"
Output: ""
```

##### Constraints:

- `1 <= str1.length, str2.length <= 1000`
- `str1` and `str2` consist of English uppercase letters.

## Solution 1

```
# Time: O(mn)
# Space: O(n)

class Solution:
    def gcdOfStrings(self, str1: str, str2: str) -> str:
        m, n = len(str1), len(str2)
        if m > n:
            str1, str2 = str2, str1
            m, n = n, m
        for sublen in reversed(range(1, m + 1)):
            if n % sublen != 0 or m % sublen != 0:
                continue
            sub = str1[:sublen]
            if str1 == sub * (m // sublen) and str2 == sub * (n // sublen):
                return sub
        return ""
```

## Notes
- Brute force check all possible concatenation strings; notice the use of modular math to avoid checking substrings that have lengths that do not fit evenly into `str1` and `str2`.

## Solution 2

```
# Time: O(m + n)
# Space: O(m + n)
from math import gcd

class Solution:
    def gcdOfStrings(self, str1: str, str2: str) -> str:
        if str1 + str2 != str2 + str1:
            return ""
        
        m, n = len(str1), len(str2)
        reslen = gcd(m, n)
        return str1[:reslen]
```

## Notes
- Once we have determined that there is definitely a divisor substring, it is guaranteed to be the greatest common divisor of the two lengths. This was not intuitive for me at first but is true because any smaller divisor substring than the gcd length divisor substring would also evenly fit into the gcd length divisor substring.