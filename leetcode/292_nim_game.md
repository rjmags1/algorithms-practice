# 292. Nim Game - Easy

You are playing the following Nim Game with your friend:

- Initially, there is a heap of stones on the table.
- You and your friend will alternate taking turns, and you go first.
- On each turn, the person whose turn it is will remove 1 to 3 stones from the heap.
- The one who removes the last stone is the winner.

Given n, the number of stones in the heap, return true if you can win the game assuming both you and your friend play optimally, otherwise return false.

##### Example 1:

```
Input: n = 4
Output: false
Explanation: These are the possible outcomes:
1. You remove 1 stone. Your friend removes 3 stones, including the last stone. Your friend wins.
2. You remove 2 stones. Your friend removes 2 stones, including the last stone. Your friend wins.
3. You remove 3 stones. Your friend removes the last stone. Your friend wins.
In all outcomes, your friend wins.
```

##### Example 2:

```
Input: n = 1
Output: true
```

##### Example 3:

```
Input: n = 2
Output: true
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def canWinNim(self, n: int) -> bool:
        return n % 4 != 0
```

## Notes
- This is a good introduction to dynamic programming as it relies on answers to subproblems to simplify the process of answering the main problem.
- Consider the range of examples `n = [1, 2, 3, 4, 5, 6, 7, 8]`. For `1-3`, because it is assumed players play optimally, you will always win because you go first. For `4`, no matter how many stones you take off the top first, your friend will be able to take off the rest, and so your friend will win. So for `n = 4`, there is no way you can win. For higher values of `n`, if players play optimally, they will be trying to get the other player to a state such that there is a multiple of `4` stones on the stack when it is the other players turn, because in such a case the player who does not have their turn when there are `4n` stones on the stack will be able to maintain this paradigm until there are `4` stones on the stack and it is the other players turn.