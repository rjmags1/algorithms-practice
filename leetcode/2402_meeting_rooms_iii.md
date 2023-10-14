# 2402. Meeting Rooms III - Hard

You are given an integer `n`. There are `n` rooms numbered from `0` to `n - 1`.

You are given a 2D integer array `meetings` where `meetings[i] = [starti, endi]` means that a meeting will be held during the half-closed time interval `[starti, endi)`. All the values of `starti` are unique.

Meetings are allocated to rooms in the following manner:

- Each meeting will take place in the unused room with the lowest number.
- If there are no available rooms, the meeting will be delayed until a room becomes free. The delayed meeting should have the same duration as the original meeting.
- When a room becomes unused, meetings that have an earlier original start time should be given the room.

Return the number of the room that held the most meetings. If there are multiple rooms, return the room with the lowest number.

A half-closed interval `[a, b)` is the interval between `a` and `b` including `a` and not including `b`.

##### Example 1:

```
Input: n = 2, meetings = [[0,10],[1,5],[2,7],[3,4]]
Output: 0
Explanation:
- At time 0, both rooms are not being used. The first meeting starts in room 0.
- At time 1, only room 1 is not being used. The second meeting starts in room 1.
- At time 2, both rooms are being used. The third meeting is delayed.
- At time 3, both rooms are being used. The fourth meeting is delayed.
- At time 5, the meeting in room 1 finishes. The third meeting starts in room 1 for the time period [5,10).
- At time 10, the meetings in both rooms finish. The fourth meeting starts in room 0 for the time period [10,11).
Both rooms 0 and 1 held 2 meetings, so we return 0. 
```

##### Example 2:

```
Input: n = 3, meetings = [[1,20],[2,10],[3,5],[4,9],[6,8]]
Output: 1
Explanation:
- At time 1, all three rooms are not being used. The first meeting starts in room 0.
- At time 2, rooms 1 and 2 are not being used. The second meeting starts in room 1.
- At time 3, only room 2 is not being used. The third meeting starts in room 2.
- At time 4, all three rooms are being used. The fourth meeting is delayed.
- At time 5, the meeting in room 2 finishes. The fourth meeting starts in room 2 for the time period [5,10).
- At time 6, all three rooms are being used. The fifth meeting is delayed.
- At time 10, the meetings in rooms 1 and 2 finish. The fifth meeting starts in room 1 for the time period [10,12).
Room 0 held 1 meeting while rooms 1 and 2 each held 2 meetings, so we return 1. 
```

##### Constraints:

- <code>1 <= n <= 100</code>
- <code>1 <= meetings.length <= 10<sup>5</sup></code>
- <code>0 <= starti < endi <= 5 * 10<sup>5</sup></code>
- <code>meetings[i].length == 2</code>
- All the values of starti are unique.

## Solution

```
import heapq

# Time: O(mlog(n))
# Space: O(n)
class Solution:
    def mostBooked(self, n: int, meetings: List[List[int]]) -> int:
        free = [r for r in range(n)]
        in_use = []
        result = [0] * n
        for s, e in sorted(meetings):
            while in_use and in_use[0][0] <= s:
                t, r = heapq.heappop(in_use)
                heapq.heappush(free, r)
            if free:
                r = heapq.heappop(free)
                heapq.heappush(in_use, [e, r])
            else:
                t,r = heapq.heappop(in_use)
                heapq.heappush(in_use, [t + e - s, r])
            result[r] += 1
            
        return result.index(max(result))
```

## Notes
- Meeting room problems typically involve priority queues and this one is no exception. We need to keep track of rooms that are currently being used and those that are free such that we always know the lowest indexed free room and the in use room that is free the soonest. For a given meeting, if there is an unused room at its start time, we assign that meeting to the lowest index unused room. Otherwise we assign that meeting to the currently in use room that is available soonest.
- Trickier than it seems because doing a time scan can TLE on large inputs. It seems like this shouldn't happen based on the input constraints but it does unless my prior implemention is faulty. Anyway, a time scan solution is not optimal anyway. If we realize that delayed meetings always get assigned to the currently used room at the top of the in-use heap at the time of the delayed meeting original start, then we can iterate over meetings instead of time.