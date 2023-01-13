# 465. Optimal Account Balancing - Hard

You are given an array of transactions `transactions` where `transactions[i] = [fromi, toi, amounti]` indicates that the person with `ID = fromi` gave `amounti` $ to the person with `ID = toi`.

Return the minimum number of transactions required to settle the debt.

##### Example 1:

```
Input: transactions = [[0,1,10],[2,0,5]]
Output: 2
Explanation:
Person #0 gave person #1 $10.
Person #2 gave person #0 $5.
Two transactions are needed. One way to settle the debt is person #1 pays person #0 and #2 $5 each.
```

##### Example 2:

```
Input: transactions = [[0,1,10],[1,0,1],[1,2,5],[2,0,5]]
Output: 1
Explanation:
Person #0 gave person #1 $10.
Person #1 gave person #0 $1.
Person #1 gave person #2 $5.
Person #2 gave person #0 $5.
Therefore, person #1 only need to give person #0 $4, and all debt is settled.
```

##### Constraints:

- `1 <= transactions.length <= 8`
- `transactions[i].length == 3`
- `0 <= fromi, toi < 12`
- `fromi != toi`
- `1 <= amounti <= 100`

## Solution

```
from collections import defaultdict

# Time: O(n!)
# Space: O(n)
class Solution:
    def minTransfers(self, transactions: List[List[int]]) -> int:
        balances = defaultdict(int)
        for f, t, a in transactions:
            balances[f] -= a
            balances[t] += a

        balances = [v for v in balances.values() if v != 0]
        maxint, n = 2 ** 31 - 1, len(balances)
        def rec(i):
            if i == n:
                return 0
            if balances[i] == 0:
                return rec(i + 1)

            result = maxint
            for j in range(i + 1, n):
                if balances[i] * balances[j] < 0:
                    balances[j] += balances[i]
                    result = min(result, 1 + rec(i + 1))
                    balances[j] -= balances[i]
                    
            return result
        
        return rec(0)
```

## Notes
- This is a tricky one because the optimal way of going about searching for min-steps is not intuitive (at least for me). To start, note the max number of transactions we would ever need to perform is `n - 1` because we have a closed zero-net system; this entails accumulating all negative balances into one of the initial negative balance people, accumulating all positive balances into one of the initial positive balance people, and then a last transaction to bring the final two nonzero balances to `0`. After the first two steps there will be `2` people left with offsetting nonzero balances, and to get to this point will take `n - 2` transactions every time. 
- Also note that during the process of performing the `n - 1` transactions according to the above strategy, that each transaction in the accumulation steps brings a non-accumulator person to a `0` balance. There is a chance we can do better than the "accumulation" strategy described above if we instead move positive balances into negative balances and vice versa, but keep the constraint about offloading each person's entire balance in one transaction. Consider the following example: `balances = [-2, -2, -1, 2, 3]`. The "accumulation" strategy would take `4` transactions, but we could actually equalize in `3` transactions by moving `i = 0` into `i = 3`, then `i = 1` into `i = 2`, then `i = 2` into `i = 4`.
- The solution above looks for the minimum number of transactions based on the idea that we may be able to do better than the accumulation strategy by picking transactions such that transactions between certain subsets of people offset each other prior to the final transaction that offsets the only two nonzero balances left. It considers all possible combinations of transactions between positive and negative balances where the left balance becomes zero after the transaction.