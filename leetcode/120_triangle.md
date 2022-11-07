# 120. Triangle - Medium

Given a `triangle` array, return the minimum path sum from top to bottom.

For each step, you may move to an adjacent number of the row below. More formally, if you are on index `i` on the current row, you may move to either index `i` or index `i + 1` on the next row.

##### Example 1:

```
Input: triangle = [[2],[3,4],[6,5,7],[4,1,8,3]]
Output: 11
Explanation: The triangle looks like:
   2
  3 4
 6 5 7
4 1 8 3
The minimum path sum from top to bottom is 2 + 3 + 5 + 1 = 11 (underlined above).
```

##### Example 2:

```
Input: triangle = [[-10]]
Output: -10
```

##### Constraints:

- `1 <= triangle.length <= 200`
- `triangle[0].length == 1`
- `triangle[i].length == triangle[i - 1].length + 1`
- <code>-10<sup>4</sup> <= triangle[i][j] <= 10<sup>4</sup></code>

Follow-up: Could you do this using only `O(n)` extra space, where `n` is the total number of rows in the triangle?

## Solution

```
# Time: O(n) where n is the number of numbers in triangle
# Space: O(m) where m is the number of rows in of the triangle
class Solution:
    def minimumTotal(self, triangle: List[List[int]]) -> int:
        prev = triangle[0]
        for i, row in enumerate(triangle):
            if i == 0:
                continue
                
            curr = [inf]
            for j, cost in enumerate(prev):
                curr[j] = min(cost + row[j], curr[j])
                if j + 1 > len(curr) - 1:
                    curr.append(inf)
                curr[j + 1] = min(cost + row[j + 1], curr[j + 1])
            prev = curr
        
        return min(prev)
```

## Notes
- This is a dp problem where use the results from previous rows to calculate the results of current row. This one can be kind of tricky if have less experience because normally you would iterate over the current row in the inner `for` loop, but here you actually iterate over the previous row and append to the current row as needed.