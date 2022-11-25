# 289. Game of Life - Medium

According to Wikipedia's article: "The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970."

The board is made up of an `m x n` grid of cells, where each cell has an initial state: live (represented by a `1`) or dead (represented by a `0`). Each cell interacts with its eight neighbors (horizontal, vertical, diagonal) using the following four rules (taken from the above Wikipedia article):

- Any live cell with fewer than two live neighbors dies as if caused by under-population.
- Any live cell with two or three live neighbors lives on to the next generation.
- Any live cell with more than three live neighbors dies, as if by over-population.
- Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

The next state is created by applying the above rules simultaneously to every cell in the current state, where births and deaths occur simultaneously. Given the current state of the `m x n` grid `board`, return the next state.

##### Example 1:

```
Input: board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
Output: [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]
```

##### Example 2:

```
Input: board = [[1,1],[1,0]]
Output: [[1,1],[1,1]]
```

##### Constraints:

- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 25`
- `board[i][j]` is `0` or `1`.

Follow-up:

- Could you solve it in-place? Remember that the board needs to be updated simultaneously: You cannot update some cells first and then use their updated values to update other cells.
- In this question, we represent the board using a 2D array. In principle, the board is infinite, which would cause problems when the active area encroaches upon the border of the array (i.e., live cells reach the border). How would you address these problems?

## Solution

```
# Time: O(mn) (2-pass)
# Space: O(1)
class Solution:
    def gameOfLife(self, board: List[List[int]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        DEAD, LIVE, WILLDIE, WILLLIVE = 0, 1, 2, 3
        diffs = ((-1, 0), (1, 0), (0, -1), (0, 1),
                (-1, -1), (-1, 1), (1, -1), (1, 1))
        m, n = len(board), len(board[0])
        inbounds = lambda i, j: 0 <= i < m and 0 <= j < n
        def score(i, j):
            score = 0
            for di, dj in diffs:
                i2, j2 = i + di, j + dj
                if not inbounds(i2, j2):
                    continue
                if board[i2][j2] in [LIVE, WILLDIE]:
                    score += 1
            return score
        
        for i in range(m):
            for j in range(n):
                s = score(i, j)
                if board[i][j] == LIVE:
                    board[i][j] = LIVE if s in [2, 3] else WILLDIE
                else:
                    board[i][j] = DEAD if s != 3 else WILLLIVE
        
        for i in range(m):
            for j in range(n):
                if board[i][j] in [WILLDIE, WILLLIVE]:
                    board[i][j] = DEAD if board[i][j] == WILLDIE else LIVE
```

## Notes
- To get constant space mark cells that will transition in a way that preserves their original state while also indicating their future state.