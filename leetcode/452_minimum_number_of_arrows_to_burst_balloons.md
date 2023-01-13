# 452. Minimum Number of Arrows to Burst Balloons

There are some spherical balloons taped onto a flat wall that represents the XY-plane. The balloons are represented as a 2D integer array `points` where `points[i] = [xstart, xend]` denotes a balloon whose horizontal diameter stretches between `xstart` and `xend`. You do not know the exact y-coordinates of the balloons.

Arrows can be shot up directly vertically (in the positive y-direction) from different points along the x-axis. A balloon with `xstart` and `xend` is burst by an arrow shot at `x` if `xstart <= x <= xend`. There is no limit to the number of arrows that can be shot. A shot arrow keeps traveling up infinitely, bursting any balloons in its path.

Given the array `points`, return the minimum number of arrows that must be shot to burst all balloons.

##### Example 1:

```
Input: points = [[10,16],[2,8],[1,6],[7,12]]
Output: 2
Explanation: The balloons can be burst by 2 arrows:
- Shoot an arrow at x = 6, bursting the balloons [2,8] and [1,6].
- Shoot an arrow at x = 11, bursting the balloons [10,16] and [7,12].
```

##### Example 2:

```
Input: points = [[1,2],[3,4],[5,6],[7,8]]
Output: 4
Explanation: One arrow needs to be shot for each balloon for a total of 4 arrows.
```

##### Example 3:

```
Input: points = [[1,2],[2,3],[3,4],[4,5]]
Output: 2
Explanation: The balloons can be burst by 2 arrows:
- Shoot an arrow at x = 2, bursting the balloons [1,2] and [2,3].
- Shoot an arrow at x = 4, bursting the balloons [3,4] and [4,5].
```

##### Constraints:

- <code>1 <= points.length <= 10<sup>5</sup></code>
- <code>points[i].length == 2</code>
- <code>-2<sup>31</sup> <= xstart < xend <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(nlogn)
# Space: O(n)
class Solution:
    def findMinArrowShots(self, points: List[List[int]]) -> int:
        points.sort(key=lambda p: p[0])
        result = 1
        preve = points[0][1]
        for i in range(1, len(points)):
            s, e = points[i]
            if s <= preve:
                preve = min(preve, e)
            else:
                result += 1
                preve = e
        return result
```

## Notes
- Greedy. It is tricky to prove why this approach works formally, but if you work through enough examples it becomes clear that it is impossible to produce an example where you don't use the minimum number of arrows if you pop as many balloons as possible with the current arrow. To translate this idea to code we need to sort the balloons by their start points and then see how many overlaps we have left to right, where an overlap is defined as all of the ends of the balloons in an overlap are greater than or equal to all of the starts of the balloons in the overlap. The number of distinct overlaps is the minimal number of arrows.
- The space complexity comes from the algorithm that python uses in its standard library `sort` function, Timsort.