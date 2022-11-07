# 52. N-Queens II - Hard

The n-queens puzzle is the problem of placing `n` queens on an `n x n` chessboard such that no two queens attack each other.

Given an integer `n`, return the number of distinct solutions to the n-queens puzzle.

##### Example 1:

```
Input: n = 4
Output: 2
```

##### Example 2:

```
Input: n = 1
Output: 1
```

##### Constraints:

- `1 <= n <= 9`

## Solution

```
# Time: O(n!)
# Space: O(n)
class Solution:
    def totalNQueens(self, n: int) -> int:
        result = 0
        cols = [False] * n
        posdiags = [False] * (2 * n - 1)
        negdiags = [False] * (2 * n - 1)
        def rec(i):
            nonlocal result
            if i == n:
                result += 1
                return
            
            for j in range(n):
                pdscore = i + j
                ndscore = abs(j - i - n + 1)
                if cols[j] or posdiags[pdscore] or negdiags[ndscore]:
                    continue
                
                cols[j] = posdiags[pdscore] = negdiags[ndscore] = True
                rec(i + 1)
                cols[j] = posdiags[pdscore] = negdiags[ndscore] = False
        
        rec(0)
        return result
```

## Notes
- We can't avoid the factorial complexity in this version of the problem, but we can cut down on the space used, since we only need to find the number of unique solutions, not every actual unique board state constituting a solution. For this reason, we do not need to generate the board, which is <code>O(n<sup>2</sup>)</code>. All of the other auxiliary data structures are `O(n)`, including the recursive call stack, so we reduce space used to `O(n)`.