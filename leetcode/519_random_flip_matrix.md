# 519. Random Flip Matrix - Medium

There is an `m x n` binary grid `matrix` with all the values set `0` initially. Design an algorithm to randomly pick an index `(i, j)` where `matrix[i][j] == 0` and flips it to `1`. All the indices `(i, j)` where `matrix[i][j] == 0` should be equally likely to be returned.

Optimize your algorithm to minimize the number of calls made to the built-in random function of your language and optimize the time and space complexity.

Implement the `Solution` class:

- `Solution(int m, int n)` Initializes the object with the size of the binary matrix `m` and `n`.
- `int[] flip()` Returns a random index `[i, j]` of the matrix where `matrix[i][j] == 0` and flips it to `1`.
- `void reset()` Resets all the values of the matrix to be `0`.


##### Example 1:

```
Input
["Solution", "flip", "flip", "flip", "reset", "flip"]
[[3, 1], [], [], [], [], []]
Output
[null, [1, 0], [2, 0], [0, 0], null, [2, 0]]

Explanation
Solution solution = new Solution(3, 1);
solution.flip();  // return [1, 0], [0,0], [1,0], and [2,0] should be equally likely to be returned.
solution.flip();  // return [2, 0], Since [1,0] was returned, [2,0] and [0,0]
solution.flip();  // return [0, 0], Based on the previously returned indices, only [0,0] can be returned.
solution.reset(); // All the values are reset to 0 and can be returned.
solution.flip();  // return [2, 0], [0,0], [1,0], and [2,0] should be equally likely to be returned.
```

##### Constraints:

- <code>1 <= m, n <= 10<sup>4</sup></code>
- There will be at least one free cell for each call to `flip`.
- At most `1000` calls will be made to `flip` and `reset`.

## Solution

```
# Time: O(1) all methods
# Space: O(mn)
class Solution:
    def __init__(self, m: int, n: int):
        self.m, self.n, self.size = m, n, m * n
        self.idxs = {}

    def flip(self) -> List[int]:
        k = random.randrange(0, self.size)
        num = self.idxs[k] if k in self.idxs else k
        last = self.idxs[self.size - 1] if self.size - 1 in self.idxs else self.size - 1
        self.idxs[k], self.idxs[self.size - 1] = last, num
        self.size -= 1
        return [num // self.n, num % self.n]

    def reset(self) -> None:
        self.idxs = {}
        self.size = self.m * self.n
```

## Notes
- This solution is based on idea of storing randomly picked elements from indices in the range `[0, n - prevpicks - 1]` at index `n - prevpicks - 1` and swapping the random pick index with `n - prevpicks - 1`, where `prevpicks` is the number of picks since the last `reset`. To adapt to the 2d situation we just use modular math to get 2d indices from a 1d index of size `m * n`.
- Based on the input constraints, we will TLE if we try to allocate a full `m * n` 1d array to simulate matrix positions. We can simulate such a 1d array with a hash table, storing the indices of elements that get swapped according to the above strategy. This adjustment optimizes runtime complexity for all methods to constant, and minimizes space usage as well, though not affecting space usage asymptotically.