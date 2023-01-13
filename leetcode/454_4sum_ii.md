# 454. 4Sum II - Medium

Given four integer arrays `nums1`, `nums2`, `nums3`, and `nums4` all of length `n`, return the number of tuples `(i, j, k, l)` such that:

- `0 <= i, j, k, l < n`
- `nums1[i] + nums2[j] + nums3[k] + nums4[l] == 0`

##### Example 1:

```
Input: nums1 = [1,2], nums2 = [-2,-1], nums3 = [-1,2], nums4 = [0,2]
Output: 2
Explanation:
The two tuples are:
1. (0, 0, 0, 1) -> nums1[0] + nums2[0] + nums3[0] + nums4[1] = 1 + (-2) + (-1) + 2 = 0
2. (1, 1, 0, 0) -> nums1[1] + nums2[1] + nums3[0] + nums4[0] = 2 + (-1) + (-1) + 0 = 0
```

##### Example 2:

```
Input: nums1 = [0], nums2 = [0], nums3 = [0], nums4 = [0]
Output: 1
```

##### Constraints:

- `n == nums1.length`
- `n == nums2.length`
- `n == nums3.length`
- `n == nums4.length`
- `1 <= n <= 200`
- <code>-2<sup>28</sup> <= nums1[i], nums2[i], nums3[i], nums4[i] <= 2<sup>28</sup></code>

## Solution

```
from collections import defaultdict

# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def fourSumCount(self, nums1: List[int], nums2: List[int], nums3: List[int], nums4: List[int]) -> int:
        pairs = defaultdict(int)
        for num1 in nums1:
            for num2 in nums2:
                pairs[num1 + num2] += 1
        result = 0
        for num3 in nums3:
            for num4 in nums4:
                target = -(num3 + num4)
                if target in pairs:
                    result += pairs[target]
        return result
```

## Notes
- We can convert the brute force quartic time algorithm to a 2sum variant by asking how many pair sums formed from the first two input arrays are compatible with each pair sum formed from the second two input arrays.