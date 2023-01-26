# 573. Squirrel Simulation - Medium

You are given two integers `height` and `width` representing a garden of size `height x width`. You are also given:

- an array `tree` where `tree = [treer, treec]` is the position of the tree in the garden,
- an array `squirrel` where `squirrel = [squirrelr, squirrelc]` is the position of the squirrel in the garden,
- and an array `nuts` where `nuts[i] = [nutir, nutic]` is the position of the `ith` nut in the garden.

The squirrel can only take at most one nut at one time and can move in four directions: up, down, left, and right, to the adjacent cell.

Return the minimal distance for the squirrel to collect all the nuts and put them under the tree one by one.

The distance is the number of moves.

##### Example 1:

```
Input: height = 5, width = 7, tree = [2,2], squirrel = [4,4], nuts = [[3,0], [2,5]]
Output: 12
Explanation: The squirrel should go to the nut at [2, 5] first to achieve a minimal distance.
```

##### Example 2:

```
Input: height = 1, width = 3, tree = [0,1], squirrel = [0,0], nuts = [[0,2]]
Output: 3
```

##### Constraints:

- `1 <= height, width <= 100`
- `tree.length == 2`
- `squirrel.length == 2`
- `1 <= nuts.length <= 5000`
- `nuts[i].length == 2`
- `0 <= treer, squirrelr, nutir <= height`
- `0 <= treec, squirrelc, nutic <= width`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minDistance(self, height: int, width: int, tree: List[int], squirrel: List[int], nuts: List[List[int]]) -> int:
        d = lambda i1, j1, i2, j2: abs(i1 - i2) + abs(j1 - j2)
        ti, tj = tree
        fromtrees = sum(2 * d(ti, tj, i, j) for i, j in nuts)
        result = 2 ** 31 - 1
        si, sj = squirrel
        for i, j in nuts:
            treedists = fromtrees - d(ti, tj, i, j)
            result = min(result, treedists + d(si, sj, i, j))
        return result
```

## Notes
- For all nuts except for the first one the squirrel grabs starting from its initial position, the squirrel makes a round trip from the tree to the next nut and back to the tree. So we just need to find the nut that the squirrel should go to first such that the first trip (initial position -> nut -> tree) plus the distances of the rest of the trips is minimized. This involves basic math, obsoleting backtracking/enumeration/memoization of all paths. 