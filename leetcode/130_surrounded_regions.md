# 130. Surrounded Regions - Medium

Given an `m x n` matrix board containing `'X'` and `'O'`, capture all regions that are 4-directionally surrounded by `'X'`.

A region is captured by flipping all `'O'`s into `'X'`s in that surrounded region.

##### Example 1:

```
Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
Explanation: Notice that an 'O' should not be flipped if:
- It is on the border, or
- It is adjacent to an 'O' that should not be flipped.
The bottom 'O' is on the border, so it is not flipped.
The other three 'O' form a surrounded region, so they are flipped.
```

##### Example 2:

```
Input: board = [["X"]]
Output: [["X"]]
```

##### Constraints:

- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 200`
- `board[i][j]` is `'X'` or `'O'`.

## Solution 1

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def solve(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        m, n = len(board), len(board[0])
        diffs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        def borderzero(i, j, island):
            if board[i][j] == "X":
                return False
            if i == 0 or i == m - 1 or j == 0 or j == n - 1:
                return True
            
            island.add((i, j))
            bz = False
            for di, dj in diffs:
                k, l = i + di, j + dj
                if (k, l) in island:
                    continue
                if borderzero(k, l, island):
                    bz = True
                
            return bz
        
        for i in range(m):
            for j in range(n):
                if board[i][j] == "X":
                    continue
                island = set()
                if not borderzero(i, j, island):
                    for (k, l) in island:
                        board[k][l] = "X"
```

## Notes
- The trickiest part of this problem is realizing that the only uncaptured zero regions will be ones containing one or more border zeroes; the prompt is worded in a way that suggests this, but indirectly.
- This approach enumerates all zero-regions, determining if it contains a border zero as it goes. If it doesn't contain a border zero after finding all cells in the region, it marks all cells in the region with "X".
- Despite the fact that this passes on LC, the low runtime and memory percentile indicates there is probably a better way of going about this. Indeed, there is no need to investigate all zero-regions; we only need to find the ones with a border zero to answer this problem.

## Solution 2

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def solve(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        m, n = len(board), len(board[0])
        diffs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        def dfs(i, j):
            if board[i][j] == "X":
                return
            
            board[i][j] = None
            for di, dj in diffs:
                k, l = i + di, j + dj
                if not 0 <= k < m or not 0 <= l < n:
                    continue
                if board[k][l] == "X" or board[k][l] == None:
                    continue
                dfs(k, l)
        
        for i in range(m):
            dfs(i, 0)
        for i in range(m):
            dfs(i, n - 1)
        for j in range(n):
            dfs(0, j)
        for j in range(n):
            dfs(m - 1, j)
        
        for i in range(m):
            for j in range(n):
                board[i][j] = "O" if board[i][j] is None else "X"
```

## Notes
- This approach, though it has the same time and space complexity as above, is much more efficient because it only enumerates zero-regions that have border-zeroes; we simply ignore all the central ones that do not have border zeroes, saving a lot of time. This is a good use case for dfs.
- We use much less memory in this solution too because we do not use a set to keep track of visited cells, despite the fact that the worst case space complexity will be the same; instead we just mark border-zero region cells with `None` before advancing to neighboring cells, and this is sufficient to prevent redundant cell visits because we only advance to cells with zero as their values.