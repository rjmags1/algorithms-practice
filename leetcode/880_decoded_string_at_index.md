# 880. Decoded String at Index - Medium

You are given an encoded string `s`. To decode the string to a tape, the encoded string is read one character at a time and the following steps are taken:

- If the character read is a letter, that letter is written onto the tape.
- If the character read is a digit `d`, the entire current tape is repeatedly written `d - 1` more times in total.

Given an integer `k`, return the `k`th letter (`1`-indexed) in the decoded string.

##### Example 1:

```
Input: s = "leet2code3", k = 10
Output: "o"
Explanation: The decoded string is "leetleetcodeleetleetcodeleetleetcode".
The 10th letter in the string is "o".
```

##### Example 2:

```
Input: s = "ha22", k = 5
Output: "h"
Explanation: The decoded string is "hahahaha".
The 5th letter is "h".
```

##### Example 3:

```
Input: s = "a2345678999999999999999", k = 1
Output: "a"
Explanation: The decoded string is "a" repeated 8301530446056247680 times.
The 1st letter is "a".
```

##### Constraints:

- `2 <= s.length <= 100`
- `s` consists of lowercase English letters and digits `2` through `9`.
- `s` starts with a letter.
- <code>1 <= k <= 10<sup>9</sup></code>
- It is guaranteed that `k` is less than or equal to the length of the decoded string.
- The decoded string is guaranteed to have less than <code>2<sup>63</sup></code> letters.

## Solution

```
# Time: O(len(s))
# Space: O(1)
class Solution:
    def decodeAtIndex(self, s: str, k: int) -> str:
        n = 0
        for c in s:
            if c.isdigit():
                n *= int(c)
            else:
                n += 1

        for c in reversed(s):
            if c.isdigit():
                n //= int(c)
                k %= n
            else:
                if k == n or k == 0:
                    return c
                n -= 1
```

## Notes
- Pretty difficult for a medium, solution is unique. Given the constraints it is clear we cannot naively build the decoded string, so we need some other way to find the `k` letter. Whenever the decoded string gets expanded due to the presence of a digit in the encoded string, the letters in the previous decoded string `d` will be repeated every `d` indexes. So if we know the length of the final decoded string, we can work backwards. 