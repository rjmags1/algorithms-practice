# 302. Smallest Rectangle Enclosing Black Pixels - Hard

You are given an `m x n` binary matrix `image` where `0` represents a white pixel and `1` represents a black pixel.

The black pixels are connected (i.e., there is only one black region). Pixels are connected horizontally and vertically.

Given two integers `x` and `y` that represents the location of one of the black pixels, return the area of the smallest (axis-aligned) rectangle that encloses all black pixels.

You must write an algorithm with less than `O(mn)` runtime complexity.

##### Example 1:

```
Input: image = [["0","0","1","0"],["0","1","1","0"],["0","1","0","0"]], x = 0, y = 2
Output: 6
```

##### Example 2:

```
Input: image = [["1"]], x = 0, y = 0
Output: 1
```

##### Constraints:

- `m == image.length`
- `n == image[i].length`
- `1 <= m, n <= 100`
- `image[i][j]` is either `'0'` or `'1'`.
- `0 <= x < m`
- `0 <= y < n`
- `image[x][y] == '1'`.
- The black pixels in the image only form one component.

## Solution

```
# Time: O(mlog(n) + nlog(m))
class Solution:
    def minArea(self, image: List[List[str]], x: int, y: int) -> int:
        m, n = len(image), len(image[0])
        LB, RB = 0, 1
        def colsearch(start, stop, bound):
            """Find leftmost black or rightmost white (if any)
            """
            l, r = start, stop
            while l < r:
                mid = (l + r) // 2
                black = False
                for k in range(m):
                    if image[k][mid] == "1":
                        black = True
                        break
                if bound == LB:
                    if black:
                        r = mid
                    else:
                        l = mid + 1
                else:
                    if not black:
                        r = mid
                    else:
                        l = mid + 1
                        
            return l if bound == LB else l - 1
        
        TB, BB = 0, 1
        def rowsearch(start, stop, bound):
            """Find topmost black or bottommost white (if any)
            """
            t, b = start, stop
            while t < b:
                mid = (t + b) // 2
                black = False
                for k in range(n):
                    if image[mid][k] == "1":
                        black = True
                        break
                if bound == TB:
                    if black:
                        b = mid
                    else:
                        t = mid + 1
                else:
                    if black:
                        t = mid + 1
                    else:
                        b = mid
                        
            return t if bound == TB else t - 1
        
        left = colsearch(0, y, LB)
        right = colsearch(y, n, RB)
        top = rowsearch(0, x, TB)
        bottom = rowsearch(x, m, BB)
        return (right - left + 1) * (bottom - top + 1)
```

## Notes
- Tricky application of binary search, both to see conceptually and to implement. The idea behind the solution is to use binary search to identify the topmost row with a black, the bottommost row without a black, the leftmost col with a black, and the rightmost col without a black. With this information we can determine the dimensions of the rectangle the question asks without potentially visiting all cells. With this approach we don't even need the `x, y` data, though it does help preliminarily reduce the search space.
- Naively we could just search linear through the entire image and find the smallest black `j`, the largest black `j`, the smallest black `i`, and the largest black `i`, or just do bfs from the given `x, y`.