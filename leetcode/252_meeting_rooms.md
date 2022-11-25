# 252. Meeting Rooms - Easy

Given an array of meeting time `intervals` where `intervals[i] = [starti, endi]`, determine if a person could attend all meetings.

##### Example 1:

```
Input: intervals = [[0,30],[5,10],[15,20]]
Output: false
```

##### Example 2:

```
Input: intervals = [[7,10],[2,4]]
Output: true
```

##### Constraints:

- <code>0 <= intervals.length <= 10<sup>4</sup></code>
- <code>intervals[i].length == 2</code>
- <code>0 <= starti < endi <= 10<sup>6</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n) here (python Timsort), O(log(n)) for quicksort
class Solution:
    def canAttendMeetings(self, intervals: List[List[int]]) -> bool:
        intervals.sort(key=lambda x:x[0])
        return all([intervals[i][1] <= intervals[i + 1][0] 
                    for i in range(len(intervals) - 1)])
```

## Notes
- Sort by start and check for overlap between consecutive meeting times.