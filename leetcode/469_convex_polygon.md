# 469. Convex Polygon - Medium

You are given an array of points on the X-Y plane `points` where `points[i] = [xi, yi]`. The points form a polygon when joined sequentially.

Return `true` if this polygon is convex and `false` otherwise.

You may assume the polygon formed by given points is always a simple polygon. In other words, we ensure that exactly two edges intersect at each vertex and that edges otherwise don't intersect each other.

##### Example 1:

![](../assets/469_1.jpg)

```
Input: points = [[0,0],[0,5],[5,5],[5,0]]
Output: true
```

##### Example 2:

![](../assets/469_2.jpg)

```
Input: points = [[0,0],[0,10],[10,10],[10,0],[5,5]]
Output: false
```

##### Constraints:

- <code>3 <= points.length <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= xi, yi <= 10<sup>4</sup></code>
- `points[i].length == 2`
- All the given points are unique.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isConvex(self, points: List[List[int]]) -> bool:
        def mcomp(a, b, c):
            dir = (b[1] - a[1]) * (c[0] - b[0]) - (c[1] - b[1]) * (b[0] - a[0])
            if dir == 0:
                return 0
            return -1 if dir < 0 else 1
        
        sign = None
        for i in range(1, len(points)):
            a, b, c = points[i - 2], points[i - 1], points[i]
            dir = mcomp(a, b, c)
            if dir == 0:
                continue
            if sign is None:
                sign = dir
                continue
            if dir != sign:
                return False
        last = mcomp(points[-2], points[-1], points[0])
        return last * sign >= 0
```

## Notes
- This is a geometry question that seems complicated and difficult at first but isn't that bad, though it does require prerequisite knowledge of the formula used in this implementation or angle = tan<sup>-1</sup>((m1 - m2) / (1 + m1 * m2)), otherwise the implementation is difficult. For any convex polygon, if we inspect its sides in a clockwise or counterclockwise fashion, the angles of the slopes will either all decrease or increase relative to some arbitrary line in cartesian plane. The formula in `mcomp` expresses this. 