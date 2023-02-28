# 593. Valid Square - Medium

Given the coordinates of four points in 2D space `p1`, `p2`, `p3` and `p4`, return `true` if the four points construct a square.

The coordinate of a point `pi` is represented as `[xi, yi]`. The input is not given in any order.

A valid square has four equal sides with positive length and four equal angles (90-degree angles).

##### Example 1:

```
Input: p1 = [0,0], p2 = [1,1], p3 = [1,0], p4 = [0,1]
Output: true
```

##### Example 2:

```
Input: p1 = [0,0], p2 = [1,1], p3 = [1,0], p4 = [0,12]
Output: false
```

##### Example 3:

```
Input: p1 = [1,0], p2 = [-1,0], p3 = [0,1], p4 = [0,-1]
Output: true
```

##### Constraints:

- <code>p1.length == p2.length == p3.length == p4.length == 2</code>
- <code>-10<sup>4</sup> <= xi, yi <= 10<sup>4</sup></code>

## Solution

```
from collections import defaultdict

class Solution:
    def validSquare(self, p1: List[int], p2: List[int], p3: List[int], p4: List[int]) -> bool:
        d = lambda p1, p2: (p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2
        pts = (p1, p2, p3, p4)
        dists = defaultdict(list)
        for i, p1 in enumerate(pts):
            for j in range(i + 1, 4):
                p2 = pts[j]
                dists[d(p1, p2)].append((p1, p2))
        sidelen, sides = max(dists.items(), key=lambda p: len(p[1]))
        return len(sides) == 4 and len(dists[sidelen * 2]) == 2 # pythagorean theorem
```

## Notes
- Enumerate the distances between all possible pairs of points. If the points form a square, there will be one distance that has `4` pairs equivalent to it. This is not enough to guarantee a square, however; a non-square parallelogram of equal sides will satisfy this constraint. To guarantee a square, the first constraint needs to be satisfied, and the sum of squares of a side must also equal the squared length of the diagonal.