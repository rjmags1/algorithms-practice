# 186. Reverse Words In a String II - Medium

Given a character array `s`, reverse the order of the words.

A word is defined as a sequence of non-space characters. The words in `s` will be separated by a single space.

Your code must solve the problem in-place, i.e. without allocating extra space.

##### Example 1:

```
Input: s = ["t","h","e"," ","s","k","y"," ","i","s"," ","b","l","u","e"]
Output: ["b","l","u","e"," ","i","s"," ","s","k","y"," ","t","h","e"]
```

##### Example 2:

```
Input: s = ["a"]
Output: ["a"]
```

## Constraints

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s[i]` is an English letter (uppercase or lowercase), digit, or space `' '`.
- There is at least one word in `s`.
- `s` does not contain leading or trailing spaces.
- All the words in `s` are guaranteed to be separated by a single space.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def reverseWords(self, s: List[str]) -> None:
        """
        Do not return anything, modify s in-place instead.
        """
        def revrange(l, r):
            while l < r:
                s[l], s[r] = s[r], s[l]
                l += 1
                r -= 1
        
        s.reverse()
        n = len(s)
        l = 0
        for r in range(n + 1):
            if r == n or s[r] == " ":
                revrange(l, r - 1)
                l = r + 1
```

## Notes
- Simple