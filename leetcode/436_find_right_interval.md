# 436. Find Right Interval - Medium

You are given an array of `intervals`, where `intervals[i] = [starti, endi]` and each `starti` is unique.

The right interval for an interval `i` is an interval `j` such that `startj >= endi` and `startj` is minimized. Note that `i` may equal `j`.

Return an array of right interval indices for each interval `i`. If no right interval exists for interval `i`, then put `-1` at index `i`.

##### Example 1:

```
Input: intervals = [[1,2]]
Output: [-1]
Explanation: There is only one interval in the collection, so it outputs -1.
```

##### Example 2:

```
Input: intervals = [[3,4],[2,3],[1,2]]
Output: [-1,0,1]
Explanation: There is no right interval for [3,4].
The right interval for [2,3] is [3,4] since start0 = 3 is the smallest start that is >= end1 = 3.
The right interval for [1,2] is [2,3] since start1 = 2 is the smallest start that is >= end2 = 2.
```

##### Example 3:

```
Input: intervals = [[1,4],[2,3],[3,4]]
Output: [-1,2,-1]
Explanation: There is no right interval for [1,4] and [3,4].
The right interval for [2,3] is [3,4] since start2 = 3 is the smallest start that is >= end1 = 3.
```

##### Constraints:

- <code>intervals[i].length == 2</code>
- <code>1 <= intervals.length <= 2 * 10<sup>4</sup></code>
- <code>-10<sup>6</sup> <= starti <= endi <= 10<sup>6</sup></code>
- The start point of each interval is unique.

## Solution

```
from bisect import bisect_left

# Time: O(nlogn)
# Space: O(n)
class Solution:
    def findRightInterval(self, intervals: List[List[int]]) -> List[int]:
        starts = sorted([(start, i) for i, (start, end) in enumerate(intervals)])
        result, n = [], len(starts)
        for _, end in intervals:
            k = bisect_left(starts, end, key=lambda t: t[0])
            result.append(starts[k][1] if k < n else -1)
        return result
```

## Notes
- Sort by start while retaining original index information, so the sorted starts can be binary searched upon.
- Bisect is standard library binary search for python, `bisect_left` finds finds the insertion point of the search target AKA the index of the leftmost value `>=` the search target.