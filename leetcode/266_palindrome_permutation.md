# 266. Palindrome Permutation - Easy

Given a string `s`, return `true` if a permutation of the string could form a palindrome and `false` otherwise.

##### Example 1:

```
Input: s = "code"
Output: false
```

##### Example 2:

```
Input: s = "aab"
Output: true
```

##### Example 3:

```
Input: s = "carerac"
Output: true
```

##### Constraints:

- `1 <= s.length <= 5000`
- `s` consists of only lowercase English letters.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def canPermutePalindrome(self, s: str) -> bool:
        freqs, offset = [0] * 26, ord('a')
        for c in s:
            freqs[ord(c) - offset] += 1
        odd = len(s) & 1
        if not odd: 
            return all([freq % 2 == 0 for freq in freqs])
        return len([freq for freq in freqs if freq & 1]) == 1
```

## Notes
- Constant complexity because we are only dealing with LCE characters. Palindromes must have all even character frequencies, with the exception that one frequency can be odd if the palindrome has an odd length.