# 119. Pascal's Triangle II - Easy

Given an integer rowIndex, return the rowIndexth (0-indexed) row of the Pascal's triangle.

In Pascal's triangle, each number is the sum of the two numbers directly above it as shown:

<img src="../assets/PascalTriangleAnimated2.gif" />

##### Example 1:

```
Input: rowIndex = 3
Output: [1,3,3,1]
```

##### Example 2:

```
Input: rowIndex = 0
Output: [1]
```

##### Example 3:

```
Input: rowIndex = 1
Output: [1,1]
```

##### Constraints:

- `0 <= rowIndex <= 33`

Follow-up: Could you optimize your algorithm to use only `O(rowIndex)` extra space?

## Solution

```
# Time: O(n) where n is the number of elements in pascals triangle with rowIndex + 1 rows
# Space: O(n)
class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        prev = [1]
        for i in range(1, rowIndex + 1):
            curr = [1]
            for j in range(len(prev) - 1):
                curr.append(prev[j] + prev[j + 1])
            curr.append(1)
            prev = curr
        
        return prev
```

## Notes
- Here we rely on Python's garbage collector to achieve `O(rowIndex)` space; we will only ever have 2 `O(rowIndex)` size dp arrays allocated to memory at a time.