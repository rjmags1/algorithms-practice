# 488. Zuma Game - Hard

You are playing a variation of the game Zuma.

In this variation of Zuma, there is a single row of colored balls on a board, where each ball can be colored red `'R'`, yellow `'Y'`, blue `'B'`, green `'G'`, or white `'W'`. You also have several colored balls in your hand.

Your goal is to clear all of the balls from the board. On each turn:

- Pick any ball from your hand and insert it in between two balls in the row or on either end of the row.
- If there is a group of three or more consecutive balls of the same color, remove the group of balls from the board.
    - If this removal causes more groups of three or more of the same color to form, then continue removing each group until there are none left.
- If there are no more balls on the board, then you win the game.
- Repeat this process until you either win or do not have any more balls in your hand.

Given a string `board`, representing the row of balls on the board, and a string `hand`, representing the balls in your hand, return the minimum number of balls you have to insert to clear all the balls from the board. If you cannot clear all the balls from the board using the balls in your hand, return `-1`.

##### Example 1:

```
Input: board = "WRRBBW", hand = "RB"
Output: -1
Explanation: It is impossible to clear all the balls. The best you can do is:
- Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
- Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
There are still balls remaining on the board, and you are out of balls to insert.
```

##### Example 2:

```
Input: board = "WWRRBBWW", hand = "WRBRW"
Output: 2
Explanation: To make the board empty:
- Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
- Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
2 balls from your hand were needed to clear the board.
```

##### Example 3:

```
Input: board = "G", hand = "GGGGG"
Output: 2
Explanation: To make the board empty:
- Insert 'G' so the board becomes GG.
- Insert 'G' so the board becomes GGG. GGG -> empty.
2 balls from your hand were needed to clear the board.
```

##### Constraints:

- `1 <= board.length <= 16`
- `1 <= hand.length <= 5`
- `board` and `hand` consist of the characters `'R'`, `'Y'`, `'B'`, `'G'`, and `'W'`.
- The initial row of balls on the board will not have any groups of three or more consecutive balls of the same color.

## Solution

```
from collections import deque, Counter

# Time: O((5n)^m) where m is hand size and n is board size
# Space: O((m + n) * (5n)^m)
class Solution:
    def removetriplets(self, board, i):
        prev = board[:i] + board[i + 2:]
        while 1:
            curr, n = [], len(prev)
            for i, c in enumerate(prev):
                if 0 < i < n - 1 and prev[i - 1] == prev[i] == prev[i + 1]:
                    continue
                if i < n - 2 and prev[i] == prev[i + 1] == prev[i + 2]:
                    continue
                if i > 1 and prev[i] == prev[i - 1] == prev[i - 2]:
                    continue
                curr.append(c)
            curr = "".join(curr)
            done = prev == curr
            prev = curr
            if done:
                break
        return prev

    def findMinStep(self, board: str, hand: str) -> int:
        q = deque([(board, "".join(sorted(hand)), 0)])
        seen = set()
        while q:
            b, h, k = q.popleft()
            if (b, h) in seen:
                continue
            seen.add((b, h))

            n = len(b)
            for c in set(hand):
                j = h.find(c)
                if j == -1:
                    continue
                newhand = h[:j] + h[j + 1:]
                for i in range(n):
                    doublefirst = (i == 0 or b[i] != b[i - 1]) and i < n - 1 and b[i] == b[i + 1]
                    if not doublefirst:
                        doublesecond = i > 0 and b[i - 1] == b[i]
                        if c == b[i] and not doublesecond:
                            newboard = b[:i + 1] + c + b[i + 1:]
                            if newhand and (newboard, newhand) not in seen:
                                q.append((newboard, newhand, k + 1))
                        continue
                    if c == b[i]:
                        newboard = self.removetriplets(b, i)
                        if not newboard:
                            return k + 1
                        if newhand and (newboard, newhand) not in seen:
                            q.append((newboard, newhand, k + 1))
                    else:
                        newboard = b[:i + 1] + c + b[i + 1:]
                        if newhand and (newboard, newhand) not in seen:
                            q.append((newboard, newhand, k + 1))

        return -1
```

## Notes
- This question appears simple at face value but will TLE unless search pruning is correctly implemented, which is very tricky because one of conditions for search pruning is hard to come up with without a few rounds of trial and error. Instead of BFSing on all game states corresponding to each possible insertion (states from curr state = colors in hand * possible insertion positions for curr state), we should only bother exploring insertions that would lead to the minimum number of steps, in a nonredundant fashion. The only insertion types worth BFSing on are as follows:
    - Inserting to the left of a doublet of the same color as a color in the current hand (inserting in the middle or to the right of the doublet with the same color is redundant)
    - Inserting to the left of a single ball of the same color as a color in the current hand (inserting to the right is redundant)
    - Inserting in the middle of a doublet of a different color than a ball in the current hand (**this is not intuitive at all, at least for me, but these kinds of insertions lead to optimal move sequence for certain cases: eg - board = "RRWWRRBBRR", hand = "BW". Insert B after i = 1, board = "RBRWWRRBBRR". Then insert W after i = 2, board = "RBRWWWRRBBRR" -> "RBRRRBBRR" -> "RBBBRR" -> "RRR" -> ""**).
- Note the time and space complexity are based on the brute force enumerative solution and this solution would not pass if its actual runtime on the test cases was close to the upper complexity bound.