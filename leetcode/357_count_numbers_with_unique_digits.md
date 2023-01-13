# 357. Count Numbers with Unique Digits - Medium

Given an integer `n`, return the count of all numbers with unique digits, `x`, where <code>0 <= x < 10<sup>n</sup></code>.

##### Example 1:

```
Input: n = 2
Output: 91
Explanation: The answer should be the total numbers in the range of 0 ≤ x < 100, excluding 11,22,33,44,55,66,77,88,99
```

##### Example 2:

```
Input: n = 0
Output: 1
```

##### Constraints:

- `0 <= n <= 8`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1
        
        available = [9, 9, 8, 7, 6, 5, 4, 3]
        result, wcurrdigits = 1, 1
        for digit in range(n):
            wcurrdigits *= available[digit]
            result += wcurrdigits
            
        return result
```

## Notes
- This is a fairly basic permutation problem. For the ones place in a number there are `9` digits available, for the tens place in a number there are `9` digits available because we can use `0`, for the hundreds place there are `8`, for thousands `7`, and so on. For each decimal place, we use basic permutation logic to find the number of combinations of digits that build a unique number with the current number of decimal places, and add this amount to the result. So we calculate the unique numbers in `0-9`, then `10-99`, then `100-999`, etc. using permutations.