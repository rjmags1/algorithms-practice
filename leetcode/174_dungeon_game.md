# 174. Dungeon Game - Hard

The demons had captured the princess and imprisoned her in the bottom-right corner of a `dungeon`. The `dungeon` consists of `m x n` rooms laid out in a 2D grid. Our valiant knight was initially positioned in the top-left room and must fight his way through `dungeon` to rescue the princess.

The knight has an initial health point represented by a positive integer. If at any point his health point drops to `0` or below, he dies immediately.

Some of the rooms are guarded by demons (represented by negative integers), so the knight loses health upon entering these rooms; other rooms are either empty (represented as 0) or contain magic orbs that increase the knight's health (represented by positive integers).

To reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.

Return the knight's minimum initial health so that he can rescue the princess.

Note that any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.

##### Example 1:

```
Input: dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
Output: 7
Explanation: The initial health of the knight must be at least 7 if he follows the optimal path: RIGHT-> RIGHT -> DOWN -> DOWN.
```

##### Example 2:

```
Input: dungeon = [[0]]
Output: 1
```

##### Constraints:

- `m == dungeon.length`
- `n == dungeon[i].length`
- `1 <= m, n <= 200`
- `-1000 <= dungeon[i][j] <= 1000`

## Solution

```
# Time: O(mn)
# Space: O(mn)
class Solution:
    def calculateMinimumHP(self, dungeon: List[List[int]]) -> int:
        m, n = len(dungeon), len(dungeon[0])
        dp = [[None] * n for _ in range(m)]
        destviadown = destviaright = None
        for i in reversed(range(m)):
            for j in reversed(range(n)):
                points = dungeon[i][j]
                if i == m - 1:
                    if j == n - 1:
                        dp[i][j] = abs(min(0, points)) + 1
                        continue
                    destviadown = inf
                    destviaright = 1 if points >= dp[i][j + 1] else dp[i][j + 1] - points
                elif j == n - 1:
                    destviaright = inf
                    destviadown = 1 if points >= dp[i + 1][j] else dp[i + 1][j] - points
                else:
                    destviadown = 1 if points >= dp[i + 1][j] else dp[i + 1][j] - points
                    destviaright = 1 if points >= dp[i][j + 1] else dp[i][j + 1] - points
                    
                dp[i][j] = min(destviadown, destviaright)
                
        return dp[0][0]
```

## Notes
- This is a good introduction to problems that require reverse order solutions. Consider the problem with applying a top down solution: ostensibly, if we tried to calculate the minimum health needed to get to the destination starting from `i == 0` and `j == 0`, we would go from cell to cell in typical fashion, filling out our 2d matrix with the minimum health needed to get to that cell, which would be equivalent to the smallest cost to get to that cell `+ 1`. This ignores cases where it would be better to incur a greater cost to get to a cell in order to get a large magic orb down the line that would absorb the cost of fighting an excessively large demon further down the line than the large magic orb.
- In short, the choices we make from the start for some particular `i` and `j` depend not just on cells that came before them in forward order, but also on cells after them. If we were to start from the destination and go backwards, we could however say definitively that the cost to get to destination from the current cell depends only on the cells that came before it as we iterate in reverse order.
- Practically speaking, once you fiddle to no avail with a top-down approach for 10 minutes or so it is time to try something else. This is a classic dp paradigm (data about getting to get to a cell depends on the ones above and to the right of it) so you know we need a 2d matrix. What is there left to try? Alternative iteration (reverse in this case) order. 
- The conceptual strategy to this problem is iterating in reverse order over a 2d matrix, where each cell represents the minimum health needed to get to the destination from that cell. The base case, `i == m - 1` and `j == n - 1`, is `1` if the room is empty or there is a magic orb in it, otherwise it is the cost of fighting the demon in the room `+ 1`. For all other cases we need to consider how the gain of getting a magic orb in the current cell (if there is one) or the cost of fighting a demon in the current cell (if there is one) affects the minimum health needed to get to the destination from the current cell: more specifically the minimum health needed to get to the destination if we choose to go down from here or to the right. 
- If there is an orb in the current cell, the minimum health needed to get to the destination from the current cell will be less than the minimum health needed to get to the destination via going down or to the right by the difference between the size of our current magic orb and the the minimum health for the down and right cells respectively. If the orb is greater or equal to the min health for the down or right cells, this means the orb absorbs any further cost of getting to the destination down the line, so we simply need `1` health here. 
- If there is a demon in the current cell, the minimum health needed to get to the destination from the current cell will increase by the cost of fighting the demon. We would want the smaller of the min health of going down versus the right, and then we would subtract the cost of fighting the demon from that smaller previous min health.
- This logic is summarized in the recurrence relation `destvia_rightordown_ = 1 if points >= minhealth_rightordown_ else minhealth_rightordown_ - points`. This is because the cost of fighting demons is represented as negative in the input (`points` will be negative in this case) whereas gain from magic orbs is positive. It may be more intuitive to understand by first determining whether there is an orb or a demon in the current cell based on sign and then using absolute value to determine the associated gain/cost to fight respectively.
- Note how the recurrence relation only depends on the current row and the row below it; this means we could optimize the space complexity of the solution to `O(n)` using two `O(n)` arrays as opposed to a full `m * n` 2d matrix, which is trivial so I will not include it here. The main takeaway for this problem is understanding why reverse order is needed. 