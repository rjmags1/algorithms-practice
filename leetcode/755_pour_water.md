# 755. Pour Water - Medium

You are given an elevation map represents as an integer array `heights` where `heights[i]` representing the height of the terrain at index `i`. The width at each index is `1`. You are also given two integers `volume` and `k`. `volume` units of water will fall at index `k`.

Water first drops at the index `k` and rests on top of the highest terrain or water at that index. Then, it flows according to the following rules:

- If the droplet would eventually fall by moving left, then move left.
- Otherwise, if the droplet would eventually fall by moving right, then move right.
- Otherwise, rise to its current position.

Here, "eventually fall" means that the droplet will eventually be at a lower level if it moves in that direction. Also, level means the height of the terrain plus any water in that column.

We can assume there is infinitely high terrain on the two sides out of bounds of the array. Also, there could not be partial water being spread out evenly on more than one grid block, and each unit of water has to be in exactly one block.

##### Example 1:

```
Input: heights = [2,1,1,2,1,2,2], volume = 4, k = 3
Output: [2,2,2,3,2,2,2]
```

##### Example 2:

```
Input: heights = [1,2,3,4], volume = 2, k = 2
Output: [2,3,3,4]
```

##### Example 3:

```
Input: heights = [3,1,3], volume = 5, k = 1
Output: [4,4,4]
```

##### Constraints:

- `1 <= heights.length <= 100`
- `0 <= heights[i] <= 99`
- `0 <= volume <= 2000`
- `0 <= k < heights.length`

## Solution

```
# Time: O(nv)
# Space: O(n)
class Solution:
    def pourWater(self, heights: List[int], volume: int, k: int) -> List[int]:
        result, n = heights[:], len(heights)
        for _ in range(volume):
            i = None
            for j in reversed(range(k)):
                if result[j] > result[j + 1]:
                    break
                if result[j] < result[j + 1]:
                    i = j
            if i is not None:
                result[i] += 1
                continue
            for j in range(k + 1, n):
                if result[j - 1] < result[j]:
                    break
                if result[j - 1] > result[j]:
                    i = j
            result[i if i is not None else k] += 1
        return result
```

## Notes
- Constant space if we mutate the input array or do not count result as part of space complexity. Basic simulation is sufficient for this problem because of low input constraints. Note how we take into account indices that block otherwise lower indices closer to the edges of the input as water is poured.