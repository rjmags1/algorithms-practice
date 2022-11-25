# 233. Number of Digit One - Hard

Given an integer `n`, count the total number of digit `1` appearing in all non-negative integers less than or equal to `n`.

##### Example 1:

```
Input: n = 13
Output: 6
```

##### Example 2:

```
Input: n = 0
Output: 0
```

##### Constraints:

- <code>0 <= n <= 10<sup>9</sup></code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def countDigitOne(self, n: int) -> int:
        result = 0
        for power in range(10):
            mag = 10 ** power
            if mag > n:
                break
            cut = mag * 10
            left, right = n // cut, n % mag
            digit = n - (left * cut) - right
            if power > 0:
                digit //= mag
            if digit == 0:
                result += left * mag
            elif digit == 1:
                result += left * mag + right + 1
            else:
                result += left * mag + mag
        return result
```

## Notes
- This problem is annoying because it is tempting to waste a lot of time trying to come up with a math formula when it can really be solved with a counting/greedy approach. For each digit RTL, we can easily count the number of ones that will ever show up in that position in the range `[1, n]`. Consider the following example:
    ```
    n = xyzdabc, we want to calculate the number of 1s in the thousands place
    (1) xyz * 1000                     if digit d == 0
    (2) xyz * 1000 + abc + 1           if digit d == 1
    (3) xyz * 1000 + 1000              if digit d > 1
    ```
- It is clear that for a given digit, the maximum number of ones that could show up there is equivalent to the magnitude of 10 that the digit represents times the number of thousands in `n`. For the thousands place, there could be `1000` `1`s that show up there at most for each thousand, i.e. `1000, 1001, ... 1998, 1999`. If there are exactly `30` thousands in `n`, i.e. `n == 30000`, then that means three of those thousands will be in the range `[1000, 1999]`, and so there are `3000` `1`s in the result coming from the thounsands place. Similar logic applies for cases where part of a range on `[1000, 1999]` contributes to the `1`s for a particular position, and for cases where there is a digit greater than `1` in the thousands place.