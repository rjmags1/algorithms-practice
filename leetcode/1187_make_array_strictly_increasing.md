# 1187. Make Array Strictly Increasing - Hard

Given two integer arrays `arr1` and `arr2`, return the minimum number of operations (possibly zero) needed to make `arr1` strictly increasing.

In one operation, you can choose two indices `0 <= i < arr1.length` and `0 <= j < arr2.length` and do the assignment `arr1[i] = arr2[j]`.

If there is no way to make `arr1` strictly increasing, return `-1`.

##### Example 1:

```
Input: arr1 = [1,5,3,6,7], arr2 = [1,3,2,4]
Output: 1
Explanation: Replace 5 with 2, then arr1 = [1, 2, 3, 6, 7].
```

##### Example 2:

```
Input: arr1 = [1,5,3,6,7], arr2 = [4,3,1]
Output: 2
Explanation: Replace 5 with 3 and then replace 3 with 4. arr1 = [1, 3, 4, 6, 7].
```

##### Example 3:

```
Input: arr1 = [1,5,3,6,7], arr2 = [1,6,3,3]
Output: -1
Explanation: You can't make arr1 strictly increasing.
```

##### Constraints:

- <code>1 <= arr1.length, arr2.length <= 2000</code>
- <code>0 <= arr1[i], arr2[i] <= 10^<sup>9</sup></code>

## Solution

```
from functools import cache
from bisect import bisect_right

# Time: O(n * (m + n) * log(m))
# Space: O(n * (m + n))
class Solution:
    def makeArrayIncreasing(self, arr1: List[int], arr2: List[int]) -> int:
        # BF: for each i, test the result of replacing or not replacing 
                # with the smallest arr2[j] greater than arr1[i - 1] if i > 0 else min(arr2)
            # O(2^n) * m -> TLE
        # BF but memoize on (i, x) where x is elem at i - 1
            # O(n * (m + n) * log(m)) <- (2e3 * 4e3 * ~1e1)

        arr2 = sorted(arr2)
        n, m = len(arr1), len(arr2)
        no_answer = 10 ** 4

        @cache
        def rec(i, prev):
            if i == n:
                return 0

            replacement_j = bisect_right(arr2, prev)
            no_replacement = replacement_j == m
            result = no_answer
            if prev >= arr1[i]:
                if not no_replacement:
                    result = 1 + rec(i + 1, arr2[replacement_j])
            else:
                result = rec(i + 1, arr1[i])
                if not no_replacement:
                    result = min(result, 1 + rec(i + 1, arr2[replacement_j]))
                    
            return result if result < no_answer else no_answer
            
        result = rec(1, arr1[0])
        if arr2[0] < arr1[0]:
            result = min(result, 1 + rec(1, arr2[0]))
        return -1 if result == no_answer else result
```

## Notes
- To solve all cases you need to understand that for any `i`, whether we replace with some `j` or not depends on if replacing or not replacing leads to an ultimately smaller number of overall replacements. We essentially need to explore the space of all relevant increasing subsequences constructable from `arr1` by replacing from elements of `arr2` while avoiding an exponential time complexity. To do this we can memoize on `(i, x)` where `x` is the element we ended up placing at `i - 1` in the previous recursive call. There are only `4e3` possible values for `x` and `2e3` possible values for `i` based on the constraints, and if we sort `arr2` so we can perform binary search on it to find the best replacement for the current `i` (the smallest number in `arr2` that is greater than the `x`), we'll be able to avoid TLE with time complexity `O(n * (m + n) * log(m))`.