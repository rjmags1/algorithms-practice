# 409. Longest Palindrome - Easy

Given a string `s` which consists of lowercase or uppercase letters, return the length of the longest palindrome that can be built with those letters.

Letters are case sensitive, for example, `"Aa"` is not considered a palindrome here.

##### Example 1:

```
Input: s = "abccccdd"
Output: 7
Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.
```

##### Example 2:

```
Input: s = "a"
Output: 1
Explanation: The longest palindrome that can be built is "a", whose length is 1.
```

##### Constraints:

- `1 <= s.length <= 2000`
- `s` consists of lowercase and/or uppercase English letters only.

## Solution

```
from collections import Counter

# Time: O(n)
# Space: O(1)
class Solution:
    def longestPalindrome(self, s: str) -> int:
        freqs = Counter(s)
        evens = [(c, f) for c, f in freqs.items() if not f & 1]
        odds = [(c, f) for c, f in freqs.items() if f & 1]
        result = sum(f for c, f in evens)
        if not odds:
            return result
        result += 1
        for c, f in odds:
            result += f - 1
        return result
```

## Notes
- The longest palindrome that can be built from a set of letters is the sum of all even letter frequencies plus the sum of all odd letter frequencies minus the number of characters with odd letter frequencies plus `1`.