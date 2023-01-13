# 390. Elimination Game - Medium

You have a list `arr` of all integers in the range `[1, n]` sorted in a strictly increasing order. Apply the following algorithm on `arr`:

- Starting from left to right, remove the first number and every other number afterward until you reach the end of the list.
- Repeat the previous step again, but this time from right to left, remove the rightmost number and every other number from the remaining numbers.
- Keep repeating the steps again, alternating left to right and right to left, until a single number remains.

Given the integer `n`, return the last number that remains in `arr`.

##### Example 1:

```
Input: n = 9
Output: 6
Explanation:
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
arr = [2, 4, 6, 8]
arr = [2, 6]
arr = [6]
```

##### Example 2:

```
Input: n = 1
Output: 1
```

##### Constraints:

- <code>1 <= n <= 10<sup>9</sup></code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def lastRemaining(self, n: int) -> int:
        right = True
        l, d = 1, 1
        while n > 1:
            if right or n & 1:
                l += d
            n >>= 1
            d <<= 1
            right = not right
        return l
```

## Notes
- 100% pattern recognition. Every iteration of the algorithm we floor the number of elements in our sequence by two, and the difference `d` between numbers doubles. Additionally, the leftmost element AKA the smallest one in our sequence will be the only one left when we return. We can use all of the above information to always know the leftmost element in our sequence. Whenever we go left, or whenever we go right and there are an odd number of elements in the sequence, the leftmost number in our sequence increases by `d`.