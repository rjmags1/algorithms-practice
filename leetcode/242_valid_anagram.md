# 242. Valid Anagram - Easy

Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`, and `false` otherwise.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

##### Example 1:

```
Input: s = "anagram", t = "nagaram"
Output: true
```

##### Example 2:

```
Input: s = "rat", t = "car"
Output: false
```

##### Constraints:

- <code>1 <= s.length, t.length <= 5 * 10<sup>4</sup></code>
- `s` and `t` consist of lowercase English letters.

Follow-up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?

## Solution

```
# Time: O(n)
# Space: O(c) where c is num chars in charset
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        m, n = len(s), len(t)
        if m != n:
            return False
        
        counts = defaultdict(lambda: [0, 0])
        for i in range(m):
            c0, c1 = s[i], t[i]
            counts[c0][0] += 1
            counts[c1][1] += 1
        return all([count[0] == count[1] for count in counts.values()])
```

## Notes
- Straightforward just make sure case where one word is an anagram of a prefix of other word.