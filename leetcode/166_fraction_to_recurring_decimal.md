# 166. Fraction to Recurring Decimal - Medium

Given two integers representing the `numerator` and `denominator` of a fraction, return the fraction in string format.

If the fractional part is repeating, enclose the repeating part in parentheses.

If multiple answers are possible, return any of them.

It is guaranteed that the length of the answer string is less than <code>10<sup>4</sup></code> for all the given inputs.

##### Example 1:

```
Input: numerator = 1, denominator = 2
Output: "0.5"
```

##### Example 2:

```
Input: numerator = 2, denominator = 1
Output: "2"
```

##### Example 3:

```
Input: numerator = 4, denominator = 333
Output: "0.(012)"
```

##### Constraints:

- <code>-2<sup>31</sup> <= numerator, denominator <= 2<sup>31</sup> - 1</code>
- `denominator != 0`

## Solution

```
# Time: O(1) (we are guaranteed upper limit of 10^4 on result size)
# Space: O(1) (we are guaranteed upper limit of 10^4 on result size)
class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        if numerator == 0:
            return "0"
        
        numsign = -1 if numerator < 0 else 1
        densign = -1 if denominator < 0 else 1
        sign = numsign * densign
        numerator, denominator = abs(numerator), abs(denominator)
        if numerator % denominator == 0 and numerator >= denominator:
            return str(sign * (numerator // denominator))
        
        result = [str(numerator // denominator), "."]
        remainder = numerator % denominator
        remainders, i = {}, 2
        while remainder != 0:
            if remainder in remainders:
                k = remainders[remainder]
                repeat = "(" + "".join(result[k:]) + ")"
                absv = "".join(result[:k]) + repeat
                return "-" + absv if sign == -1 else absv
            
            remainders[remainder] = i
            i += 1
            remainder *= 10
            result.append(str(remainder // denominator))
            remainder %= denominator
            
        return "-" + "".join(result) if sign == -1 else "".join(result)
```

## Notes
- Unless you did long division yesterday this is a pretty difficult problem. Though it is straightforward in the sense that you just do exactly what the prompt tells you to, there are a lot of edge cases to handle in addition to needing to recognize how to identify a repeating decimal.
- Aforementioned edge cases include negative quotients, integer quotients, and non-repeating and repeating decimal quotients. The last is the trickiest to handle.
- Repeating decimals occur when, in the process of doing long division, we encounter the same remainders over and over again. If we see a remainder a second time, that means that we will enter a remainder cycle (do long division on the third example and see what I mean), so as long as we know the index of the element that got appended to `result` the first time we say that remainder, we can identify the repeating portion of the decimal of our quotient result.