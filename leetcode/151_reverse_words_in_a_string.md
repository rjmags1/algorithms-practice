# 151. Reverse Words in a String - Medium

Given an input string `s`, reverse the order of the words.

A word is defined as a sequence of non-space characters. The words in `s` will be separated by at least one space.

Return a string of the words in reverse order concatenated by a single space.

Note that `s` may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.

##### Example 1:

```
Input: s = "the sky is blue"
Output: "blue is sky the"
```

##### Example 2:

```
Input: s = "  hello world  "
Output: "world hello"
Explanation: Your reversed string should not contain leading or trailing spaces.
```

##### Example 3:

```
Input: s = "a good   example"
Output: "example good a"
Explanation: You need to reduce multiple spaces between two words to a single space in the reversed string.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` contains English letters (upper-case and lower-case), digits, and spaces `' '`.
- There is at least one word in `s`.

Follow-up: If the string data type is mutable in your language, can you solve it in-place with `O(1)` extra space?

## Solution

```
# Time: O(n) (4 pass)
# Space: O(1)
class Solution:
    def reverseWords(self, s: str) -> str:
        chars, prev, seennonws = [], None, False
        for c in s:
            if c == " ":
                if not seennonws or prev == " ":
                    continue
            else:
                seennonws = True
            chars.append(c)
            prev = c
        while chars and chars[-1] == " ":
            chars.pop()
        
        def revRange(i, j):
            while i < j:
                chars[i], chars[j] = chars[j], chars[i]
                i += 1
                j -= 1
            
        chars.reverse()
        i, n = 0, len(chars)
        for j in range(n):
            if j == n - 1 or chars[j + 1] == " ":
                revRange(i, j)
                i = j + 2
        
        return "".join(chars)
```

## Notes
- If strings were immutable in python this could be done in constant space in `3` passes: one for trimming + reversing, and `2` for iterating of trimmed and reversing individual words (assuming leading and trailing whitespaces can be removed in constant time and space). 