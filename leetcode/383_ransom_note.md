# 383. Ransom Note - Easy

Given two strings `ransomNote` and `magazine`, return `true` if `ransomNote` can be constructed by using the letters from magazine and `false` otherwise.

Each letter in `magazine` can only be used once in `ransomNote`.

##### Example 1:

```
Input: ransomNote = "a", magazine = "b"
Output: false
```

##### Example 2:

```
Input: ransomNote = "aa", magazine = "ab"
Output: false
```

##### Example 3:

```
Input: ransomNote = "aa", magazine = "aab"
Output: true
```

##### Constraints:

- <code>1 <= ransomNote.length, magazine.length <= 10<sup>5</sup></code>
- `ransomNote` and `magazine` consist of lowercase English letters.

## Solution

```
# Time: O(m)
# Space: O(1)
class Solution:
    def canConstruct(self, ransomNote: str, magazine: str) -> bool:
        if len(magazine) < len(ransomNote):
            return False

        m, r, offset = [0] * 26, [0] * 26, ord('a')
        for c in magazine:
            m[ord(c) - offset] += 1
        for c in ransomNote:
            r[ord(c) - offset] += 1
        return all(a >= b for a, b in zip(m, r))
```

## Notes
- Constant space because our charset is constant sized. Time is proportional to magazine because it is pointless to check all characters of a `ransomNote` that is longer than `magazine`.