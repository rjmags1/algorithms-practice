# Title - Diff

##### Example 1:

```

```

##### Example 2:

```

```

##### Example 3:

```

```

##### Constraints:



Follow-up: 

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def rob(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return nums[0]
        a, b = nums[:n - 1], nums[1:]
        def maxsubnoadj(nums):
            n = len(nums)
            if n < 3:
                return nums[0] if n == 1 else max(nums[0], nums[1])
            first, second = nums[0], nums[1]
            for i in range(2, n):
                num = nums[i]
                first, second = max(first, second), max(first + num, second)
            return second
        return max(maxsubnoadj(a), maxsubnoadj(b))
```

## Notes
- Note the space could easily be optimized to `O(1)` by modifying the `maxsubnoadj` function to work over a range of indices of the original input, as opposed to slicing into new functions.
- The trick to avoiding considering cycles in this question is simply considering the biggest possible subarrays that would not have adjacent start and end indices, and then returning the largest max nonadjacent subset sum of these two subarrays.
- In the `maxsubnoadj` function, `first` always holds the maximum nonadjacent subset sum at the start of the current iteration for `num`, and `second` always holds the maximum adjacent subset sum.