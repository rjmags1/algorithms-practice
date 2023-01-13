# 403. Frog Jump - Hard

A frog is crossing a river. The river is divided into some number of units, and at each unit, there may or may not exist a stone. The frog can jump on a stone, but it must not jump into the water.

Given a list of `stones`' positions (in units) in sorted ascending order, determine if the frog can cross the river by landing on the last stone. Initially, the frog is on the first stone and assumes the first jump must be `1` unit.

If the frog's last jump was `k` units, its next jump must be either `k - 1`, `k`, or `k + 1` units. The frog can only jump in the forward direction.

##### Example 1:

```
Input: stones = [0,1,3,5,6,8,12,17]
Output: true
Explanation: The frog can jump to the last stone by jumping 1 unit to the 2nd stone, then 2 units to the 3rd stone, then 2 units to the 4th stone, then 3 units to the 6th stone, 4 units to the 7th stone, and 5 units to the 8th stone.
```

##### Example 2:

```
Input: stones = [0,1,2,3,4,8,9,11]
Output: false
Explanation: There is no way to jump to the last stone as the gap between the 5th and 6th stone is too large.
```

##### Constraints:

- <code>0 <= stones[i] <= 2<sup>31</sup> - 1</code>
- `2 <= stones.length <= 2000`
- `stones[0] == 0`
- `stones` is sorted in a strictly increasing order.

## Solution

```
from collections import defaultdict

# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def canCross(self, stones: List[int]) -> bool:
        jumps, positions = defaultdict(set), set(stones)
        jumps[stones[0]].add(1)
        n = len(stones)
        for i, pos in enumerate(stones):
            for jump in jumps[pos]:
                to = pos + jump
                if to not in positions:
                    continue
                for d in range(-1, 2):
                    if jump + d > 0:
                        jumps[to].add(jump + d)
        return len(jumps[stones[-1]]) > 0
```

## Notes
- Straightforward for a hard, the only tricky part is recognizing the need for sets, as well as seeing that just because a particular stone can't be reached doesn't preclude a stone to the right from being reachable.
- The space is quadratic because each position could be reached by at most each other position.