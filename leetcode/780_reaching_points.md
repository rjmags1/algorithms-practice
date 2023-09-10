# 780. Reaching Points - Hard

Given four integers `sx`, `sy`, `tx`, and `ty`, return `true` if it is possible to convert the point `(sx, sy)` to the point `(tx, ty)` through some operations, or `false` otherwise.

The allowed operation on some point `(x, y)` is to convert it to either `(x, x + y)` or `(x + y, y)`.

##### Example 1:

```
Input: sx = 1, sy = 1, tx = 3, ty = 5
Output: true
Explanation:
One series of moves that transforms the starting point to the target is:
(1, 1) -> (1, 2)
(1, 2) -> (3, 2)
(3, 2) -> (3, 5)
```

##### Example 2:

```
Input: sx = 1, sy = 1, tx = 2, ty = 2
Output: false
```

##### Example 3:

```
Input: sx = 1, sy = 1, tx = 1, ty = 1
Output: true
```

##### Constraints:

- <code>1 <= sx, sy, tx, ty <= 10<sup>9</sup></code>

## Solution

```
# Time: O(log(max(tx, ty)))
# Space: O(1)
class Solution:
    def reachingPoints(self, sx: int, sy: int, tx: int, ty: int) -> bool:
        while tx >= sx and ty >= sy:
            if tx == sx and ty == sy:
                return True
            if tx > ty:
                if ty > sy:
                    tx %= ty
                else:
                    return (tx - sx) % ty == 0
            else:
                if tx > sx:
                    ty %= tx
                else:
                    return (ty - sy) % tx == 0
        return False
```

## Notes
- One thing that naively comes to mind when trying to figure out how to solve this is BFS'ing on all possible generatable points starting from `sx, sy`. This obviously times out, but it leads to the idea of searching backwards from `tx, ty`. This would avoid searching paths that do not lead to `tx, ty` from `sx, sy`, but still times out due to the large input range. We can search backwards because the inputs are only positive numbers, thus we only ever subtract one of `tx` and `ty` from the other. We can optimize the speed of this process by using modular math, avoid excessive repeated subtraction operations. 
- The trickiest part of passing the test cases is handling the case where one of the numbers is equal to its associated `sx` or `sy` and the other greater number is integer divisible by the smaller one. In this situation simply modding will result in an incorrect answer; we need to return whether or not the remaining distance of the larger number from its associated `sx` or `sy` is evenly divisible by the smaller number.