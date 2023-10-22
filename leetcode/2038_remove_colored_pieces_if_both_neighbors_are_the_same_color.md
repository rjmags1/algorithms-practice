# 2038. Remove Colored Pieces if Both Neighbors are the Same Color - Medium

There are `n` pieces arranged in a line, and each piece is colored either by `'A'` or by `'B'`. You are given a string `colors` of length `n` where `colors[i]` is the color of the `i`th piece.

Alice and Bob are playing a game where they take alternating turns removing pieces from the line. In this game, Alice moves first.

- Alice is only allowed to remove a piece colored `'A'` if both its neighbors are also colored `'A'`. She is not allowed to remove pieces that are colored `'B'`.
- Bob is only allowed to remove a piece colored `'B'` if both its neighbors are also colored `'B'`. He is not allowed to remove pieces that are colored `'A'`.
- Alice and Bob cannot remove pieces from the edge of the line.
- If a player cannot make a move on their turn, that player loses and the other player wins.

Assuming Alice and Bob play optimally, return `true` if Alice wins, or return `false` if Bob wins.

##### Example 1:

```
Input: colors = "AAABABB"
Output: true
Explanation:
AAABABB -> AABABB
Alice moves first.
She removes the second 'A' from the left since that is the only 'A' whose neighbors are both 'A'.

Now it's Bob's turn.
Bob cannot make a move on his turn since there are no 'B's whose neighbors are both 'B'.
Thus, Alice wins, so return true.
```

##### Example 2:

```
Input: colors = "AA"
Output: false
Explanation:
Alice has her turn first.
There are only two 'A's and both are on the edge of the line, so she cannot move on her turn.
Thus, Bob wins, so return false.
```

##### Example 3:

```
Input: colors = "ABBBBBBBAAA"
Output: false
Explanation:
ABBBBBBBAAA -> ABBBBBBBAA
Alice moves first.
Her only option is to remove the second to last 'A' from the right.

ABBBBBBBAA -> ABBBBBBAA
Next is Bob's turn.
He has many options for which 'B' piece to remove. He can pick any.

On Alice's second turn, she has no more pieces that she can remove.
Thus, Bob wins, so return false.
```

##### Constraints:

- <code>1 <= colors.length <= 10<sup>5</sup></code>
- `colors` consists of only the letters `'A'` and `'B'`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def winnerOfGame(self, colors: str) -> bool:
        alice = bob = 0
        n = len(colors)
        for i in range(1, n - 1):
            c = colors[i]
            if colors[i - 1] == c == colors[i + 1]:
                alice += int(c == 'A')
                bob += int(c == 'B')
        return alice > bob
```

## Notes
- Easy to overthink this one, the prompt is phrased like a decision tree/minmax problem. After some thought it becomes clear that to memoize you would need to pass a modified version of `colors` to each recursive call, which is not feasible given the constraints. From there you realize, regardless of removal order, whichever player has more removable pieces is the one who wins.