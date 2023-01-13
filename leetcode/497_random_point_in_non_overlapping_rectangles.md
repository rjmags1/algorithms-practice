# 497. Random Point in Non-overlapping Rectangles - Medium

You are given an array of non-overlapping axis-aligned rectangles `rects` where `rects[i] = [ai, bi, xi, yi]` indicates that `(ai, bi)` is the bottom-left corner point of the `ith` rectangle and `(xi, yi)` is the top-right corner point of the `ith` rectangle. Design an algorithm to pick a random integer point inside the space covered by one of the given rectangles. A point on the perimeter of a rectangle is included in the space covered by the rectangle.

Any integer point inside the space covered by one of the given rectangles should be equally likely to be returned.

Note that an integer point is a point that has integer coordinates.

Implement the `Solution` class:

- `Solution(int[][] rects)` Initializes the object with the given rectangles `rects`.
- `int[] pick()` Returns a random integer point `[u, v]` inside the space covered by one of the given rectangles.


##### Example 1:

```
Input
["Solution", "pick", "pick", "pick", "pick", "pick"]
[[[[-2, -2, 1, 1], [2, 2, 4, 6]]], [], [], [], [], []]
Output
[null, [1, -2], [1, -1], [-1, -2], [-2, -2], [0, 0]]

Explanation
Solution solution = new Solution([[-2, -2, 1, 1], [2, 2, 4, 6]]);
solution.pick(); // return [1, -2]
solution.pick(); // return [1, -1]
solution.pick(); // return [-1, -2]
solution.pick(); // return [-2, -2]
solution.pick(); // return [0, 0]
```

##### Constraints:

- `1 <= rects.length <= 100`
- `rects[i].length == 4`
- `xi - ai <= 2000`
- `yi - bi <= 2000`
- <code>-10<sup>9</sup> <= ai < xi <= 10<sup>9</sup></code>
- <code>-10<sup>9</sup> <= bi < yi <= 10<sup>9</sup></code>
- All the rectangles do not overlap.
- At most <code>10<sup>4</sup></code> calls will be made to pick.

## Solution

```
from bisect import bisect_left
from random import randrange

# Time: O(n) init, O(log(n)) pick
# Space: O(n) overall
class Solution:
    def __init__(self, rects: List[List[int]]):
        self.s, self.rects = [], rects
        for x1, y1, x2, y2 in rects:
            surface = (x2 - x1 + 1) * (y2 - y1 + 1)
            prev = self.s[-1] if self.s else 0
            self.s.append(surface + prev)

    def pick(self) -> List[int]:
        x1, y1, x2, y2 = self.rects[bisect_left(self.s, randrange(1, self.s[-1] + 1))]
        return [randrange(x1, x2 + 1), randrange(y1, y2 + 1)]
```

## Notes
- This problem considers zero length and/or zero width rectangles to have surface from which we can choose a random point, which tripped me up the first time I did it. The main takeaway for this problem should be paradigm of probability weighted selection based on area of which rectangle from which we pick an `(x, y)` point.