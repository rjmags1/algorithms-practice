# 815. Bus Routes - Hard

You are given an array `routes` representing bus routes where `routes[i]` is a bus route that the `i`th bus repeats forever.

- For example, if `routes[0] = [1, 5, 7]`, this means that the `0`th bus travels in the sequence `1 -> 5 -> 7 -> 1 -> 5 -> 7 -> 1 -> ...` forever.

You will start at the bus stop `source` (You are not on any bus initially), and you want to go to the bus stop `target`. You can travel between bus stops by buses only.

Return the least number of buses you must take to travel from `source` to `target`. Return `-1` if it is not possible.

##### Example 1:

```
Input: routes = [[1,2,7],[3,6,7]], source = 1, target = 6
Output: 2
Explanation: The best strategy is take the first bus to the bus stop 7, then take the second bus to the bus stop 6.
```

##### Example 2:

```
Input: routes = [[7,12],[4,5,15],[6],[15,19],[9,12,13]], source = 15, target = 12
Output: -1
```

##### Constraints:

- <code>1 <= routes.length <= 500</code>
- <code>1 <= routes[i].length <= 10<sup>5</sup></code>
- <code>0 <= routes[i][j] < 10<sup>6</sup></code>
- <code>0 <= source, target < 10<sup>6</sup></code>
- All the values of `routes[i]` are unique.
- <code>sum(routes[i].length) <= 10<sup>5</sup></code>

## Solution

```
from collections import defaultdict, deque

# Time: O(n * m) where n is buses and m is routes
# Space: O(n * m)
class Solution:
    def numBusesToDestination(self, routes: List[List[int]], source: int, target: int) -> int:
        if source == target:
            return 0

        stops = defaultdict(set)
        for bus, route in enumerate(routes):
            for stop in route:
                stops[stop].add(bus)
        buses = defaultdict(set)
        for stop, connected in stops.items():
            for bus in connected:
                buses[bus] |= connected
        
        q = deque([(b, 1) for b in stops[source]])
        seen = set()
        while q:
            in_level = len(q)
            for _ in range(in_level):
                curr_bus, buses_taken = q.popleft()
                if curr_bus in seen:
                    continue

                seen.add(curr_bus)
                if curr_bus in stops[target]:
                    return buses_taken
                for neighbor in buses[curr_bus]:
                    if neighbor not in seen:
                        q.append((neighbor, buses_taken + 1))
                        
        return -1
```

## Notes
- Buses are nodes in a graph and edges between buses are common stops in their routes. The complexity is dominated by determining the buses associated with each stop.