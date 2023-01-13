# 415. Add Strings - Easy

Given two non-negative integers, `num1` and `num2` represented as string, return the sum of `num1` and `num2` as a string.

You must solve the problem without using any built-in library for handling large integers (such as `BigInteger`). You must also not convert the inputs to integers directly.

##### Example 1:

```
Input: num1 = "11", num2 = "123"
Output: "134"
```

##### Example 2:

```
Input: num1 = "456", num2 = "77"
Output: "533"
```

##### Example 3:

```
Input: num1 = "0", num2 = "0"
Output: "0"
```

##### Constraints:

- <code>1 <= num1.length, num2.length <= 10<sup>4</sup></code>
- `num1` and `num2` consist of only digits.
- `num1` and `num2` don't have any leading zeros except for the zero itself.

## Solution

```
# Time: O(max(m, n))
# Space: O(max(m, n))
class Solution:
    def addStrings(self, num1: str, num2: str) -> str:
        m, n = len(num1), len(num2)
        i, j, carry = m - 1, n - 1, 0
        result = []
        while (i >= 0 and j >= 0) or carry:
            d1 = int(num1[i]) if i > -1 else 0
            d2 = int(num2[j]) if j > -1 else 0
            dsum = d1 + d2 + carry
            result.append(str(dsum if dsum < 10 else dsum - 10))
            carry = dsum // 10
            i -= 1
            j -= 1
        joined = "".join(result[::-1])
        if i > -1:
            return num1[:i + 1] + joined
        if j > -1:
            return num2[:j + 1] + joined
        return joined
```

## Notes
- Elementary math, don't forget to handle carry, as well as case where we have completely iterated through one or both inputs but we still have a carry to do, as in the case `'9' + '9' = '18'`.