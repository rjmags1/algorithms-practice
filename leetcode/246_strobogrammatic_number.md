# 246. Strobogrammatic Number - Easy

Given a string `num` which represents an integer, return `true` if `num` is a strobogrammatic number.

A strobogrammatic number is a number that looks the same when rotated `180` degrees (looked at upside down).

##### Example 1:

```
Input: num = "69"
Output: true
```

##### Example 2:

```
Input: num = "88"
Output: true
```

##### Example 3:

```
Input: num = "962"
Output: false
```

##### Constraints:

- `1 <= num.length <= 50`
- `num` consists of only digits.
- `num` does not contain any leading zeros except for zero itself.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isStrobogrammatic(self, num: str) -> bool:
        strobos = {
            "0": "0",
            "1": "1",
            "6": "9",
            "8": "8",
            "9": "6"
        }
        n = len(num)
        odd, mid = n & 1, n // 2
        if odd and num[mid] not in ["0", "1", "8"]:
            return False
        l = n // 2 - 1
        r = n // 2 if not odd else n // 2 + 1
        while l >= 0:
            cl, cr = num[l], num[r]
            if cl not in strobos or cr not in strobos:
                return False
            if strobos[cl] != cr:
                return False
            l -= 1
            r += 1
        return True
```

## Notes
- Lots of edge cases to handle with these strobo questions. Strobogrammatic numbers are palindromes with extra restrictions related to which characters constitute a match when iterating from center-out and which characters are allowed at the center of a strobogrammatic number.