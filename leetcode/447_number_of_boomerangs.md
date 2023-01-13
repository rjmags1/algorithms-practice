# 447. Number of Boomerangs - Medium

You are given `n` `points` in the plane that are all distinct, where `points[i] = [xi, yi]`. A boomerang is a tuple of points `(i, j, k)` such that the distance between `i` and `j` equals the distance between `i` and `k` (the order of the tuple matters).

Return the number of boomerangs.

##### Example 1:

```
Input: points = [[0,0],[1,0],[2,0]]
Output: 2
Explanation: The two boomerangs are [[1,0],[0,0],[2,0]] and [[1,0],[2,0],[0,0]].
```

##### Example 2:

```
Input: points = [[1,1],[2,2],[3,3]]
Output: 2
```

##### Example 3:

```
Input: points = [[1,1]]
Output: 0
```

##### Constraints:

- <code>n == points.length</code>
- <code>1 <= n <= 500</code>
- <code>points[i].length == 2</code>
- <code>-10<sup>4</sup> <= xi, yi <= 10<sup>4</sup></code>
- All the points are unique.

## Solution

```
from functools import cache
from collections import defaultdict

# Time: O(n^2)
# Space: O(n)
class Solution:
    def numberOfBoomerangs(self, points: List[List[int]]) -> int:
        @cache
        def fact(n):
            if n <= 1:
                return 1
            return n * fact(n - 1)

        permnk = lambda n, k: fact(n) // fact(n - k)
        d = lambda x1, x2, y1 ,y2: (x1 - x2) ** 2 + (y1 - y2) ** 2
        result, n = 0, len(points)
        for i in range(n):
            dists = defaultdict(int)
            x1, y1 = points[i]
            for j in range(n):
                if i == j:
                    continue
                x2, y2 = points[j]
                dists[d(x1, x2, y1, y2)] += 1
            for freq in dists.values():
                if freq > 1:
                    result += permnk(freq, 2)
        return result
```

## Notes
- This problem is tricky because we need to handle the case where there are more than `2` points that are the same distance away from the center 'boomerang' point at index `i`. This requires recognizing that order matters when considering boomerangs, i.e. `(i, j, k)` is a boomerang and `(k, j, i)` is a boomerang. For these cases, the number of boomerangs centered at `i` is equal to permutation of points distance x from `j` choose 2.
- Note the calculation of factorial for this problem is dominated by the double for loop, because the largest arg that will get passed to `fact` is `n`, which takes `O(n)` time in the worse case, results in `n` recursive calls, and will return any factorial `<= n` in constant time thereafter. We could not handle factorials this easily in languages besides python due to integer size constraints; for other languages we would need to forego factorial calculations and realize permutation `n` choose `2` is equal to `n!/(n - 2)!` which is equal to `n * (n - 1)`. 