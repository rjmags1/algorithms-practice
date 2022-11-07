# 121. Best Time to Buy and Sell Stock - Easy

You are given an array `prices` where `prices[i]` is the price of a given stock on the `i`th day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return `0`.

##### Example 1:

```
Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
```

##### Example 2:

```
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.
```

##### Constraints:

- <code>1 <= prices.length <= 10<sup>5</sup></code>
- <code>0 <= prices[i] <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        result, l = 0, inf
        for p in prices:
            l = min(l, p)
            result = max(result, p - l)
        return result
```

## Notes
- The max profit for a given input in this question is the largest difference between an element and one that came before it. It helps to graph `prices` with indices on the x-axis and elements on the y-axis.