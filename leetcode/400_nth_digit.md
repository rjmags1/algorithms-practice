# 400. Nth Digit - Medium

Given an integer `n`, return the `nth` digit of the infinite integer sequence `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ...]`.

##### Example 1:

```
Input: n = 3
Output: 3
```

##### Example 2:

```
Input: n = 11
Output: 0
Explanation: The 11th digit of the sequence 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ... is a 0, which is part of the number 10.
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def findNthDigit(self, n: int) -> int:
        level = 1
        while 1:
            leveldigits = 9 * 10 ** (level - 1) * level
            if n > leveldigits:
                n -= leveldigits
                level += 1
                continue
            left, right = 10 ** (level - 1), 10 ** level - 1
            start = left
            while left < right:
                mid = (left + right) // 2
                lmid = (mid - start) * level
                rmid = lmid + (level - 1)
                if lmid <= n - 1 <= rmid:
                    left = mid
                    break
                elif n - 1 < lmid:
                    right = mid - 1
                else:
                    left = mid + 1

            return int(str(left)[(n - 1) % level])
```

## Notes
- There are `9` digits in `1-9`, `90 * 2` digits in `10-99`, `900 * 3` digits in `100-999`, and so forth. We want to fix the range of numbers our target digit could be located in such that all of the numbers in the range have the same number of digits; this allows us to be able to perform binary search for the number that contains our target digit. If we don't do this it is inefficient and non-trivial to determine how many digits we rule out with each iteration of binary search.
- We are essentially navigating each level of a denary tree and seeing if the current level contains our target digit. The traversal to correct depth step takes log base 10 of `n` time, and the binary search step takes log base 2 of `k` time where `k` represents the number of integers in the denary tree level in which the `n`th digit resides. `k` is a constant (upper bounded by `2^31 - 10^9`), though a large one, due to input constraints and so I just go with `O(log(n))` for time complexity on this one, where the log is base `10`.