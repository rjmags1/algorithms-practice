# 123. Best Time to Buy and Sell Stock - Hard

You are given an array `prices` where `prices[i]` is the price of a given stock on the `i`th day.

Find the maximum profit you can achieve. You may complete at most two transactions.

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

##### Example 1:

```
Input: prices = [3,3,5,0,0,3,1,4]
Output: 6
Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
```

##### Example 2:

```
Input: prices = [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.
```

##### Example 3:

```
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.
```

##### Constraints:

- <code>1 <= prices.length <= 10<sup>5</sup></code>
- <code>0 <= prices[i] <= 10<sup>5</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        minLeft, maxRight = inf, -inf
        n = len(prices)
        dp1 = [0] * n
        dp2 = [0] * (n + 1)
        for i in range(n):
            l, r = prices[i], prices[n - 1 - i]
            minLeft = min(minLeft, l)
            maxRight = max(maxRight, r)
            dp1[i] = 0 if i == 0 else max(dp1[i - 1], l - minLeft)
            dp2[n - 1 - i] = max(dp2[i + 1], maxRight - r)
            
        result = 0
        for i in range(n):
            result = max(result, dp1[i] + dp2[i + 1])
        return result
```

## Notes
- This is bidirectional dynamic programming. It allows us to determine, at any `i` in `prices`, the max amount we could make if we sell for the first time at that `i` and then buy and sell a second time at `i` or at some later index.
- This is necessary because we cannot simply track peaks and valleys for a problem like this; it is possible to have an answer where there are multiple peaks and valleys in one of the buy-sell periods.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        buy1 = inf
        sell1 = sell2 = afterBuy2 = -inf
        for i, p in enumerate(prices):
            buy1 = min(buy1, p)
            sell1 = max(sell1, p - buy1)
            afterBuy2 = max(buy2, sell1 - p)
            sell2 = max(sell2, p + afterBuy2)
        return sell2
```

## Notes
- This solution is not very intuitive unless you have a lot of familiarity with state machines. The idea is at every index, we can choose to buy for the first time, sell for the first time, buy for a second time, and/or sell for a second time. How costly buying a second time will be depends on the amount of profit we generated from the first buy-sell cycle. `buy2` represents the amount of money we have left after we buy a second time.