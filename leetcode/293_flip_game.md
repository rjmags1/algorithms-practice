# 293. Flip Game - Easy

You are playing a Flip Game with your friend.

You are given a string `currentState` that contains only `'+'` and `'-'`. You and your friend take turns to flip two consecutive `"++"` into `"--"`. The game ends when a person can no longer make a move, and therefore the other person will be the winner.

Return all possible states of the string `currentState` after one valid move. You may return the answer in any order. If there is no valid move, return an empty list `[]`.

##### Example 1:

```
Input: currentState = "++++"
Output: ["--++","+--+","++--"]
```

##### Example 2:

```
Input: currentState = "+"
Output: []
```

##### Constraints:

- `1 <= currentState.length <= 500`
- `currentState[i]` is either `'+'` or `'-'`.

## Solution

```
# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def generatePossibleNextMoves(self, currentState: str) -> List[str]:
        s = [c for c in currentState]
        n = len(s)
        result = []
        for i in range(n - 1):
            if s[i] == s[i + 1] == "+":
                cp = s[:]
                cp[i] = cp[i + 1] = "-"
                result.append("".join(cp))
        return result
```

## Notes
- For inputs like `"++++"` we will create `n - 1` new strings to add to `result`. 