# 526. Beautiful Arrangement - Medium

Suppose you have `n` integers labeled `1` through `n`. A permutation of those `n` integers `perm` (1-indexed) is considered a beautiful arrangement if for every `i` (`1 <= i <= n`), either of the following is true:

- `perm[i]` is divisible by `i`.
- `i` is divisible by `perm[i]`.

Given an integer `n`, return the number of the beautiful arrangements that you can construct.

##### Example 1:

```
Input: n = 2
Output: 2
Explanation: 
The first beautiful arrangement is [1,2]:
    - perm[1] = 1 is divisible by i = 1
    - perm[2] = 2 is divisible by i = 2
The second beautiful arrangement is [2,1]:
    - perm[1] = 2 is divisible by i = 1
    - i = 2 is divisible by perm[2] = 1
```

##### Example 2:

```
Input: n = 1
Output: 1
```

##### Constraints:

- `1 <= n <= 15`

## Solution

```
from functools import cache

# Time: O(n^2 * 2^n)
# Space: O(n * 2^n)
class Solution:
    def countArrangement(self, n: int) -> int:
        @cache
        def rec(i, mask):
            if i == n + 1:
                return 1

            bit, result = 1, 0
            for num in range(1, n + 1):
                if not mask & bit:
                    if num % i == 0 or i % num == 0:
                        mask ^= bit
                        result += rec(i + 1, mask)
                        mask ^= bit
                bit <<= 1
            return result
        
        return rec(1, 0)
```

## Notes
- Bitmask to represent numbers that have already been used in the given permutation. `i` represents the 1-index we are trying to occupy with an available number. Memoization/dp prevents re-solving previously solved `(i, mask)` subproblems. Note the actual runtime is actually much faster than its asympototic upper bound due to search pruning according to problem constraints.