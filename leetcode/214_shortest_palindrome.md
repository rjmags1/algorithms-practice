# 214. Shortest Palindrome - Hard

You are given a string `s`. You can convert `s` to a palindrome by adding characters in front of it.

Return the shortest palindrome you can find by performing this transformation.

##### Example 1:

```
Input: s = "aacecaaa"
Output: "aaacecaaa"
```

##### Example 2:

```
Input: s = "abcd"
Output: "dcbabcd"
```

##### Constraints:

- <code>0 <= s.length <= 5 * 10<sup>4</sup></code>
- `s` consists of lowercase English letters only.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def shortestPalindrome(self, s: str) -> str:
        pal = s + "#" + s[::-1]
        k = len(pal)
        lps = [0] * k
        i, j = 1, 0
        while i < k:
            if j == 0 or pal[i] == pal[j]:
                equal = pal[i] == pal[j]
                i += 1
                j += 1
                lps[i - 1] = j if equal else 0
            else:
                j = lps[j - 1]
        
        longestpalprefix = lps[-1]
        added = s[longestpalprefix:]
        return added[::-1] + s
```

## Notes
- This question is essentially asking us to find the longest palindromic prefix of `s`, because the result will always have this palindrome at its center, with the suffix associated with the longest palindromic prefix reversed and added to the front.
- We could easily find the longest palindromic prefix in quadratic time, but based on the upper bound input size constraint, we'll need to find a linear way to do this. 
- One idea that comes to mind is using the concept of longest prefix that is also a suffix from KMP string matching algorithm - or more accurately, Longest Proper Prefix (proper prefixes are prefixes that are also suffixes such that the prefix is not the exact same word wrt indices as the suffix, i.e. the longest proper prefix for a single character word is `0`). If we reverse the string and append the reversed version to the original, we will be able to use this concept of Longest Proper Prefix to answer this question, because the Longest Proper Prefix for such a transformed string will be equivalent to the longest palindromic prefix of the original string.