# 852. Peak Index in a Mountain Array - Medium

An array `arr` is a mountain if the following properties hold:

- `arr.length >= 3`
- There exists some `i` with `0 < i < arr.length - 1` such that:
    - `arr[0] < arr[1] < ... < arr[i - 1] < arr[i]` 
    - `arr[i] > arr[i + 1] > ... > arr[arr.length - 1]`

Given a mountain array `arr`, return the index `i` such that `arr[0] < arr[1] < ... < arr[i - 1] < arr[i] > arr[i + 1] > ... > arr[arr.length - 1]`.

You must solve it in `O(log(arr.length))` time complexity.

##### Example 1:

```
Input: arr = [0,1,0]
Output: 1
```

##### Example 2:

```
Input: arr = [0,2,1,0]
Output: 1
```

##### Example 3:

```
Input: arr = [0,10,5,2]
Output: 1
```

##### Constraints:

- <code>3 <= arr.length <= 10<sup>5</sup></code>
- <code>0 <= arr[i] <= 10<sup>6</sup></code>
- <code>arr is guaranteed to be a mountain array.</code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        l, r = 1, len(arr) - 2
        while l < r:
            mid = (l + r) // 2
            prev, m, nxt = arr[mid - 1], arr[mid], arr[mid + 1]
            if prev < m and m > nxt:
                return mid
            if prev < m or m < nxt:
                l = mid + 1
            else:
                r = mid - 1

        return l
```

## Notes
- Modified binary search. This prompt does not guarantee inputs will not have subarrays of length `>= 3` of equivalent elements which confused me a bit, because correctly handling this case would case the time to degenerate to linear. Turns out none of the test cases address this.