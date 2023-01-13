# 356. Line Reflection - Medium

Given `n` points on a 2D plane, find if there is such a line parallel to the y-axis that reflects the given points symmetrically.

In other words, answer whether or not if there exists a line that after reflecting all points over the given line, the original points' set is the same as the reflected ones.

Note that there can be repeated points.

##### Example 1:

```
Input: points = [[1,1],[-1,1]]
Output: true
Explanation: We can choose the line x = 0.
```

##### Example 2:

```
Input: points = [[1,1],[-1,-1]]
Output: false
Explanation: We can't choose a line.
```

##### Constraints:

- <code>n == points.length</code>
- <code>1 <= n <= 10<sup>4</sup></code>
- <code>-10<sup>8</sup> <= points[i][j] <= 10<sup>8</sup></code>

Follow-up: Could you do better than <code>O(n<sup>2</sup>)</code>?

## Solution

```
# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def isReflected(self, points: List[List[int]]) -> bool:
        points = list(set([tuple(p) for p in points]))
        n = len(points)
        if n == 1:
            return True
        
        points.sort()
        mid = n // 2
        left = points[:mid]
        right = points[mid + 1:] if n & 1 else points[mid:]
        left.sort(key=lambda p: (p[0], -p[1]))
        
        splitx = (right[-1][0] + left[0][0]) / 2
        i, j = 0, len(right) - 1
        while i < len(left) and j >= 0:
            l, r = left[i], right[j]
            lx, ly = l
            rx, ry = r
            if lx == splitx or rx == splitx:
                if lx == splitx and rx == splitx:
                    i += 1
                    j -= 1
                    continue
                return False
            if ly != ry or (lx + rx) / 2 != splitx:
                return False
            i += 1
            j -= 1
            
        return not n & 1 or points[mid][0] == splitx
```

## Notes
- For any set of __distinct points__ to meet the criteria specified by the prompt, there must be a vertical line such that for every point in the distinct set that lies on the right side of the vertical line, there is another point that lies on the left side of the vertical line that has the same y-coordinate and same horizontal distance magnitude from the vertical line. 
- We can split the array into halves after sorting and then custom sort the left half such that the concatenation of the left half and the right half represent the order of the points if we were to scan left to right in the cartesian (x-y) plane, with special consideration of cases where there are multiple points with a particular x-coordinate that have different y-coordinates (hence the custom sorting of the left half in this solution). If we do this we can scan the two halves in linear time to make sure the distinct set of input points follows the criteria outlined above.
- Note how this solution handles cases where there are multiple duplicate points and more than `2` unique points. In this situation all duplicate points would need to have the same number of duplicates of its reflected point to meet prompt criteria. This solution does not handle this correctly but passes all test cases on leetcode because it reduces to the problem with __distinct points__, however, it incorrectly handles cases if reducing to distinct points is not the desired behavior. To address this particular case correctly we could use a frequency hash table to determine the number of unique points and the number of unique points with duplicates, and then enforce the constraint regarding the same number of reflected duplicates for all duplicate points except duplicates at `splitx`.