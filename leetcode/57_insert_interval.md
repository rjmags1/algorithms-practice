# 57. Insert Interval - Medium

You are given an array of non-overlapping intervals `intervals` where <code>intervals[i] = [start<sub>i</sub>, end<sub>i</sub>]</code> represent the start and the end of the `ith` interval and `intervals` is sorted in ascending order by <code>start<sub>i</sub></code>. You are also given an interval `newInterval = [start, end]` that represents the start and end of another interval.

Insert `newInterval` into `intervals` such that `intervals` is still sorted in ascending order by <code>start<sub>i</sub></code> and `intervals` still does not have any overlapping intervals (merge overlapping intervals if necessary).

Return `intervals` after the insertion.

##### Example 1:

```
Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
Output: [[1,5],[6,9]]
```

##### Example 2:

```
Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
Output: [[1,2],[3,10],[12,16]]
Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
```

##### Constraints:

- <code>0 <= intervals.length <= 10<sup>4</sup></code>
- `intervals[i].length == 2`
- <code>0 <= start<sub>i</sub> <= end<sub>i</sub> <= 10<sup>5</sup></code>
- `intervals` is sorted by start<sub>i</sub> in ascending order.
- `newInterval.length == 2`
- <code>0 <= start <= end <= 10<sup>5</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        if not intervals:
            return [newInterval]
        
        merged = False
        i, n = 0, len(intervals)
        result = []
        newStart, newEnd = newInterval
        while i < n:
            if merged:
                result.append(intervals[i])
                i += 1
                continue
            
            currStart, currEnd = intervals[i]
            if currEnd < newStart:
                result.append(intervals[i])
                i += 1
                continue
                
            merged = True
            if newEnd < currStart:
                result.append(newInterval)
                result.append(intervals[i])
                i += 1
                continue
            
            mergedInterval = [min(currStart, newStart), max(currEnd, newEnd)]
            result.append(mergedInterval)
            i += 1
            while i < n and intervals[i][0] <= mergedInterval[1]:
                mergedInterval[1] = max(intervals[i][1], mergedInterval[1])
                i += 1
        
        if not merged:
            result.append(newInterval)
        return result
```

## Notes
- This problem is trickier than it appears, especially if attempted after solving 56. Merge Intervals, because there are a lot of edge cases to handle compared to 56. 
- The way the above solution handles the problem is greedy, i.e., it makes the best decision locally on each iteration through `intervals` in order to correctly merge `newInterval`. We need to consider what to do in the following cases: if we have already merged `newInterval`, if we reach the end of `intervals` and we still have not merged, if `newInterval` comes before `intervals[i]`, if `newInterval` comes after `intervals[i]` and we still have not merged, and if there is overlap between `newInterval` and `intervals[i]`. In this last case, it is possible that subsequent `intervals[i]` also overlap with the merged version of original `intervals[i]` and `newInterval`, so we need to look out for that as well.