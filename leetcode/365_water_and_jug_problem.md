# 365. Water and Jug Problem - Medium

You are given two jugs with capacities `jug1Capacity` and `jug2Capacity` liters. There is an infinite amount of water supply available. Determine whether it is possible to measure exactly `targetCapacity` liters using these two jugs.

If `targetCapacity` liters of water are measurable, you must have `targetCapacity` liters of water contained within one or both buckets by the end.

Operations allowed:

- Fill any of the jugs with water.
- Empty any of the jugs.
- Pour water from one jug into another till the other jug is completely full, or the first jug itself is empty.


##### Example 1:

```
Input: jug1Capacity = 3, jug2Capacity = 5, targetCapacity = 4
Output: true
```

##### Example 2:

```
Input: jug1Capacity = 2, jug2Capacity = 6, targetCapacity = 5
Output: false
```

##### Example 3:

```
Input: jug1Capacity = 1, jug2Capacity = 2, targetCapacity = 3
Output: true
```

##### Constraints:

- <code>1 <= jug1Capacity, jug2Capacity, targetCapacity <= 10<sup>6</sup></code>

## Solution 1

```
from collections import deque
from functools import cache

# Time: O(6^(j1 * j2))
# Space: O(j1 * j2)
class Solution:
    def canMeasureWater(self, jug1Capacity: int, jug2Capacity: int, targetCapacity: int) -> bool:
        j1, j2, tc = jug1Capacity, jug2Capacity, targetCapacity
        if j1 + j2 <= tc:
            return j1 + j2 == tc
        
        visited, q = set(), deque([(0, 0)])
        while q:
            curr = q.popleft()
            if visited in curr:
                continue

            visited.add(curr)
            a, b = curr
            if a + b == tc:
                return True
            if (a, 0) not in visited:
                q.append((a, 0))
            if (0, b) not in visited:
                q.append((0, b))
            if (j1, b) not in visited:
                q.append((j1, b))
            if (a, j2) not in visited:
                q.append((a, j2))
            pour1 = min(a, j2 - b)
            if (a - pour1, b + pour1) not in visited:
                q.append((a - pour1, b + pour1))
            pour2 = min(b, j1 - a)
            if (a + pour2, b - pour2) not in visited:
                q.append((a + pour2, b - pour2))
            
        return False
```

## Notes
- Because of the large search space for this problem, bfs is a better first try approach than dfs. There are `6` possible ways to transition from one state to another, and we only want to explore states we haven't seen before as we transition, so use a set as we perform our breadth first search. Note the time complexity is a fairly generous upper bound because of the non-uniformity of transitions between states in the search space of states.

## Solution 2

```
from math import gcd

# Time: O(1)
# Space: O(1)
class Solution:
    def canMeasureWater(self, jug1Capacity: int, jug2Capacity: int, targetCapacity: int) -> bool:
        j1, j2, tc = jug1Capacity, jug2Capacity, targetCapacity
        if j1 + j2 <= tc:
            return j1 + j2 == tc
        
        return not tc % gcd(j1, j2)
```

## Notes
- The idea of greatest common divisor is that for some pair of integers `x` and `y`, and all common divisors `d` such that `d = ax` and `d = by`, the greatest common divisor is the largest of the common divisors. There is an idea called Bezout's lemma that says for some numbers `x` and `y` with greatest common divisor `d`, there exists some other integers `m` and `n` such that `mx + ny = d` and `d` is the smallest positive `mx + ny`.
- It turns out we can (esoterically) apply this equation to this problem, where `m` and `n` represent the number of fills/pours (a fill is an increment and a pour is a decrement, regardless of if we pour onto the floor or into the other cup). If there is some number of pours or dumps for each cup such that the overall gain is equal to a number that divides `targetCapacity`, then we know we can reach `targetCapacity` with `jug1Capacity` and `jug2Capacity`.
- I generally try my best to wrap my head around solutions that I don't come up with myself but this is one of the very few that I can't fully grasp. I do not see how we can simply ignore pouring into the other cup vs. on the floor, which this solution seems to do. Guessing there is some non-intuitive proof for why this works.