# 188. Best Time to Buy and Sell Stock IV - Hard

You are given an integer array `prices` where `prices[i]` is the price of a given stock on the `ith` day, and an integer `k`.

Find the maximum profit you can achieve. You may complete at most `k` transactions.

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

##### Example 1:

```
Input: k = 2, prices = [2,4,1]
Output: 2
Explanation: Buy on day 1 (price = 2) and sell on day 2 (price = 4), profit = 4-2 = 2.
```

##### Example 2:

```
Input: k = 2, prices = [3,2,6,5,0,3]
Output: 7
Explanation: Buy on day 2 (price = 2) and sell on day 3 (price = 6), profit = 6-2 = 4. Then buy on day 5 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
```

##### Constraints:

- `1 <= k <= 100`
- `1 <= prices.length <= 1000`
- `0 <= prices[i] <= 1000`

## Solution

```
# Time: O(nk)
# Space: O(nk)
class Solution:
    def maxProfit(self, k: int, prices: List[int]) -> int:
        n = len(prices)
        if 2 * k > n:
            return sum([prices[i + 1] - prices[i] for i in range(n - 1) if prices[i] < prices[i + 1]])
        
        dp = [[[-inf, -inf] for _ in range(n)] for _ in range(k + 1)]
        for j in range(n):
            dp[0][j][0] = 0
        not_hold_eod = hold_eod = None
        for i in range(1, k + 1):
            for j in range(n):
                if j + 1 < i:
                    not_hold_eod, hold_eod = -inf, -inf
                elif j + 1 == i:
                    not_hold_eod, hold_eod = 0, -prices[j]
                else:
                    money_dont_sell_curr = dp[i][j - 1][0]
                    money_sell_curr = dp[i][j - 1][1] + prices[j]
                    not_hold_eod = max(money_dont_sell_curr, money_sell_curr)
                    
                    money_keep_holding_prev = dp[i][j - 1][1]
                    money_to_buy_curr_with = dp[i - 1][j - 1][0]
                    money_hold_curr = money_to_buy_curr_with - prices[j]
                    hold_eod = max(money_keep_holding_prev, money_hold_curr)
                
                dp[i][j][0], dp[i][j][1] = not_hold_eod, hold_eod
        
        return max([num_trans_row[-1][0] for num_trans_row in dp])
```

## Notes
- This is a tricky problem because it adds an extra dimension to an otherwise familiar (but still tricky) cp paradigm, 2D dp. This is a 3d dynamic programming problem because we care about: 
    1. the day, 
    2. the number of transactions committed at the end of a given day, and 
    3. stock-holding status (how much money could we have if we held a stock at the end of the current day, and how much money could we have if we didn't hold a stock at the end of the current day).
- All of these three state dimensions affect the amount of money we could have at the end of a given day.
- From a brute-force perspective, the problem is asking us to choose `k` pairs of days such that if we buy on the first day of each pair and sell on the second day of each pair our profit is maximized. With this insight we can easily handle the cases where there are less `n` days than `k` pairs of days - we simply add all the positive slopes between consecutive days. It also allows us to see that a brute force strategy where we enumerate all possible combinations of `k` pairs from `n` will lead to a factorial time complexity, which is not good (`n` choose `2k` -> `n! / ((2k)! * (n - 2k)!)`).
- Ok so the brute-force perspective helps us get rid of one input case but there is still all the cases where `n` days is more than or equal to `k` pairs of days, and so we need to be picky about which days we buy and sell on. For starters we can only consider temporally possible combinations of days (i.e., only consider pair combos where each pair represents a transaction where pairs in the combo come after each other chronologically). This helps cut down on how many cases we will consider, but we will also want to avoid doing redundant calculations (i.e., for a particular `k`, if we want to find the max amount of money we can have after `k` transactions we'll want to avoid recalculating the max amount of money on a given day for `k - 1` transactions, and only worry about the `kth` transaction).
- Ok so now the core logic of the algorithm. For each day with a given number of transactions at our disposal, we can either hold a stock or not hold a stock at the end of the day. We determine the max amount of money we can have if we hold or do not hold a stock for each day, for each transaction number in the range `[0, k]`. For `0` transactions we always have `0` money for not holding and since it is impossible to hold with `0` transactions we have `-inf` for holding. For other transaction numbers, we ignore days for which it is impossible to have commited the current transaction number of transactions. For the first considered day of a given allowed transaction number, the max not holding amount is always `0` and the max holding amount is always `-price` for that day because the only way to hold at the end of that first considered day is to buy the stock that day.
    - If we hold a stock at the end of the day it is either because we bought the stock that day, or we bought a stock a previous day and still hold it. If we bought the stock today, the amount of money we have left after buying it is equal to the amount of money we had on the previous day, if on that previous day we were not holding a stock (we are not allowed to engage in multiple transactions simultaneously) and still had a transaction left to use, minus the price of the stock today. 
    - If we do not hold a stock at the end of the day it is either because we sold stock that we held at the start of the day, or we simply haven't bought a stock yet since the last time we sold (if there was a last time we sold). If we sold stock today for the price of the day, the amount of money we have is equal to the amount we had the day before when we were holding the stock plus the price of the day. We do not have to worry about transaction numbers when selling because we only buy before we sell and we consider transaction numbers when we buy.