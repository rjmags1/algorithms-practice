# 2483. Minimum Penalty for a Shop - Medium

You are given the customer visit log of a shop represented by a 0-indexed string customers consisting only of characters `'N'` and `'Y'`:

- if the `i`th character is `'Y'`, it means that customers come at the `i`th hour
whereas `'N'` indicates that no customers come at the `i`th hour.

If the shop closes at the `j`th hour (`0 <= j <= n`), the penalty is calculated as follows:

- For every hour when the shop is open and no customers come, the penalty increases by `1`.
- For every hour when the shop is closed and customers come, the penalty increases by `1`.

Return the earliest hour at which the shop must be closed to incur a minimum penalty.

Note that if a shop closes at the `j`th hour, it means the shop is closed at the hour `j`.

##### Example 1:

```
Input: customers = "YYNY"
Output: 2
Explanation: 
- Closing the shop at the 0th hour incurs in 1+1+0+1 = 3 penalty.
- Closing the shop at the 1st hour incurs in 0+1+0+1 = 2 penalty.
- Closing the shop at the 2nd hour incurs in 0+0+0+1 = 1 penalty.
- Closing the shop at the 3rd hour incurs in 0+0+1+1 = 2 penalty.
- Closing the shop at the 4th hour incurs in 0+0+1+0 = 1 penalty.
Closing the shop at 2nd or 4th hour gives a minimum penalty. Since 2 is earlier, the optimal closing time is 2.
```

##### Example 2:

```
Input: customers = "NNNNN"
Output: 0
Explanation: It is best to close the shop at the 0th hour as no customers arrive.
```

##### Example 3:

```
Input: customers = "YYYY"
Output: 4
Explanation: It is best to close the shop at the 4th hour as customers arrive at each hour.
```

##### Constraints:

- <code>1 <= customers.length <= 10<sup>5</sup></code>
- `customers` consists only of characters `'Y'` and `'N'`.

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def bestClosingTime(self, customers: str) -> int:
        # penalty(i) = sum(1 for k in range(i) if N == A[k]) +
        #                   sum(1 for k in range(i, n) if Y == A[k])
        n = len(customers)
        dp = [[0, 0] for _ in range(n + 1)]
        for i in range(n + 1):
            if i > 0:
                dp[i][0] = int(customers[i - 1] == 'N') + dp[i - 1][0]
            if i < n:
                dp[n - i - 1][1] = int(customers[n - i - 1] == 'Y') + (0 if i == 0 else dp[n - i][1])
        return min((sum(pen), i) for i, pen in enumerate(dp))[1]
```

## Notes
- Trivial dp relation if solved this way but we can do better on space.

## Solution 2

```
# Time: O(n) 1-pass
# Space: O(1)
class Solution:
    def bestClosingTime(self, customers: str) -> int:
        result = min_bal = bal = 0
        for i, c in enumerate(customers):
            if c == 'Y':
                bal -= 1
            else:
                bal += 1
            
            if bal < min_bal:
                min_bal, result = bal, i + 1
        
        return result
```

## Notes
- Note that all that matters is the ratio of `Y`s at or before a given `i` to `N`s after. We can use this to get down to constant space and one pass.
