# 79. Word Search - Medium

Given an `m x n` grid of characters `board` and a string `word`, return `true` if `word` exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

##### Example 1:

```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true
```

##### Example 2:

```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true
```

##### Example 3:

```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false
```

##### Constraints:


- `m == board.length`
- `n = board[i].length`
- `1 <= m, n <= 6`
- `1 <= word.length <= 15`
- `board` and `word` consists of only lowercase and uppercase English letters.


Follow-up: Could you use search pruning to make your solution faster with a larger `board`?

## Solution

```
# Time: O(n * 3^l)
# Space: O(l)
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        m, n, l = len(board), len(board[0]), len(word)
        visited = set()
        dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        def dfs(i, j, k):
            if board[i][j] != word[k]:
                return False
            if k == l - 1:
                return True
            
            pos = (i, j)
            visited.add(pos)
            for di, dj in dirs:
                a, b = i + di, j + dj
                if not 0 <= a < m or not 0 <= b < n:
                    continue
                if (a, b) in visited:
                    continue
                if dfs(a, b, k + 1):
                    return True
            visited.remove(pos)
            
            return False
        
        for i in range(m):
            for j in range(n):
                if dfs(i, j, 0):
                    return True
        return False
```

## Notes
-  Fairly basic backtracking with DFS, just need to be careful about the ordering of base cases (as is typical in recursive implementations), as well as being sure not to double count squares.