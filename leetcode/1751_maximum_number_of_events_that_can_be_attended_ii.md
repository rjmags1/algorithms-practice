# 1751. Maximum Number of Events That Can Be Attended II - Hard

You are given an array of events where `events[i] = [startDayi, endDayi, valuei]`. The `i`th event starts at `startDayi` and ends at `endDayi`, and if you attend this event, you will receive a value of `valuei`. You are also given an integer `k` which represents the maximum number of events you can attend.

You can only attend one event at a time. If you choose to attend an event, you must attend the entire event. Note that the end day is inclusive: that is, you cannot attend two events where one of them starts and the other ends on the same day.

Return the maximum sum of values that you can receive by attending events.

##### Example 1:

```
Input: events = [[1,2,4],[3,4,3],[2,3,1]], k = 2
Output: 7
Explanation: Choose the green events, 0 and 1 (0-indexed) for a total value of 4 + 3 = 7.
```

##### Example 2:

```
Input: events = [[1,2,4],[3,4,3],[2,3,10]], k = 2
Output: 10
Explanation: Choose event 2 for a total value of 10.
Notice that you cannot attend any other event as they overlap, and that you do not have to attend k events.
```

##### Example 3:

```
Input: events = [[1,1,1],[2,2,2],[3,3,3],[4,4,4]], k = 3
Output: 9
Explanation: Although the events do not overlap, you can only attend 3 events. Pick the highest valued three.
```

##### Constraints:

- <code>1 <= k <= events.length</code>
- <code>1 <= k * events.length <= 10<sup>6</sup></code>
- <code>1 <= startDayi <= endDayi <= 10<sup>9</sup></code>
- <code>1 <= valuei <= 10<sup>6</sup></code>

## Solution

```
from bisect import bisect_right

# Time: O(n * k * log(n))
# Space: O(n)
class Solution:
    def maxValue(self, events: List[List[int]], k: int) -> int:
        n = len(events)
        events.sort()
        dp = [[-1 for _ in range(n)] for _ in range(k + 1)]
        starts = [e[0] for e in events]
        def maxval(i, attends_left):
            if i == n or attends_left == 0:
                return 0
            if dp[attends_left][i] != -1:
                return dp[attends_left][i]
            
            curr_start, curr_end, val = events[i]
            next_possible_start_idx = bisect.bisect_right(starts, curr_end)
            skip = maxval(i + 1, attends_left)
            attend = val + maxval(next_possible_start_idx, attends_left - 1)
            dp[attends_left][i] = max(skip, attend)
            return dp[attends_left][i]
        
        return maxval(0, k)
```

## Notes
- If we sort by start time we can use dynamic programming for this problem and consider that max value that can be obtained for a particular prefix subarray with a given number of event attendances left. To make such a determination, at any particular index in the subarray we can choose to attend or skip the event associated with it. If we skip we simply ask, what is the max value that can be obtained with the same number of attends left for the next largest subproblem? If we choose to attend, we need to know answer to the subproblem `maxval(x, y)` where `x` is the sorted `events` index with the lowest event start time after the current end time, and `y` is the decremented number of attends left.