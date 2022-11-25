# 256. Paint House - Medium

There is a row of `n` houses, where each house can be painted one of three colors: red, blue, or green. The cost of painting each house with a certain color is different. You have to paint all the houses such that no two adjacent houses have the same color.

The cost of painting each house with a certain color is represented by an `n x 3` cost matrix `costs`.

- For example, `costs[0][0]` is the cost of painting house `0` with the color red; `costs[1][2]` is the cost of painting house 1 with color green, and so on...

Return the minimum cost to paint all houses.

##### Example 1:

```
Input: costs = [[17,2,17],[16,16,5],[14,3,19]]
Output: 10
Explanation: Paint house 0 into blue, paint house 1 into green, paint house 2 into blue.
Minimum cost: 2 + 5 + 3 = 10.
```

##### Example 2:

```
Input: costs = [[7,6,2]]
Output: 2
```

##### Constraints:

- `costs.length == n`
- `costs[i].length == 3`
- `1 <= n <= 100`
- `1 <= costs[i][j] <= 20`

## Solution

```
# Time: O(nk) where k is num colors and n is num houses
# Space: O(k)
class Solution:
    def minCost(self, costs: List[List[int]]) -> int:
        def cheapestprev(dp):
            min1, min2 = [inf, None], [inf, None]
            for i, c in enumerate(dp):
                if c < min1[0]:
                    min1[0], min1[1] = c, i
            for i, c in enumerate(dp):
                if c < min2[0] and i != min1[1]:
                    min2[0], min2[1] = c, i
            return min1, min2
        
        n, m = len(costs), len(costs[0])
        dp = costs[0][:]
        for house in range(1, n):
            min1, min2 = cheapestprev(dp)
            for i, c in enumerate(costs[house]):
                dp[i] = c + min1[0] if i != min1[1] else c + min2[0]
        return min(dp)
```

## Notes
- Recurrence relation for this problem is: <code>cheapestToPaintThisColor<sub>i</sub> = cost[i] + cheapestToNotPaintThisColor<sub>i - 1</sub></code>. For a given house `i`, to know the cheapest way to paint it a particular color, we will only ever need to know the cheapest cost to paint the previous house a particular color, and the next cheapest cost to paint the previous a house a particular color, in order (in the case where we need to determine the cost to paint the current house the color that is equal to the cheapest color of the previous house).