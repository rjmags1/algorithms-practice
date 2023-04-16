# 2187. Minimum Time to Complete Trips - Medium

You are given an array `time` where `time[i]` denotes the time taken by the `i`th bus to complete one trip.

Each bus can make multiple trips successively; that is, the next trip can start immediately after completing the current trip. Also, each bus operates independently; that is, the trips of one bus do not influence the trips of any other bus.

You are also given an integer `totalTrips`, which denotes the number of trips all buses should make in total. Return the minimum time required for all buses to complete at least `totalTrips` trips.

##### Example 1:

```
Input: time = [1,2,3], totalTrips = 5
Output: 3
Explanation:
- At time t = 1, the number of trips completed by each bus are [1,0,0]. 
  The total number of trips completed is 1 + 0 + 0 = 1.
- At time t = 2, the number of trips completed by each bus are [2,1,0]. 
  The total number of trips completed is 2 + 1 + 0 = 3.
- At time t = 3, the number of trips completed by each bus are [3,1,1]. 
  The total number of trips completed is 3 + 1 + 1 = 5.
So the minimum time needed for all buses to complete at least 5 trips is 3.
```

##### Example 2:

```
Input: time = [2], totalTrips = 1
Output: 2
Explanation:
There is only one bus, and it will complete its first trip at t = 2.
So the minimum time needed to complete 1 trip is 2.
```

##### Constraints:

- <code>1 <= time.length <= 10<sup>5</sup></code>
- <code>1 <= time[i], totalTrips <= 10<sup>7</sup></code>

## Solution

```
# Time: O(n * log(t * k))
# Space: O(1)
class Solution:
    def minimumTime(self, time: List[int], totalTrips: int) -> int:
        l, r = 1, max(time) * totalTrips
        while l < r:
            currtime = (l + r) // 2
            if totalTrips <= sum(currtime // t for t in time):
                r = currtime
            else:
                l = currtime + 1
        return l
```

## Notes
- One may initially consider a greedy/heap approach for this problem, but this fails because only the smallest `totalTrips` buses would be used even though faster solutions usually exist using longer trip time buses. We use binary search on the range of possible times to find the smallest possible time to do all trips with the given bus trip times. 