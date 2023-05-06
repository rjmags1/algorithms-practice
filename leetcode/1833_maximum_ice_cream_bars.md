# 1833. Maximum Ice Cream Bars - Medium

It is a sweltering summer day, and a boy wants to buy some ice cream bars.

At the store, there are `n` ice cream bars. You are given an array `costs` of length `n`, where `costs[i]` is the price of the `i`th ice cream bar in coins. The boy initially has `coins` coins to spend, and he wants to buy as many ice cream bars as possible. 

Note: The boy can buy the ice cream bars in any order.

Return the maximum number of ice cream bars the boy can buy with `coins` coins.

You must solve the problem by counting sort.

##### Example 1:

```
Input: costs = [1,3,2,4,1], coins = 7
Output: 4
Explanation: The boy can buy ice cream bars at indices 0,1,2,4 for a total price of 1 + 3 + 2 + 1 = 7.
```

##### Example 2:

```
Input: costs = [10,6,8,7,7,8], coins = 5
Output: 0
Explanation: The boy cannot afford any of the ice cream bars.
```

##### Example 3:

```
Input: costs = [1,6,3,1,2,5], coins = 20
Output: 6
Explanation: The boy can buy all the ice cream bars for a total price of 1 + 6 + 3 + 1 + 2 + 5 = 18.
```

##### Constraints:

- <code>costs.length == n</code>
- <code>1 <= n <= 10<sup>5</sup></code>
- <code>1 <= costs[i] <= 10<sup>5</sup></code>
- <code>1 <= coins <= 10<sup>8</sup></code>

## Solution

```
# Time: O(n + m)
# Space: O(m)
class Solution:
    def maxIceCream(self, costs: List[int], coins: int) -> int:
        barsWithCost = [0] * (max(costs) + 1)
        for barCost in costs:
            barsWithCost[barCost] += 1
        result = 0
        for cost, bars in enumerate(barsWithCost):
            if coins < cost:
                break
            if bars > 0:
                bought = min(bars, coins // cost)
                result += bought
                coins -= bought * cost
        return result
```

## Notes
- Greedy (buy cheapest possible ice creams to maximize total number bought) with counting sort to avoid `O(nlogn)` sort time.