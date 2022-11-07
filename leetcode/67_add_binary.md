# 67. Add Binary - Easy

Given two binary strings `a` and `b`, return their sum as a binary string.

##### Example 1:

```
Input: a = "11", b = "1"
Output: "100"
```

##### Example 2:

```
Input: a = "1010", b = "1011"
Output: "10101"
```

##### Constraints:

- <code>1 <= a.length, b.length <= 10<sup>4</sup></code>
- `a` and `b` consist only of `'0'` or `'1'` characters.
- Each string does not contain leading zeros except for the zero itself.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def addBinary(self, a: str, b: str) -> str:
        i, j = len(a) - 1, len(b) - 1
        result, carry = [], 0
        while i >= 0 or j >= 0 or carry:
            digit1 = int(a[i]) if i >= 0 else 0
            digit2 = int(b[j]) if j >= 0 else 0
            digitSum = digit1 + digit2 + carry
            result.append(str(digitSum & 1))
            carry = digitSum // 2
            i -= 1
            j -= 1
        
        return "".join(reversed(result))
```

## Notes
- Straightforward, just don't prematurely end main loop in the case where `i < 0` and `j < 0` but `carry == 1`.
- In binary addition, we carry whenever the sum of two digits is `> 1`. Possible sums are `0, 1, 2`, and `3` if we add two `1` digits and also have a carry from addition of previous digits.