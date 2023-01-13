# 374. Guess Number Higher or Lower - Easy

We are playing the Guess Game. The game is as follows:

I pick a number from `1` to `n`. You have to guess which number I picked.

Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.

You call a pre-defined API `int guess(int num)`, which returns three possible results:

- `-1`: Your guess is higher than the number I picked (i.e. `num > pick`).
- `1`: Your guess is lower than the number I picked (i.e. `num < pick`).
- `0`: your guess is equal to the number I picked (i.e. `num == pick`).

Return the number that I picked.

##### Example 1:

```
Input: n = 10, pick = 6
Output: 6
```

##### Example 2:

```
Input: n = 1, pick = 1
Output: 1
```

##### Example 3:

```
Input: n = 2, pick = 1
Output: 1
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>
- <code>1 <= pick <= n</code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def guessNumber(self, n: int) -> int:
        l, r = 1, n
        while l < r:
            mid = (l + r) // 2
            check = guess(mid)
            if check == 0:
                return mid
            if check == -1:
                r = mid - 1
            else:
                l = mid + 1
        return l
```

## Notes
- Binary search