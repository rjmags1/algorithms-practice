# 360. Sort Transformed Array - Medium

Given a sorted integer array `nums` and three integers `a`, `b` and `c`, apply a quadratic function of the form <code>f(x) = ax<sup>2</sup> + bx + c</code> to each element `nums[i]` in the array, and return the array in a sorted order.

##### Example 1:

```
Input: nums = [-4,-2,2,4], a = 1, b = 3, c = 5
Output: [3,9,15,33]
```

##### Example 2:

```
Input: nums = [-4,-2,2,4], a = -1, b = 3, c = 5
Output: [-23,-5,1,7]
```

##### Constraints:

- `1 <= nums.length <= 200`
- `-100 <= nums[i], a, b, c <= 100`
- `nums` is sorted in ascending order.

Follow-up: Could you solve it in `O(n)` time?

## Solution

```
from math import inf

# Time: O(n)
# Space: O(n)
class Solution:
    def sortTransformedArray(self, nums: List[int], a: int, b: int, c: int) -> List[int]:
        f = lambda x: a * x ** 2 + b * x + c
        mid, midi, n = inf, -1, len(nums)
        m = list(map(f, nums))
        for i, num in enumerate(m):
            if num < mid:
                mid, midi = num, i

        if a == 0:
            return m if b >= 0 else list(reversed(m))
        result = []
        if a < 0:
            l, r = 0, n - 1
            while l <= r:
                left, right = m[l], m[r]
                if left <= right:
                    result.append(left)
                    l += 1
                else:
                    result.append(right)
                    r -= 1
        else:
            l, r = midi, midi + 1
            while l >= 0 and r < n:
                left, right = m[l], m[r]
                if left <= right:
                    result.append(left)
                    l -= 1
                else:
                    result.append(right)
                    r += 1
            while l >= 0:
                result.append(m[l])
                l -= 1
            while r < n:
                result.append(m[r])
                r += 1

        return result
```

## Notes
- Could trivially get rid of the linear space by not precomputing the quadratic equation values for `x`. It is trivial to come up with an `O(nlog(n))` solution using custom sort comparator with quadratic equation. To get linear runtime we need to understand quadratic equations. `a` dictates if the U-shaped line resulting from quadratic equation is upside down or not based on its sign, `b` dictates translation in the horizontal dimension, and `c` dictates translation in the vertical dimension. The element `xi` with the largest `f(x)` will be the first or last element of `nums` if `a > 0`, otherwise it will be in the middle of `nums` (this is for cases where elements map to both halves of the quadratic U; we could get inputs where all elements map to the left or right curve of quadratic U, but this is handled by logic that handles both halves case).