# 605. Can Place Flowers - Easy

You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.

Given an integer array `flowerbed` containing `0`'s and `1`'s, where `0` means empty and `1` means not empty, and an integer `n`, return if `n` new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule.

##### Example 1:

```
Input: flowerbed = [1,0,0,0,1], n = 1
Output: true
```

##### Example 2:

```
Input: flowerbed = [1,0,0,0,1], n = 2
Output: false
```

##### Constraints:

- <code>1 <= flowerbed.length <= 2 * 10<sup>4</sup></code>
- `flowerbed[i]` is `0` or `1`.
- There are no two adjacent flowers in `flowerbed`.
- `0 <= n <= flowerbed.length`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def canPlaceFlowers(self, flowerbed: List[int], n: int) -> bool:
        spots = len(flowerbed)
        placed = False
        def canplant(i):
            nonlocal placed
            left = 0 if i == 0 else flowerbed[i - 1]
            right = 0 if i == spots - 1 else flowerbed[i + 1]
            placed = not placed and not flowerbed[i] and left + right == 0
            return placed
        return sum(canplant(i) for i in range(spots)) >= n
```

## Notes
- To plant a flower in a particular position, there needs to be no adjacent flowers in `flowerbed`, no flower already in the position, and we can't have just planted a flower to the left. We are essentially accumulating the number of flowers we can plant between flowers already in `flowerbed`, which depends entirely on the parity of empty spaces between flowers: `empties // 2` if odd number of empty spaces otherwise `empties // 2 - 1`.