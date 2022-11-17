# 85. Maximal Rectangle - Hard

Given a `rows x cols` binary `matrix` filled with `0`'s and `1`'s, find the largest rectangle containing only `1`'s and return its area.

##### Example 1:

```
Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
Output: 6
```

##### Example 2:

```
Input: matrix = [["0"]]
Output: 0
```

##### Example 3:

```
Input: matrix = [["1"]]
Output: 1
```

##### Constraints:

- `rows == matrix.length`
- `cols == matrix[i].length`
- `1 <= row, cols <= 200`
- `matrix[i][j]` is `'0'` or `'1'`.

## Solution 1

```
# Time: O(min(m, n) * m * n)
# Space: O(mn)
class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        n, m = len(matrix), len(matrix[0])
        result = cons = 0
        dp1 = [[int(s) for s in row] for row in matrix]
        dp2 = [[0] * m for _ in range(n)]
        for i in range(n):
            for j in range(m):
                cons = 0 if matrix[i][j] == "0" else cons + 1
                result = max(result, cons)
            cons = 0
        for j in range(m):
            for i in range(n):
                cons = 0 if matrix[i][j] == "0" else cons + 1
                result = max(result, cons)
            cons = 0
        
        prevdp, currdp = dp1, dp2
        maxSquareDim = min(n, m)
        for dim in range(2, maxSquareDim + 1):
            for i in range(dim - 1, n):
                cons = 0
                for j in range(dim - 1, m):
                    if matrix[i][j] == "0":
                        cons = currdp[i][j] = 0
                    else:
                        isOnesSquare = prevdp[i - 1][j] > 0 and \
                            prevdp[i][j - 1] > 0 and prevdp[i - 1][j - 1] > 0
                        if not isOnesSquare:
                            currdp[i][j] = cons = 0
                            continue
                            
                        cons += 1
                        currdp[i][j] = 1 if i == dim - 1 else 1 + currdp[i - 1][j]
                        maxH = dim + (currdp[i][j] - 1)
                        maxW = dim + (cons - 1)
                        area1, area2 = maxH * dim, maxW * dim
                        result = max(result, area1, area2)
                    
            currdp, prevdp = prevdp, currdp
        
        return result
```

## Notes
- This was my naive solution that took me a couple hours to finish on my first attempt. It is overcomplicated because I overlooked the overlap of this problem with 84. Largest Rectangle in Histogram. It relies on the fact that rectangles can be composed of squares. I.e., for a particular `i` and `j`, if `matrix[i][j] == 1` and there are squares containing all `1`s of `dim` (dimension) `2` whose bottom right corners are at `(i - 1, j)`, `(i, j - 1)`, and `(i - 1, j - 1)`, then we can say for sure that there is a rectangle with width and height `>= 3` that contains all `1`s whose bottom right corner is located at `i` and `j`. `currdp` holds the number of vertical slides squares with dimensions `dim` can move vertically in a rectangle of width `dim` whose bottom right corner is at `i` and `j`. This allows us to determine the max height of that rectangle. We use a variable `cons` to determine the max width of a given rectangle based on the number of consecutive `1`s in the row. From there the rest of the logic is trivial.

## Solution 2

```
# Time: O(mn)
# Space: O(n)
class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        m, n = len(matrix), len(matrix[0])
        def largestInHisto(histo):
            stack = [-1]
            histo.append(-1)
            result = 0
            for i, h in enumerate(histo):
                if stack[-1] == -1 or h >= histo[stack[-1]]:
                    stack.append(i)
                    continue
                
                while stack[-1] != -1 and histo[stack[-1]] > h:
                    poppedIdx = stack.pop()
                    popped = histo[poppedIdx]
                    w = i - stack[-1] - 1
                    result = max(result, w * popped)
                stack.append(i)
                
            histo.pop()
            return result
        
        dp = [0] * n
        result = 0
        for row in matrix:
            for j, cell in enumerate(row):
                dp[j] = 0 if cell == "0" else dp[j] + 1
            result = max(result, largestInHisto(dp))
        
        return result
```

## Notes
- This is much cleaner than my Solution 1; we simply consider each row as a histogram and run the logic from 84. Largest Rectangle in Histogram on it. For each row, the height of the bar at an index `j` is zero if `matrix[i][j] == "0"`, otherwise its whatever the height of the bar for `j` was for the previous row plus `1`. In other words, we consider each row as the base of a histogram.