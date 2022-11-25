# 253. Meeting Rooms II - Medium

Given an array of meeting time intervals `intervals` where `intervals[i] = [starti, endi]`, return the minimum number of conference rooms required.

##### Example 1:

```
Input: intervals = [[0,30],[5,10],[15,20]]
Output: 2
```

##### Example 2:

```
Input: intervals = [[7,10],[2,4]]
Output: 1
```

##### Constraints:

- <code>1 <= intervals.length <= 10<sup>4</sup></code>
- <code>0 <= starti < endi <= 10<sup>6</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n) (Timsort and heap)
class Solution:
    def minMeetingRooms(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x:x[0])
        h, rooms = [intervals[0][1]], 1
        for i in range(1, len(intervals)):
            start, stop = intervals[i]
            if start >= h[0]:
                heapq.heappop(h)
            else:
                rooms += 1
            heapq.heappush(h, stop)
        return rooms
```

## Notes
- Intuitive heap based approach. Sort the intervals by start and use the heap to keep track of the next "in progress" meeting end. If the current meeting starts after the next "in progress" meeting, we will need another room.

## Solution 2

```
# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def minMeetingRooms(self, intervals: List[List[int]]) -> int:
        starts, stops = [], []
        for start, stop in intervals:
            starts.append(start)
            stops.append(stop)
        starts.sort()
        stops.sort()
        
        rooms = j = 0
        for start in starts:
            if start < stops[j]:
                rooms += 1
            else:
                j += 1
        return rooms
```

## Notes
- This solution operates on the same logic as the first; we can decouple start and end times because all meetings end after they start.