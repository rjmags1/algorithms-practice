# 630. Course Schedule III - Hard

There are `n` different online courses numbered from `1` to `n`. You are given an array courses where `courses[i] = [durationi, lastDayi]` indicate that the `i`th course should be taken continuously for `durationi` days and must be finished before or on `lastDayi`.

You will start on the 1st day and you cannot take two or more courses simultaneously.

Return the maximum number of courses that you can take.

##### Example 1:

```
Input: courses = [[100,200],[200,1300],[1000,1250],[2000,3200]]
Output: 3
Explanation: 
There are totally 4 courses, but you can take 3 courses at most:
First, take the 1st course, it costs 100 days so you will finish it on the 100th day, and ready to take the next course on the 101st day.
Second, take the 3rd course, it costs 1000 days so you will finish it on the 1100th day, and ready to take the next course on the 1101st day. 
Third, take the 2nd course, it costs 200 days so you will finish it on the 1300th day. 
The 4th course cannot be taken now, since you will finish it on the 3300th day, which exceeds the closed date.
```

##### Example 2:

```
Input: courses = [[1,2]]
Output: 1
```

##### Constraints:

- <code>1 <= courses.length <= 10<sup>4</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def scheduleCourse(self, courses: List[List[int]]) -> int:
        taken = []
        t = 0
        for duration, deadline in sorted(courses, key=lambda c : c[1]):
            heapq.heappush(taken, -duration)
            t += duration
            while len(taken) > 0 and t > deadline:
                t += heapq.heappop(taken)
        
        return len(taken)
```

## Notes
- For a given time, we want to take the `k` courses that must be taken before that time with smallest durations, such that the total duration of these courses is minimized and `k` is maximized. Heap allows us to keep track of largest course we have in a given `k` for easy removal when trying to perform this min-max for a given time.