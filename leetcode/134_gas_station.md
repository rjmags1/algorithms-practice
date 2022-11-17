# 134. Gas Station - Medium

There are `n` gas stations along a circular route, where the amount of gas at the `i`th station is `gas[i]`.

You have a car with an unlimited gas tank and it costs `cost[i]` of gas to travel from the `i`th station to its next `(i + 1)`th station. You begin the journey with an empty tank at one of the gas stations.

Given two integer arrays `gas` and `cost`, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return `-1`. If there exists a solution, it is guaranteed to be unique.

##### Example 1:

```
Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
Output: 3
Explanation:
Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
Travel to station 4. Your tank = 4 - 1 + 5 = 8
Travel to station 0. Your tank = 8 - 2 + 1 = 7
Travel to station 1. Your tank = 7 - 3 + 2 = 6
Travel to station 2. Your tank = 6 - 4 + 3 = 5
Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
Therefore, return 3 as the starting index.
```

##### Example 2:

```
Input: gas = [2,3,4], cost = [3,4,3]
Output: -1
Explanation:
You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
Travel to station 0. Your tank = 4 - 3 + 2 = 3
Travel to station 1. Your tank = 3 - 3 + 3 = 3
You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
Therefore, you can't travel around the circuit once no matter where you start.
```

##### Constraints:

- `n == gas.length == cost.length`
- <code>1 <= n <= 10<sup>5</sup></code>
- <code>0 <= gas[i], cost[i] <= 10<sup>4</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        had = gas[0]
        minArr, minArrIdx = inf, None
        n, i = len(gas), 0
        for step in range(n):
            have = had - cost[i]
            i = i + 1 if i < n - 1 else 0
            if have < minArr:
                minArr, minArrIdx = have, i
            had = have + gas[i]
        
        i = minArrIdx
        had = gas[minArrIdx]
        for step in range(n):
            have = had - cost[i]
            if have < 0:
                return -1
            i = i + 1 if i < n - 1 else 0
            had = have + gas[i]
        return minArrIdx
```

## Notes
- The logic behind this approach is making a round trip from an arbitrary starting station and observing the state of the gas tank as we go. When we do this, we want to keep an eye out for the lowest point the gas tank ever gets to after a station to station transition but before filling up again. After all this is the state we care about for answering this question - does it cost more gas than we currently have to get to the next station? 
- If it is possible to make a round trip, this is the index we would want to start from. Why? It is not immediately intuitive, but as long as the total gas is greater than or equal to the total cost, we will be able to make a round trip if we start at the point where the gas tank reaches its lowest, relatively speaking. 
- Graph out the arrival state of the gas tank for each index, but for different starting stations, and see for yourself. The relative state of the gas tank on arrival doesn't change compared to other stations, regardless of starting station. So if we start at the station with the lowest relative gas on arrival, this gives us the best chance of being able to make a round trip.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        had = gas[0]
        minArr, minArrIdx = inf, None
        n, i = len(gas), 0
        tc = tg = 0
        for step in range(n):
            tc += cost[i]
            tg += gas[i]
            
            have = had - cost[i]
            i = i + 1 if i < n - 1 else 0
            if have < minArr:
                minArr, minArrIdx = have, i
            had = have + gas[i]
        
        return -1 if tc > tg else minArrIdx
```

## Notes
- This approach avoids the second pass by tracking the total cost and total amount of gas in the first pass. It is based on the same logic described above. If there is enough gas to actually make a round trip, starting at the station where the gas tank reaches its lowest relative point guarantees that we will be able to make a round trip.