# 2534. Time Taken to Cross the Door - Hard

There are `n` persons numbered from `0` to `n - 1` and a door. Each person can enter or exit through the door once, taking one second.

You are given a non-decreasing integer array `arrival` of size `n`, where `arrival[i]` is the arrival time of the `i`th person at the door. You are also given an array `state` of size `n`, where `state[i]` is `0` if person `i` wants to enter through the door or `1` if they want to exit through the door.

If two or more persons want to use the door at the same time, they follow the following rules:

- If the door was not used in the previous second, then the person who wants to exit goes first.
- If the door was used in the previous second for entering, the person who wants to enter goes first.
- If the door was used in the previous second for exiting, the person who wants to exit goes first.
- If multiple persons want to go in the same direction, the person with the smallest index goes first.

Return an array `answer` of size `n` where `answer[i]` is the second at which the `i`th person crosses the door.

Note that:

- Only one person can cross the door at each second.
- A person may arrive at the door and wait without entering or exiting to follow the mentioned rules.


##### Example 1:

```
Input: arrival = [0,1,1,2,4], state = [0,1,0,0,1]
Output: [0,3,1,2,4]
Explanation: At each second we have the following:
- At t = 0: Person 0 is the only one who wants to enter, so they just enter through the door.
- At t = 1: Person 1 wants to exit, and person 2 wants to enter. Since the door was used the previous second for entering, person 2 enters.
- At t = 2: Person 1 still wants to exit, and person 3 wants to enter. Since the door was used the previous second for entering, person 3 enters.
- At t = 3: Person 1 is the only one who wants to exit, so they just exit through the door.
- At t = 4: Person 4 is the only one who wants to exit, so they just exit through the door.
```

##### Example 2:

```
Input: arrival = [0,0,0], state = [1,0,1]
Output: [0,2,1]
Explanation: At each second we have the following:
- At t = 0: Person 1 wants to enter while persons 0 and 2 want to exit. Since the door was not used in the previous second, the persons who want to exit get to go first. Since person 0 has a smaller index, they exit first.
- At t = 1: Person 1 wants to enter, and person 2 wants to exit. Since the door was used in the previous second for exiting, person 2 exits.
- At t = 2: Person 1 is the only one who wants to enter, so they just enter through the door.
```

##### Constraints:

- <code>n == arrival.length == state.length</code>
- <code>1 <= n <= 10<sup>5</sup></code>
- <code>0 <= arrival[i] <= n</code>
- `arrival` is sorted in non-decreasing order.
- `state[i]` is either `0` or `1`.

## Solution

```
import heapq

# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def timeTaken(self, arrival: List[int], state: List[int]) -> List[int]:
        n = len(arrival)
        people = list(zip(arrival, state, range(n)))
        people.sort()
        enter_h = []
        exit_h = []
        result = [-1] * n
        t = k = passed = 0
        prev = None
        while passed < n:
            while k < n and people[k][0] == t:
                arr, st, i = people[k]
                heapq.heappush(enter_h if st == 0 else exit_h, i)
                k += 1
            enter_waiting = len(enter_h)
            exit_waiting = len(exit_h)
            waiting = exit_waiting + enter_waiting
            if waiting == 0:
                prev = None
                t += 1
            elif waiting == 1:
                i = heapq.heappop(enter_h if enter_waiting else exit_h)
                result[i] = t
                passed += 1
                t += 1
                prev = 0 if enter_waiting else 1
            elif prev is None:
                i = heapq.heappop(exit_h if exit_waiting else enter_h)
                result[i] = t
                passed += 1
                t += 1
                prev = 1 if exit_waiting else 0
            else:
                i = None
                if prev == 0:
                    prev = 0 if enter_waiting else 1
                    i = heapq.heappop(enter_h if enter_waiting else exit_h)
                else:
                    prev = 1 if exit_waiting else 0
                    i = heapq.heappop(exit_h if exit_waiting else enter_h)
                result[i] = t
                t += 1
                passed += 1
        
        return result
```

## Notes
- Fairly straightforward for a hard problem, just a little tricky to implement and correctly handle all edge cases. The idea is to simply simulate the arrival and passage of people through the door. We want to keep track of, at any given second, how many people have arrived at the door, and the `state` of those people. Then, based on the `state` of the previous person that went through the door at the previous second (if any), we follow the rules in the prompt to determine which person at the door can pass through. Note the usage of two min heaps to keep track of people waiting to enter and exit, ordered by the index of the person in the original inputs. Also note we could save some space and time by avoiding the sort step because the `arrival` is already sorted in non-decreasing order, which I didn't notice at first.