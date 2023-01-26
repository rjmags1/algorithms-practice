# 567. Permutation in String - Medium

Given two strings `s1` and `s2`, return `true` if `s2` contains a permutation of `s1`, or `false` otherwise.

In other words, return `true` if one of `s1`'s permutations is the substring of `s2`.

##### Example 1:

```
Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").
```

##### Example 2:

```
Input: s1 = "ab", s2 = "eidboaoo"
Output: false
```

##### Constraints:

- <code>1 <= s1.length, s2.length <= 10<sup>4</sup></code>
- `s1` and `s2` consist of lowercase English letters.

## Solution

```
from collections import Counter, defaultdict

# Time: O(n)
# Space: O(1)
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        need, have = Counter(s1), defaultdict(int)
        k, correctfreqs, m = len(list(need.keys())), 0, len(s1)
        for i, c in enumerate(s2):
            if c in need:
                have[c] += 1
                if have[c] == need[c]:
                    correctfreqs += 1
                elif have[c] == need[c] + 1:
                    correctfreqs -= 1
            if i >= m and s2[i - m] in need:
                rem = s2[i - m]
                have[rem] -= 1
                if have[rem] == need[rem]:
                    correctfreqs += 1
                elif have[rem] == need[rem] - 1:
                    correctfreqs -= 1
            if correctfreqs == k:
                return True

        return False
```

## Notes
- Constant space because of constant size character set. Frequency hash table with tracking characters in sliding window with correct frequency.