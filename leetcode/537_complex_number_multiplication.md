# 537. Complex Number Multiplication - Medium

A complex number can be represented as a string on the form `"real+imaginaryi"` where:

- `real` is the real part and is an integer in the range `[-100, 100]`.
- `imaginary` is the imaginary part and is an integer in the range `[-100, 100]`.
- <code>i<sup>2</sup> == -1</code>.

Given two complex numbers `num1` and `num2` as strings, return a string of the complex number that represents their multiplications.

##### Example 1:

```
Input: num1 = "1+1i", num2 = "1+1i"
Output: "0+2i"
Explanation: (1 + i) * (1 + i) = 1 + i2 + 2 * i = 2i, and you need convert it to the form of 0+2i.
```

##### Example 2:

```
Input: num1 = "1+-1i", num2 = "1+-1i"
Output: "0+-2i"
Explanation: (1 - i) * (1 - i) = 1 + i2 - 2 * i = -2i, and you need convert it to the form of 0+-2i.
```

##### Constraints:

- `num1` and `num2` are valid complex numbers.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def complexNumberMultiply(self, num1: str, num2: str) -> str:
        j1, j2 = num1.index('+'), num2.index('+')
        r1, i1 = int(num1[:j1]), int(num1[j1 + 1:-1])
        r2, i2 = int(num2[:j2]), int(num2[j2 + 1:-1])
        a = r1 * r2
        b = r1 * i2
        c = r2 * i1
        d = i1 * i2
        return f"{a - d}+{b + c}i"
```

## Notes
- Straightforward for a medium, just basic math.