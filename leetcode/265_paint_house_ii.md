# 265. Paint House II - Hard

There are a row of `n` houses, each house can be painted with one of the `k` colors. The cost of painting each house with a certain color is different. You have to paint all the houses such that no two adjacent houses have the same color.

The cost of painting each house with a certain color is represented by an `n x k` cost matrix costs.

- For example, `costs[0][0]` is the cost of painting house `0` with color `0`; `costs[1][2]` is the cost of painting house `1` with color `2`, and so on...

Return the minimum cost to paint all houses.

##### Example 1:

```
Input: costs = [[1,5,3],[2,9,4]]
Output: 5
Explanation:
Paint house 0 into color 0, paint house 1 into color 2. Minimum cost: 1 + 4 = 5; 
Or paint house 0 into color 2, paint house 1 into color 0. Minimum cost: 3 + 2 = 5.
```

##### Example 2:

```
Input: costs = [[1,3],[2,4]]
Output: 5
```

##### Constraints:

- `costs.length == n`
- `costs[i].length == k`
- `1 <= n <= 100`
- `2 <= k <= 20`
- `1 <= costs[i][j] <= 20`

Follow-up: Could you solve it in `O(nk)` runtime?

## Solution

```
# Time: O(nk)
# Space: O(k)
class Solution:
    def minCostII(self, costs: List[List[int]]) -> int:
        def cheapest2ways(prev):
            min1, min2 = [inf, None], [inf, None]
            for i, cost in enumerate(prev):
                if cost < min1[0]:
                    min1[0], min1[1] = cost, i
            for i, cost in enumerate(prev):
                if cost < min2[0] and i != min1[1]:
                    min2[0], min2[1] = cost, i
            return min1, min2
        
        dp = costs[0][:]
        n, k = len(costs), len(costs[0])
        for house in range(1, n):
            min1, min2 = cheapest2ways(dp)
            cost1, color1 = min1
            cost2, color2 = min2
            for color in range(k):
                dp[color] = costs[house][color]
                dp[color] += cost1 if color != color1 else cost2
                
        return min(dp)
```

## Notes
- For each house, we need to know the cheapest way to paint that house a particular color. The cheapest way to paint a particular house a particular color is the cheapest way to not paint a particular house the same color as the one before it, plus the cost to paint a particular house a particular color. We only need to know the cheapest way/color and the second cheapest way/color to paint the house before a particular house to know the cheapest way to paint the current house a particular color. We need to know the second cheapest way/color because we will need to figure out the cheapest way to paint the current house the color that was the cheapest color for the previous house, and houses are not allowed to be painted the same color as those houses adjacent to it.