# 546. Remove Boxes - Hard

You are given several `boxes` with different colors represented by different positive numbers.

You may experience several rounds to remove boxes until there is no box left. Each time you can choose some continuous boxes with the same color (i.e., composed of `k` boxes, `k >= 1`), remove them and get `k * k` points.

Return the maximum points you can get.

##### Example 1:

```
Input: boxes = [1,3,2,2,2,3,4,3,1]
Output: 23
Explanation:
[1, 3, 2, 2, 2, 3, 4, 3, 1] 
----> [1, 3, 3, 4, 3, 1] (3*3=9 points) 
----> [1, 3, 3, 3, 1] (1*1=1 points) 
----> [1, 1] (3*3=9 points) 
----> [] (2*2=4 points)
```

##### Example 2:

```
Input: boxes = [1,1,1]
Output: 9
```

##### Example 3:

```
Input: boxes = [1]
Output: 1
```

##### Constraints:

- `1 <= boxes.length <= 100`
- `1 <= boxes[i] <= 100`

## Solution

```
from functools import cache

# Time: O(n^4)
# Space: O(n^3)
class Solution:
    def removeBoxes(self, boxes: List[int]) -> int:
        n = len(boxes)
        @cache
        def dp(i, j, k):
            if i > j:
                return 0
            if i < n - 1 and boxes[i] == boxes[i + 1]:
                return dp(i + 1, j, k + 1) # we care about same color groups
            
            result = (k + 1) ** 2 + dp(i + 1, j, 0) # remove the group now
            for p in range(i + 1, j + 1):
                if boxes[p] == boxes[i]:
                    # remove the group later
                    # delete between curr group and one to
                    # the right so we can get a higher move score
                    result = max(result, dp(i + 1, p - 1, 0) + dp(p, j, k + 1))
            return result
        return dp(0, n - 1, 0)
```

## Notes
- This is a very tricky dp problem because each subproblem depends on information outside of information inside the subarray `boxes[i:j + 1]` we consider in a subproblem. Typically in subarray dp problems, the information we need to solve the subproblem is contained within the subarray. For this problem we need to consider characters contiguous with the bounds of the subarray we are considering that are the same as the characters at the bounds of the subarray. `k` represents the number of characters to the left of `boxes[i:j + 1]` that are contiguous with and equivalent to `boxes[i]`.
- To understand the code, we are essentially recursing in a way that simulates removing groups of boxes such that we ask 'if we were to remove this group `x1`, is it best to just remove this group, or first remove boxes between this group `x1` and any group to the right of the same color `x2` such that the resulting `x1 + x2`, combined with the result of removing the boxes in between `x1` and `x2` yields more score.'