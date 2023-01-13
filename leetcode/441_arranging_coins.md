# 441. Arranging Coins - Easy

You have `n` coins and you want to build a staircase with these coins. The staircase consists of `k` rows where the `ith` row has exactly `i` coins. The last row of the staircase may be incomplete.

Given the integer `n`, return the number of complete rows of the staircase you will build.

##### Example 1:

```
Input: n = 5
Output: 2
Explanation: Because the 3rd row is incomplete, we return 2.
```

##### Example 2:

```
Input: n = 8
Output: 3
Explanation: Because the 4th row is incomplete, we return 3.
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def arrangeCoins(self, n: int) -> int:
        def gauss(n):
            result = (1 + n) * (n // 2)
            if n & 1:
                result += n // 2 + 1
            return result

        l, r = 0, n
        while l <= r:
            rows = (l + r) // 2
            g = gauss(rows)
            if g == n:
                return rows
            elif g < n:
                l = rows + 1
            else:
                r = rows - 1
        return r
```

## Notes
- Binary search with gauss summation sequence formula to determine the number of rows we can build with `n` coins in constant time as we binary search. We binary search for the largest number of rows we can build with `n` coins. `g` is number of coins we need to build `rows` complete rows in the above solution.