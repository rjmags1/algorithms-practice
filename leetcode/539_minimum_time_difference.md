# 539. Minimum Time Difference - Medium

Given a list of 24-hour clock time points in `"HH:MM"` format, return the minimum minutes difference between any two time-points in the list. 

##### Example 1:

```
Input: timePoints = ["23:59","00:00"]
Output: 1
```

##### Example 2:

```
Input: timePoints = ["00:00","23:59","00:00"]
Output: 0
```

##### Constraints:

- <code>2 <= timePoints.length <= 2 * 10<sup>4</sup></code>
- `timePoints[i]` is in the format `"HH:MM"`.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def findMinDifference(self, timePoints: List[str]) -> int:
        m, n = 24 * 60, len(timePoints)
        if m < n:
            return 0

        taken = [False] * m
        tomins = lambda s: int(s[:2]) * 60 + int(s[3:])
        for t in timePoints:
            mins = tomins(t)
            if taken[mins]:
                return 0
            taken[mins] = True
        times = [timeinmins for timeinmins in range(m) if taken[timeinmins]]
        distance = lambda i, j: min(m - abs(times[i] - times[j]), abs(times[i] - times[j]))
        return min(distance(i, i - 1) for i in range(n))
```

## Notes
- There are `m = 24 * 60 == 1440` possible unique `timePoints`; if `m < n` there must be a duplicate time in the input with distance `0` (pigeonhole principle). For any inputs where there are not duplicate times, since the problem only cares about the distance between times as if we were looking at a weird clock with no hours and `1440` minute tick marks (i.e., minimum distance between two points on a circle), we compute `distance` between two times accordingly.