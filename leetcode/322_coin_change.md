# 322. Coin Change - Medium

You are given an integer array `coins` representing coins of different denominations and an integer `amount` representing a total amount of money.

Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return `-1`.

You may assume that you have an infinite number of each kind of coin.

##### Example 1:

```
Input: coins = [1,2,5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1
```

##### Example 2:

```
Input: coins = [2], amount = 3
Output: -1
```

##### Example 3:

```
Input: coins = [1], amount = 0
Output: 0
```

##### Constraints:

- <code>1 <= coins.length <= 12</code>
- <code>1 <= coins[i] <= 2<sup>31</sup> - 1</code>
- <code>0 <= amount <= 10<sup>4</sup></code>

## Solution 1

```
# Time: O(nk)
# Space: O(n)
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        coins.sort()
        ways = [inf] * (amount + 1)
        ways[0] = 0
        for amount in range(1, amount + 1):
            for coin in coins:
                if coin > amount:
                    break
                ways[amount] = min(ways[amount], ways[amount - coin] + 1)
        return ways[-1] if ways[-1] != inf else -1
```

## Notes
- Bottom-up

## Solution 2

```
# Time: O(nk)
# Space: O(n)
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        @cache
        def rec(n):
            if n == 0:
                return 0
            
            result = inf
            for coin in coins:
                if coin > n:
                    continue
                result = min(result, 1 + rec(n - coin))
            return result
        
        minways = rec(amount)
        return minways if minways != inf else -1
```

## Notes
- Topdown. For any given amount we try to make up part of it with 1 coin and see how many coins it takes to make up the rest. For that amount once we have checked all coins we return the minimum amount.