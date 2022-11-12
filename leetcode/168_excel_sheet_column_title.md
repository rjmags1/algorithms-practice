# 168. Excel Sheet Column Title - Easy

Given an integer `columnNumber`, return its corresponding column title as it appears in an Excel sheet.

For example:
```
A -> 1
B -> 2
C -> 3
...
Z -> 26
AA -> 27
AB -> 28 
...
```

##### Example 1:

```
Input: columnNumber = 1
Output: "A"
```

##### Example 2:

```
Input: columnNumber = 28
Output: "AB"
```

##### Example 3:

```
Input: columnNumber = 701
Output: "ZY"
```

##### Constraints:

- <code>1 <= columnNumber <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(log(n)) (log base 26)
# Space: O(log(n))
class Solution:
    def convertToTitle(self, columnNumber: int) -> str:
        radix, exp = 26, 0
        result = []
        offset = ord("A") - 1
        while columnNumber:
            fromCurrPow = columnNumber % (radix ** (exp + 1))
            char = "Z" if fromCurrPow == 0 else chr(offset + (fromCurrPow // (radix ** exp)))
            result.append(char)
            if fromCurrPow == 0:
                fromCurrPow = radix ** (exp + 1)
            columnNumber -= fromCurrPow
            exp += 1
            
        return "".join(reversed(result))
```

## Notes
- This question is tricky for people unfamiliar with alternative base-numbering systems. The excel sheet column titles described in the question are base-26, and so we are being asked to construct a base-26 number from a base-10 number. Just like how base-10 numbers come from the equation <code>a * 10<sup>0</sup></code> + <code>b * 10<sup>1</sup></code> + <code>c * 10<sup>2</sup></code>..., base-26 numbers come from the equation <code>a * 26<sup>0</sup></code> + <code>b * 26<sup>1</sup></code> + <code>c * 26<sup>2</sup></code>... . The `0` power sequence elements represent the leftmost digit (`1`s place), the `1` power sequence elements represent the next leftmost digit (`10`s place for decimal, 26s place for base-26), and so on. 
- This question is essentially asking us to find the values of `a`, `b`, `c`, etc. in the above base-26 sequence. We can do this by getting rid of the amount of the current `columnNumber` that comes from powers of `26` greater than the current power, and then flooring that amount by the current power of `26`. It may not be intuitive that `(columnNumber % (26 ** (exp + 1))) // (26 ** exp)` does this, but it is analagous to how in base-10, if we have `1234` and want the value in the hundreds place we would do `(1234 % (10 ** 3)) // (10 ** 2)`. This is because powers of a number divided by powers of that same number that are less than the power in the dividend will always have a remainder of `0`: consider <code>26 * 26 * 26 * 26 * 26 == 26<sup>5</sup> / 26<sup>4</sup> == 26</code> with remainder `0`.
- We need to watch out for edge case where we get a remainder of `0` when we determine the amount of the current `columnNumber` that comes from the current power of `26`; this means that the letter value we are looking for (`a`, `b`, `c`, etc.) is `26` itself, i.e. <code>(n * 26<sup>k</sup>) % (26 * 26<sup> k - 1</sup>) == 0</code> always. 