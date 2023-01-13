# 309. Best Time to Buy and Sell Stock With Cooldown - Medium

You are given an array `prices` where `prices[i]` is the price of a given stock on the `ith` day.

Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:

- After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

##### Example 1:

```
Input: prices = [1,2,3,0,2]
Output: 3
Explanation: transactions = [buy, sell, cooldown, buy, sell]
```

##### Example 2:

```
Input: prices = [1]
Output: 0
```

##### Constraints:

- `1 <= prices.length <= 5000`
- `0 <= prices[i] <= 1000`

## Solution 1

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        n = len(prices)
        dp = [0] * n 
        for i in range(1, n):
            for j in range(i):
                dp[i] = max(dp[i], dp[j])
                if prices[i] > prices[j]:
                    prev = dp[j - 2] if j > 1 else 0
                    dp[i] = max(dp[i], prices[i] - prices[j] + prev)
                    
        return dp[-1]
```

## Notes
- Fairly basic recurrence relation, and given `5e3` input length constraint upper bound we can get away with quadratic time complexity.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        hold_eod = -prices[0]
        sold_eod = rest_eod = 0
        for i in range(1, len(prices)):
            prevhold, prevsold, prevrest = hold_eod, sold_eod, rest_eod
            hold_eod = max(hold_eod, prevrest - prices[i])
            sold_eod = prevhold + prices[i]
            rest_eod = max(prevrest, prevsold)
        return max(sold_eod, rest_eod)
```

## Notes
- This problem and other stock problems like it can be modelled as a state machine, where we can be in any given state at a particular point in time AKA at a particular point in processing the input, and the states have deterministic relationships between each other. In this case our states are: we can hold stock at the end of the `ith` day, we can have just sold stock at the end of the `ith` day, or we could have rested the entire `ith` day. Each state is associated with an amount of money. 
- We can get to *hold* state from a *hold* state (i.e., we didn't buy today because we were already holding a stock bought at a cheaper price a prior day), or we could have bought that day, in which case we must have *rested* a day (or days) before. 
- We can get to the *sold* at the end of the day state from *hold* state only if we profited by the sum of the price of the stock that day and the balance we had prior to selling.
- We can get to the *rest* at the end of the day state only if we *rested* the day before, or if we *sold* the day before; we can't hold and rest at the same time.
- For each of these states at any given point in time, we want to maximize their value so they can be used to yield larger maxes in the future.