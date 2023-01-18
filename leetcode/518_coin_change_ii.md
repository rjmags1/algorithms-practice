# 518. Coin Change II - Medium

You are given an integer array `coins` representing coins of different denominations and an integer `amount` representing a total amount of money.

Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return `0`.

You may assume that you have an infinite number of each kind of coin.

The answer is guaranteed to fit into a signed 32-bit integer.

##### Example 1:

```
Input: amount = 5, coins = [1,2,5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1
```

##### Example 2:

```
Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.
```

##### Example 3:

```
Input: amount = 10, coins = [10]
Output: 1
```

##### Constraints:

- `1 <= coins.length <= 300`
- `1 <= coins[i] <= 5000`
- `0 <= amount <= 5000`
- All the values of `coins` are unique.

## Solution

```
from functools import cache

# Time: O(n^2 * m)
# Space: O(nm)
class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        if amount == 0:
            return 1

        coins = sorted([c for c in coins if c <= amount])
        n = len(coins)
        @cache
        def rec(left, i):
            result = 0
            for j in range(i, n):
                if coins[j] > left:
                    break
                result += 1 if coins[j] == left else rec(left - coins[j], j)
            return result
        
        return rec(amount, 0)
```

## Notes
- Sort the coins before backtracking to only consider coins that would not exceed the current amount of `amount` we have left to make up. Otherwise each recursive call would do a full `O(n)` for loop. Avoid duplicate combinations by only considering coins whose index is `>= i`.