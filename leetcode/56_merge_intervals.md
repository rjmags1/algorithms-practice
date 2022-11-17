# 56. Merge Intervals - Medium

Given an array of `intervals` where <code>intervals[i] = [start<sub>i</sub>, end<sub>i</sub>]</code>, merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

##### Example 1:

```
Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
```

##### Example 2:

```
Input: intervals = [[1,4],[4,5]]
Output: [[1,5]]
Explanation: Intervals [1,4] and [4,5] are considered overlapping.
```

##### Constraints:

- <code>1 <= intervals.length <= 10<sup>4</sup></code>
- `intervals[i].length == 2`
- <code>0 <= start<sub>i</sub> <= end<sub>i</sub> <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n) if we count result, O(1) otherwise
class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        intervals.sort(key=lambda interval: interval[0])
        result = [intervals[0]]
        i, n = 1, len(intervals)
        while i < n:
            intoStart, intoEnd = result[-1]
            currStart, currEnd = intervals[i]
            if intoEnd >= currStart:
                result[-1][1] = max(intoEnd, currEnd)
            else:
                result.append(intervals[i])
            i += 1
        
        return result
```

## Notes
- The key here is to sort the input by the <code>start<sub>i</sub></code>. This greatly simplifies the merging process, since thereafter all we need to check for in order to merge is if the previous interval ends after or at the start of the current one, since sorting guarantees the previous interval started before or at the same time as the current interval.