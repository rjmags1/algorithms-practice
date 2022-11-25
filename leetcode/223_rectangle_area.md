# 223. Rectangle Area - Medium

Given the coordinates of two rectilinear rectangles in a 2D plane, return the total area covered by the two rectangles.

The first rectangle is defined by its bottom-left corner `(ax1, ay1)` and its top-right corner `(ax2, ay2)`.

The second rectangle is defined by its bottom-left corner `(bx1, by1)` and its top-right corner `(bx2, by2)`.

##### Example 1:

```
Input: ax1 = -3, ay1 = 0, ax2 = 3, ay2 = 4, bx1 = 0, by1 = -1, bx2 = 9, by2 = 2
Output: 45
```

##### Example 2:

```
Input: ax1 = -2, ay1 = -2, ax2 = 2, ay2 = 2, bx1 = -2, by1 = -2, bx2 = 2, by2 = 2
Output: 16
```

##### Constraints:

- <code>-10<sup>4</sup> <= ax1 <= ax2 <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= ay1 <= ay2 <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= bx1 <= bx2 <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= by1 <= by2 <= 10<sup>4</sup></code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def computeArea(self, ax1: int, ay1: int, ax2: int, ay2: int, bx1: int, by1: int, bx2: int, by2: int) -> int:
        A = (ax2 - ax1) * (ay2 - ay1)
        B = (bx2 - bx1) * (by2 - by1)
        total = A + B
        intersectionW = min(ax2, bx2) - max(ax1, bx1)
        if intersectionW <= 0:
            return total
        intersectionH = min(ay2, by2) - max(ay1, by1)
        if intersectionH <= 0:
            return total
        return total - (intersectionW * intersectionH)
```

## Notes
- Fairly trivial, just need to realize that calculating the intersection area can be simplified as finding the overlap of two ranges, and we do this twice: once for the x-dimension, and again for the y-dimension. Also need to be careful to pay attention to the prompt: it asks for the total area covered by the two rectangles, not just their intersection area.