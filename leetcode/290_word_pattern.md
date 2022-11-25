# 290. Word Pattern - Easy

Given a `pattern` and a string `s`, find if `s` follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in `s`.

##### Example 1:

```
Input: pattern = "abba", s = "dog cat cat dog"
Output: true
```

##### Example 2:

```
Input: pattern = "abba", s = "dog cat cat fish"
Output: false
```

##### Example 3:

```
Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false
```

##### Constraints:

- `1 <= pattern.length <= 300`
- `pattern` contains only lower-case English letters.
- `1 <= s.length <= 3000`
- `s` contains only lowercase English letters and spaces `' '`.
- `s` does not contain any leading or trailing spaces.
- All the words in `s` are separated by a single space.

## Solution

```
# Time: O(n + m)
# Space: O(n + m)
class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        i, n = 0, len(s)
        pw, wp = {}, {}
        for c in pattern:
            if i == n:
                return False
            
            k = i
            while i < n and s[i] != " ":
                i += 1
            w = s[k:i]
            if i != n:
                i += 1
            
            if c in pw and w in wp and pw[c] == w:
                continue
            if c not in pw and w not in wp:
                pw[c], wp[w] = w, c
            else:
                return False
                    
        return i == n
```

## Notes
- We are dealing with __bijections__, so we need to store _both directions_ of a bijection to ensure correct mapping as we go character for character, word for word in `pattern` and `s`.
- If we choose to split `s` into its words we could easily check for case where the number of words doesn't match the number of pattern characters, however if we want to avoid the associated space we need to handle both cases where the number of words is not equal to the number of pattern characters individually.