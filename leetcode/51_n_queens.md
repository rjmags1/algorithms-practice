# 51. N-Queens - Hard

The n-queens puzzle is the problem of placing `n` queens on an `n x n` chessboard such that no two queens attack each other.

Given an integer `n`, return all distinct solutions to the n-queens puzzle. You may return the answer in any order.

Each solution contains a distinct board configuration of the n-queens' placement, where `'Q'` and `'.'` both indicate a queen and an empty space, respectively.

##### Example 1:

```
Input: n = 4
Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
```

##### Example 2:

```
Input: n = 1
Output: [["Q"]]
```

##### Constraints:

- `1 <= n <= 9`

## Solution

```
# Time: O(n!)
# Space: O(n^2)
class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        board = [["." for _ in range(n)] for _ in range(n)]
        cols = [False] * n
        posdiags = [False] * (2 * n - 1)
        negdiags = [False] * (2 * n - 1)
        result = []
        def rec(i):
            if i == n:
                result.append(["".join(row) for row in board])
                return
            
            for j in range(n):
                pdscore = i + j
                ndscore = abs(j - i - n + 1)
                if cols[j] or posdiags[pdscore] or negdiags[ndscore]:
                    continue
                
                cols[j] = posdiags[pdscore] = negdiags[ndscore] = True
                board[i][j] = 'Q'
                rec(i + 1)
                board[i][j] = '.'
                cols[j] = posdiags[pdscore] = negdiags[ndscore] = False
        
        rec(0)
        return result
```

## Notes
- This backtracking solution is a vast improvement over the brute force solution because we only attempt to place successive queens on unattackable cells. Take note of the formula for possible positive and negative slope diagonals for an `n x n` matrix, as well as the formulas for determining the hash key for lookup of a cell's diagonals based on `i` and `j`. The trickiest part of this problem for me was determining how to calculate the hash key for negative diagonal lookup based on `i` and `j`.
- The time complexity is factorial because we will only ever place one queen per row/col in this approach. For the first queen, there are `n` rows/cols we could place her on. For the second queen, there are at most `n - 1` rows/cols we could place her on, and so forth. 