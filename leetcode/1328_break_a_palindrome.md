# 1328. Break a Palindrome - Medium

Given a palindromic string of lowercase English letters `palindrome`, replace exactly one character with any lowercase English letter so that the resulting string is not a palindrome and that it is the lexicographically smallest one possible.

Return the resulting string. If there is no way to replace a character to make it not a palindrome, return an empty string.

A string `a` is lexicographically smaller than a string `b` (of the same length) if in the first position where `a` and `b` differ, `a` has a character strictly smaller than the corresponding character in `b`. For example, `"abcc"` is lexicographically smaller than `"abcd"` because the first position they differ is at the fourth character, and `'c'` is smaller than `'d'`.

##### Example 1:

```
Input: palindrome = "abccba"
Output: "aaccba"
Explanation: There are many ways to make "abccba" not a palindrome, such as "zbccba", "aaccba", and "abacba".
Of all the ways, "aaccba" is the lexicographically smallest.
```

##### Example 2:

```
Input: palindrome = "a"
Output: ""
Explanation: There is no way to replace a single character to make "a" not a palindrome, so return an empty string.
```

##### Constraints:

- `1 <= palindrome.length <= 1000`
- `palindrome` consists of only lowercase English letters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def breakPalindrome(self, palindrome: str) -> str:
        n = len(palindrome)
        if n == 1:
            return ""
        for i, c in enumerate(palindrome):
            if c != "a" and (n & 1 == 0 or n // 2 != i):
                return palindrome[:i] + "a" + palindrome[i + 1:]
        return palindrome[:-1] + "b"
```

## Notes
- Any single character input will always be a palindrome, so we always return an empty string for this case. For all other inputs, there are two possible cases: there is a non-`a` character that is not at the central index of the input, or there isn't. For the first case, to obtain the smallest lexicographical replacement to make the input non-palindromic, we find the leftmost non-`a`, non-center character and replace it with an `a`. For the other case, just replace the last character with a `b`.