# 254. Factor Combinations - Medium

Numbers can be regarded as the product of their factors.

- For example, `8 = 2 x 2 x 2 = 2 x 4`.

Given an integer `n`, return all possible combinations of its factors. You may return the answer in any order.

Note that the factors should be in the range `[2, n - 1]`.

##### Example 1:

```
Input: n = 1
Output: []
```

##### Example 2:

```
Input: n = 12
Output: [[2,6],[3,4],[2,2,3]]
```

##### Example 3:

```
Input: n = 37
Output: []
```

##### Constraints:

- <code>1 <= n <= 10<sup>7</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(nlog(n))
class Solution:
    def getFactors(self, n: int) -> List[List[int]]:
        def factors(start, n):
            result = []
            stop = int(sqrt(n)) + 1
            for smaller in range(start, stop):
                if n % smaller == 0:
                    larger = n // smaller
                    result.append([smaller, larger])
                    for combo in factors(smaller, larger):
                        result.append([smaller] + combo)
            return result
        
        return factors(2, n)
```

## Notes
- The hardest part of this problem is avoiding redundant combinations. For situations like these when we want to examine the factors of some number recursively, it helps to use the square root of the number so we do not double count factor pairs; i.e., `(2, 6)` and `(6, 2)` for `12`.
- Using a square root bound is helpful, but we will still get redundant combinations if that is the only preventative measure we take. Consider the case of `n = 12`. If we iterate over `[2, sqrt(12)]`, we will get pairs `(2, 6)` and `(3, 4)`. But both of these pairs will cause `(2, 2, 3)` to get added to the result redundantly. We can avoid this situation by placing a lower bound on the factors that are allowed to show up in a combination. This lower bound should be `smaller` from the recursive call that generate the initial size `2` combination, because any factors lower than that will have already been considered in previous recursive calls.