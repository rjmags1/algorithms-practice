# 435. Non-overlapping Intervals - Medium

Given an array of intervals `intervals` where `intervals[i] = [starti, endi]`, return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

##### Example 1:

```
Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
Output: 1
Explanation: [1,3] can be removed and the rest of the intervals are non-overlapping.
```

##### Example 2:

```
Input: intervals = [[1,2],[1,2],[1,2]]
Output: 2
Explanation: You need to remove two [1,2] to make the rest of the intervals non-overlapping.
```

##### Example 3:

```
Input: intervals = [[1,2],[2,3]]
Output: 0
Explanation: You don't need to remove any of the intervals since they're already non-overlapping.
```

##### Constraints:

- <code>intervals[i].length == 2</code>
- <code>-5 * 10<sup>4</sup> <= starti < endi <= 5 * 10<sup>4</sup></code>
- <code>1 <= intervals.length <= 10<sup>5</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(1)
class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        result = 0
        intervals.sort()
        prevend = -math.inf
        for start, end in intervals:
            if prevend > start:
                prevend = min(end, prevend)
                result += 1
            else:
                prevend = end
        return result
```

## Notes
- Greedy. Sort by interval starts and tie break on interval ends. This allows us to consider non-overlapping intervals with the smallest ends as belonging to the result, thus guaranteeing the minimum number of removals. In other words, when we iterate through the sorted input, if we find an overlap with the last merged interval and the current interval, we would want to keep the one of these two with the smallest ending, which is what the code in the `if` statement represents.