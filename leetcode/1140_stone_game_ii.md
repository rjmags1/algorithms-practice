# 1140. Stone Game II - Medium

Alice and Bob continue their games with piles of stones.  There are a number of piles arranged in a row, and each pile has a positive integer number of stones `piles[i]`.  The objective of the game is to end with the most stones. 

Alice and Bob take turns, with Alice starting first.  Initially, `M = 1`.

On each player's turn, that player can take all the stones in the first `X` remaining piles, where `1 <= X <= 2M`.  Then, we set `M = max(M, X)`.

The game continues until all the stones have been taken.

Assuming Alice and Bob play optimally, return the maximum number of stones Alice can get.

##### Example 1:

```
Input: piles = [2,7,9,4,4]
Output: 10
Explanation:  If Alice takes one pile at the beginning, Bob takes two piles, then Alice takes 2 piles again. Alice can get 2 + 4 + 4 = 10 piles in total. If Alice takes two piles at the beginning, then Bob can take all three piles left. In this case, Alice get 2 + 7 = 9 piles in total. So we return 10 since it's larger. 
```

##### Example 2:

```
Input: piles = [1,2,3,4,5,100]
Output: 104
```

##### Constraints:

- <code>1 <= piles.length <= 100</code>
- <code>1 <= piles[i] <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n^3)
# Space: O(n^3)
class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        n = len(piles)
        memo = {}
        def maxstones(i, m, p):
            params = (i, m, p)
            if i == n:
                return 0
            if params in memo:
                return memo[params]

            result = 10 ** 9 if p == 1 else -1
            curr_take = 0
            for x in range(1, min(2 * m, n - i) + 1):
                curr_take += piles[i + x - 1]
                if p == -1:
                    result = max(result, curr_take + maxstones(i + x, max(m, x), 1))
                else:
                    result = min(result, maxstones(i + x, max(m, x), -1))

            memo[params] = result
            return result
        
        return maxstones(0, 1, -1)
```

## Notes
- Min-max problem. Most of the prompts for these problems are ambiguous because in order to play optimally (by definition of the logic yielding the answer that solves the test cases) players need to know all possible outcomes, which is confusing. Key thing to keep in mind for these problems is if it is the players turn whose score we are trying to maximize, we want the current decision that maximizes the future result, and if it is the turn of the other player, we want the current decision that minimizes the other player's future result.