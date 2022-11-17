# 37. Sudoku Solver - Hard

Write a program to solve a Sudoku puzzle by filling the empty cells.

A sudoku solution must satisfy all of the following rules:

- Each of the digits `1-9` must occur exactly once in each row.
- Each of the digits `1-9` must occur exactly once in each column.
- Each of the digits `1-9` must occur exactly once in each of the 9 `3x3` sub-boxes of the grid.

The `'.'` character indicates empty cells.

##### Example 1:

```
Input: board = [
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]
Output: [
    ["5","3","4","6","7","8","9","1","2"],
    ["6","7","2","1","9","5","3","4","8"],
    ["1","9","8","3","4","2","5","6","7"],
    ["8","5","9","7","6","1","4","2","3"],
    ["4","2","6","8","5","3","7","9","1"],
    ["7","1","3","9","2","4","8","5","6"],
    ["9","6","1","5","3","7","2","8","4"],
    ["2","8","7","4","1","9","6","3","5"],
    ["3","4","5","2","8","6","1","7","9"]
]
Explanation: The input board is shown above and the only valid solution is shown below:
```

##### Constraints:

- `board.length == 9`
- `board[i].length == 9`
- `board[i][j]` is a digit or `'.'`.
- It is guaranteed that the input board has only one solution.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def solveSudoku(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        rows = [[False] * 10 for _ in range(9)]
        cols = [[False] * 10 for _ in range(9)]
        grids = [[False] * 10 for _ in range(9)]
        for i in range(len(board)):
            for j in range(len(board[0])):
                if board[i][j] == '.':
                    continue
                num = int(board[i][j])
                rows[i][num] = True
                cols[j][num] = True
                grid = i // 3 * 3 + j // 3
                grids[grid][num] = True
        
        def solve(i, j):
            if i == 9 or j == 9:
                return True if i == 9 else solve(i + 1, 0)
            if board[i][j] != '.':
                return solve(i, j + 1)
            
            grid = i // 3 * 3 + j // 3
            for poss in range(1, 10):
                if rows[i][poss] or cols[j][poss] or grids[grid][poss]:
                    continue
                    
                rows[i][poss] = cols[j][poss] = grids[grid][poss] = True
                board[i][j] = str(poss)
                if solve(i, j + 1):
                    return True
                rows[i][poss] = cols[j][poss] = grids[grid][poss] = False
                board[i][j] = '.'
            
            return False
        
        solve(0, 0)
```

## Notes
- This is a classic backtracking problem. We cut down on some extra runtime with the `rows`, `cols`, and `grids` data structures, which allow us to do direct lookup on possible numbers (as opposed to iterating to check if they are already present in a row, column, or grid).
- Though the time is constant because we are only dealing with `9x9` sudoku boards for this problem, we could express it as <code>O((n!)<sup>n</sup>)</code>, where `n == len(board) == len(board[0])`. For each row, there are `n!` possible configurations, and there are `n` rows.