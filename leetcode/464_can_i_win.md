# 464. Can I Win - Medium

In the "100 game" two players take turns adding, to a running total, any integer from `1` to `10`. The player who first causes the running total to reach or exceed 100 wins.

What if we change the game so that players cannot re-use integers?

For example, two players might take turns drawing from a common pool of numbers from 1 to 15 without replacement until they reach a total >= 100.

Given two integers `maxChoosableInteger` and `desiredTotal`, return `true` if the first player to move can force a win, otherwise, return `false`. Assume both players play optimally.

##### Example 1:

```
Input: maxChoosableInteger = 10, desiredTotal = 11
Output: false
Explanation:
No matter which integer the first player choose, the first player will lose.
The first player can choose an integer from 1 up to 10.
If the first player choose 1, the second player can only choose integers from 2 up to 10.
The second player will win by choosing 10 and get a total = 11, which is >= desiredTotal.
Same with other integers chosen by the first player, the second player will always win.
```

##### Example 2:

```
Input: maxChoosableInteger = 10, desiredTotal = 0
Output: true
```

##### Example 3:

```
Input: maxChoosableInteger = 10, desiredTotal = 1
Output: true
```

##### Constraints:

- 1 <= maxChoosableInteger <= 20
- 0 <= desiredTotal <= 300

## Solution 1

```
from functools import cache

# Time: O(2^n * n^2)
# Space: O(2^n)
class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        if (maxChoosableInteger * (maxChoosableInteger + 1)) // 2 < desiredTotal:
            return False
            
        avail = 0
        for _ in range(maxChoosableInteger):
            avail = (avail << 1) | 1

        @cache
        def rec(avail, remaining):
            shift1 = 1
            for num1 in range(1, maxChoosableInteger + 1):
                if avail & shift1:
                    if num1 >= remaining:
                        return True

                    avail ^= shift1
                    shift2 = 1
                    wins = True
                    for num2 in range(1, maxChoosableInteger + 1):
                        if avail & shift2:
                            if num1 + num2 >= remaining or not rec(avail^shift2, remaining - (num1 + num2)):
                                wins = False
                                break
                        shift2 <<= 1
                    if wins:
                        return True
                    avail |= shift1
                    
                shift1 <<= 1

            return False
        
        return rec(avail, desiredTotal)
```

## Notes
- Minimax; player 1 can guarantee a win despite both players playing optimally if there is any series of moves by player 1 such that no matter what player 2 does, player 1 will always win. The above approach searches for such a series of moves; at the start of each recursive call it is player 1's turn, and we see if there is any number that player 1 could choose such that no matter what player 2 chooses player 1 will always win. Below is a more asymptotically efficient though less intuitive implementation of the same idea.

## Solution 2

```
from functools import cache

# Time: O(2^n * n)
# Space: O(2^n)
class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        if desiredTotal == 0:
            return True
        if (maxChoosableInteger * (maxChoosableInteger + 1)) // 2 < desiredTotal:
            return False

        p1, p2 = 0, 1
        @cache
        def rec(pool, turn):
            total = sum(i + 1 for i in range(maxChoosableInteger) if (1 << i) & pool)
            if total >= desiredTotal:
                return turn != p1
            
            p1wins, bit = not turn == p1, 1
            for poolnum in range(1, maxChoosableInteger + 1):
                if not pool & bit:
                    if turn == p1:
                        p1wins = p1wins or rec(pool | bit, p2)
                    else:
                        p1wins = p1wins and rec(pool | bit, p1)
                bit <<= 1
            return p1wins
        
        return rec(0, p1)
```

## Notes
- No nested for loop; if it is player 1's turn given a particular `pool` of numbers to choose from, any pick that results in a player 1 win regardless of player 2's subsequent moves results in player 1 being guaranteed to win. Similarly, if it is player 2's turn, if no matter what player 2 does this move they will always lose, player 1 is guaranteed to win given a particular `pool`.