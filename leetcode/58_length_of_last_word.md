# 58. Length of Last Word - Easy

Given a string `s` consisting of words and spaces, return the length of the last word in the string.

A word is a maximal substring consisting of non-space characters only.

##### Example 1:

```
Input: s = "Hello World"
Output: 5
Explanation: The last word is "World" with length 5.
```

##### Example 2:

```
Input: s = "   fly me   to   the moon  "
Output: 4
Explanation: The last word is "moon" with length 4.
```

##### Example 3:

```
Input: s = "luffy is still joyboy"
Output: 6
Explanation: The last word is "joyboy" with length 6.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` consists of only English letters and spaces `' '`.
- There will be at least one word in `s`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        start = end = None
        for i in reversed(range(len(s))):
            if s[i] != ' ' and end is None:
                end = i
            elif s[i] == ' ' and end is not None and start is None:
                start = i + 1
                break
        if start is None and end is not None:
            start = 0
        return end - start + 1 if end is not None else 0
```

## Notes
- Pretty straightforward problem, just need to handle edge cases correctly (no leading whitespace, entire string is whitespace).
- Could use builtin functions for more succinct implementation, but hard runtime (not big-O) could potentially suffer, as well as space complexity.