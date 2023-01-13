# 391. Perfect Rectangle - Hard

Given an array `rectangles` where `rectangles[i] = [xi, yi, ai, bi]` represents an axis-aligned rectangle. The bottom-left point of the rectangle is `(xi, yi)` and the top-right point of it is `(ai, bi)`.

Return `true` if all the rectangles together form an exact cover of a rectangular region.

##### Example 1:

```
Input: rectangles = [[1,1,3,3],[3,1,4,2],[3,2,4,4],[1,3,2,4],[2,3,3,4]]
Output: true
Explanation: All 5 rectangles together form an exact cover of a rectangular region.
```

##### Example 2:

```
Input: rectangles = [[1,1,2,3],[1,3,2,4],[3,1,4,2],[3,2,4,4]]
Output: false
Explanation: Because there is a gap between the two rectangular regions.
```

##### Example 3:

```
Input: rectangles = [[1,1,3,3],[3,1,4,2],[1,3,2,4],[2,2,4,4]]
Output: false
Explanation: Because two of the rectangles overlap with each other.
```

##### Constraints:

- <code>1 <= rectangles.length <= 2 * 10<sup>4</sup></code>
- <code>-10<sup>5</sup> <= xi, yi, ai, bi <= 10<sup>5</sup></code>
- <code>rectangles[i].length == 4</code>

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(n)
class Solution:
    def overlapdims(self, d):
        for dim, l in d.items():
            l.sort(key=lambda x: x[0])
            for i in range(1, len(l)):
                if l[i][0] < l[i - 1][1]:
                    return True
        return False

    def isRectangleCover(self, rectangles: List[List[int]]) -> bool:
        xdims = defaultdict(list)
        ydims = defaultdict(list)
        freqs = defaultdict(int)
        xmin = ymin = math.inf
        xmax = ymax = -math.inf
        for x1, y1, x2, y2 in rectangles:
            xdims[(x1, x2)].append((y1, y2))
            ydims[(y1, y2)].append((x1, x2))
            freqs[(x1, y1)] += 1
            freqs[(x1, y2)] += 1
            freqs[(x2, y2)] += 1
            freqs[(x2, y1)] += 1
            xmin, xmax = min(xmin, x1, x2), max(xmax, x1, x2)
            ymin, ymax = min(ymin, y1, y2), max(ymax, y1, y2)

        corners = set([k for k, v in freqs.items() if v == 1])
        if len(corners) != 4 or self.overlapdims(xdims) or self.overlapdims(ydims):
            return False
        bl = (xmin, ymin)
        br = (xmax, ymin)
        tl = (xmin, ymax)
        tr = (xmax, ymax)
        shouldbecorners = [bl, br, tl, tr]
        return all(corner in shouldbecorners for corner in corners)
```

## Notes
- The question is a little ambiguous about what it means by 'exact cover', but the test cases suggest 'exact cover' means exact cover of a single layer of rectangles in `rectangles` (not allowed to have two rectangles on top of each other). We can think of our rectangles as snapping together at the corners, and we want the final component to be rectangle shaped with no overlaps if we hold it by a corner. This only happens if all but 4 of the corners of the input rectangles snap together 2 or 4 times. Simply checking for this condition will handle most inputs except for certain ones where there is overlap despite meeting the main condition. Since the only time overlap will occur despite meeting the main condition is for overlapping rectangles with the same x or y dimensions (consider three squares that together form a desired rectangle component but we have two rectangles inside the central square that are each half the area of the central square), we can check these sets of rectangles simply as an instance of the more general 1d overlapping intervals problem.