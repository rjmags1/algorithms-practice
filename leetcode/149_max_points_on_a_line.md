# 149. Max Points on a Line

Given an array of `points` where <code>points[i] = [x<sub>i</sub>, y<sub>i</sub>]</code> represents a point on the X-Y plane, return the maximum number of points that lie on the same straight line.

##### Example 1:

```
Input: points = [[1,1],[2,2],[3,3]]
Output: 3
```

##### Example 2:

```
Input: points = [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
Output: 4
```

##### Constraints:

- `1 <= points.length <= 300`
- `points[i].length == 2`
- <code>-10<sup>4</sup> <= xi, yi <= 10<sup>4</sup></code>
- All the points are unique.

## Solution

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        n = len(points)
        result = 1
        for i in range(n - 1):
            x1, y1 = points[i]
            slopesthru = defaultdict(lambda : 1)
            for j in range(i + 1, n):
                x2, y2 = points[j]
                dx = x1 - x2
                dy = y1 - y2
                m = None
                if dx == 0:
                    m = f"v-{x1}"
                elif dy == 0:
                    m = f"h-{y1}"
                else:
                    neg = dx * dy < 0
                    dx, dy = abs(dx), abs(dy)
                    f = gcd(dx, dy)
                    dx //= f
                    dy //= f
                    if neg:
                        dx *= -1
                    m = f"{dx}/{dy}"
                slopesthru[m] += 1
                result = max(result, slopesthru[m])
        
        return result
```

## Notes
- There are two tricks to this problem that make it easy if you pick up on them: non-integer slopes can be represented as simplified (reduced to lowest numerator and denominator using gcd) to avoid imprecision from floats. Second, we avoid a lot of edge cases/extra complexity by reducing the problem to finding the largest number of points on the same line as a particular point, and doing this for each point in the input. With this strategy, we don't need to worry about y intercepts.