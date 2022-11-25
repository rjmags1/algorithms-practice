# 294. Flip Game II - Medium

You are playing a Flip Game with your friend.

You are given a string `currentState` that contains only `'+'` and `'-'`. You and your friend take turns to flip two consecutive `"++"` into `"--"`. The game ends when a person can no longer make a move, and therefore the other person will be the winner.

Return `true` if the starting player can guarantee a win, and `false` otherwise.

##### Example 1:

```
Input: currentState = "++++"
Output: true
Explanation: The starting player can guarantee a win by flipping the middle "++" to become "+--+".
```

##### Example 2:

```
Input: currentState = "+"
Output: false
```

##### Constraints:

- `1 <= currentState.length <= 60`
- `currentState[i]` is either `'+'` or `'-'`.

Follow-up: Derive your algorithm's runtime complexity.

## Solution

```
# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def canWin(self, currentState: str) -> bool:
        n = len(currentState)
        
        @cache
        def rec(state):
            p2won = True
            for i in range(n - 1):
                if state[i] == state[i + 1] == "+":
                    p2won = False
            if p2won:
                return False
            
            spl = [c for c in state]
            p1couldwin = False
            for i in range(n - 1):
                if spl[i] == spl[i + 1] == "+":
                    spl[i] = spl[i + 1] = "-"
                    p2couldwin = False
                    for j in range(n - 1):
                        if spl[j] == spl[j + 1] == "+":
                            spl[j] = spl[j + 1] = "-"
                            p2couldwin = not rec("".join(spl))
                            spl[j] = spl[j + 1] = "+"
                            if p2couldwin:
                                break
                    p1couldwin = not p2couldwin
                    if p1couldwin:
                        break
                    spl[i] = spl[i + 1] = "+"
                    
            return p1couldwin
                
        return rec(currentState)
```

## Notes
- For the time and space, there are <code>n<sup>2</sup></code> possible states to explore in the worst case, and we explore all of them. Consider the input `"++++++++"`. There are `7` possible flips we could do, which leads to `7` unique next states and `4 - 5` possible next flips.
- This problem is trickier than it seems at first glance and requires some drawing out of a recursive tree to get right. Player 1 is guaranteed to win if there is some first move they can make that changes the game state such that no matter what player 2 does next, player 1 will be able to eventually eliminate the last `"++"` if they make the optimal moves along the way. In other words, as long as there is a move that could lead to a win for player 1, player 1 can guarantee a win.