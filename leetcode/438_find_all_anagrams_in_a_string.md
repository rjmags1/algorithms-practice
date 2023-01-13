# 438. Find All Anagrams in a String - Medium

Given two strings `s` and `p`, return an array of all the start indices of `p`'s anagrams in `s`. You may return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

##### Example 1:

```
Input: s = "cbaebabacd", p = "abc"
Output: [0,6]
Explanation:
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".
```

##### Example 2:

```
Input: s = "abab", p = "ab"
Output: [0,1,2]
Explanation:
The substring with start index = 0 is "ab", which is an anagram of "ab".
The substring with start index = 1 is "ba", which is an anagram of "ab".
The substring with start index = 2 is "ab", which is an anagram of "ab".
```

##### Constraints:

- <code>1 <= s.length, p.length <= 3 * 10<sup>4</sup></code>
- `s` and `p` consist of lowercase English letters.

## Solution

```
from collections import defaultdict, Counter

# Time: O(n)
# Space: O(m)
class Solution:
    def findAnagrams(self, s: str, p: str) -> List[int]:
        m, n = len(s), len(p)
        have = defaultdict(int)
        need = Counter(p)
        correctfreqs, k = 0, len(need)
        result = []
        for r, c in enumerate(s):
            if c in need:
                have[c] += 1
                if have[c] == need[c]:
                    correctfreqs += 1
                elif have[c] == need[c] + 1:
                    correctfreqs -= 1
            if r >= n and s[r - n] in need:
                removed = s[r - n]
                have[removed] -= 1
                if have[removed] == need[removed]:
                    correctfreqs += 1
                elif have[removed] == need[removed] - 1:
                    correctfreqs -= 1
            if correctfreqs == k:
                result.append(r - n + 1)

        return result
```

## Notes
- Sliding window and character frequency tracking in the window.