# 118. Pascal's Triangle - Easy

Given an integer `numRows`, return the first `numRows` of Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:

<img src="../assets/PascalTriangleAnimated2.gif" />

##### Example 1:

```
Input: numRows = 5
Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
```

##### Example 2:

```
Input: numRows = 1
Output: [[1]]
```

##### Constraints:

- `1 <= numRows <= 30`

## Solution

```
# Time: O(n) where n is the number of elements in numRows of pascals triangle
# Space: O(n)
class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        res = [[1]]
        for row in range(2, numRows + 1):
            prev = res[-1]
            curr = [1]
            for i in range(1, len(prev)):
                curr.append(prev[i - 1] + prev[i])
            curr.append(1)
            res.append(curr)
        return res
```

## Notes
- This is a dp problem because we use previous row to determine content of current row. We can't optimize on space here because the prompt asks us for all rows in Pascal's triangle `<= numRows`.