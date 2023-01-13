# 345. Reverse Vowels of a String - Easy

Given a string `s`, reverse only all the vowels in the string and return it.

The vowels are `'a'`, `'e'`, `'i'`, `'o'`, and `'u'`, and they can appear in both lower and upper cases, more than once.

##### Example 1:

```
Input: s = "hello"
Output: "holle"
```

##### Example 2:

```
Input: s = "leetcode"
Output: "leotcede"
```

##### Constraints:

- <code>1 <= s.length <= 3 * 10<sup>5</sup></code>
- `s` consist of printable ASCII characters.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def reverseVowels(self, s: str) -> str:
        s = [c for c in s]
        i, j = 0, len(s) - 1
        v = ['a', 'e', 'i', 'o', 'u']
        v += [c.upper() for c in v]
        while i < j:
            iv, jv = s[i] in v, s[j] in v
            if iv and jv:
                s[i], s[j] = s[j], s[i]
                i += 1
                j -= 1
            else:
                if not iv:
                    i += 1
                if not jv:
                    j -= 1
        return "".join(s)
```

## Notes
- Get the next unswapped vowel on either side and swap them.