# 1444. Number of Ways of Cutting a Pizza - Hard

Given a rectangular pizza represented as a `rows x cols` matrix containing the following characters: `'A'` (an apple) and `'.'` (empty cell) and given the integer `k`. You have to cut the pizza into k pieces using `k-1` cuts. 

For each cut you choose the direction: vertical or horizontal, then you choose a cut position at the cell boundary and cut the pizza into two pieces. If you cut the pizza vertically, give the left part of the pizza to a person. If you cut the pizza horizontally, give the upper part of the pizza to a person. Give the last piece of pizza to the last person.

Return the number of ways of cutting the pizza such that each piece contains at least one apple. Since the answer can be a huge number, return this modulo 10^9 + 7.

##### Example 1:

![](../assets/1444_apples.png)

```
Input: pizza = ["A..","AAA","..."], k = 3
Output: 3 
Explanation: The figure above shows the three ways to cut the pizza. Note that pieces must contain at least one apple.
```

##### Example 2:

```
Input: pizza = ["A..","AA.","..."], k = 3
Output: 1
```

##### Example 3:

```
Input: pizza = ["A..","A..","..."], k = 1
Output: 1
```

##### Constraints:

- `1 <= rows, cols <= 50`
- `rows == pizza.length`
- `cols == pizza[i].length`
- `1 <= k <= 10`
- `pizza` consists of characters `'A'` and `'.'` only.

## Solution

```
from functools import cache

# Time: O(m^2 * n^2 * k)
# Space: O(m^2 * n^2 * k)
class Solution:
    def ways(self, pizza: List[str], k: int) -> int:
        m, n = len(pizza), len(pizza[0])
        sums = [[0 for _ in range(n)] for _ in range(m)]
        for i in range(m):
            for j in range(n):
                top = 0 if i == 0 else sums[i - 1][j]
                left = 0 if j == 0 else sums[i][j - 1]
                topleft = 0 if i == 0 or j == 0 else sums[i - 1][j - 1]
                sums[i][j] = top + left - topleft + int(pizza[i][j] == "A")
        
        def insquare(i1, i2, j1, j2):
            if i1 > i2 or j1 > j2:
                return 0
            top = 0 if i1 == 0 else sums[i1 - 1][j2]
            left = 0 if j1 == 0 else sums[i2][j1 - 1]
            topleft = 0 if i1 == 0 or j1 == 0 else sums[i1 - 1][j1 - 1]
            return sums[i2][j2] - top - left + topleft
        
        M = 10 ** 9 + 7
        @cache
        def rec(i1, i2, j1, j2, cuts):
            if cuts == 0:
                return 1
            result = 0
            for j in range(j1, j2):
                if insquare(i1, i2, j1, j) and insquare(i1, i2, j + 1, j2):
                    result += rec(i1, i2, j + 1, j2, cuts - 1)
                    result %= M
            for i in range(i1, i2):
                if insquare(i1, i, j1, j2) and insquare(i + 1, i2, j1, j2):
                    result += rec(i + 1, i2, j1, j2, cuts - 1)
                    result %= M
            return result
                
        return rec(0, m - 1, 0, n - 1, k - 1)
```

## Notes
- To do this in reasonable time, we need to make use of precomputed 2D prefix sums that allow us to determine the number of apples in a particular sub-matrix in constant time during the course of the main algorithm. We are essentially calculating and memoizing on the number of valid ways to cut a particular submatrix with a particular amount of cuts left in this problem, and using the answers to smaller subproblems to answer larger subproblem in typical DP fashion. This top-down/memoization solution is more intuitive than the more space-efficient 2D matrix DP solution IMO.