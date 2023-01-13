# 414. Third Maximum Number - Easy

Given an integer array `nums`, return the third distinct maximum number in this array. If the third maximum does not exist, return the maximum number.

##### Example 1:

```
Input: nums = [3,2,1]
Output: 1
Explanation:
The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.
```

##### Example 2:

```
Input: nums = [1,2]
Output: 2
Explanation:
The first distinct maximum is 2.
The second distinct maximum is 1.
The third distinct maximum does not exist, so the maximum (2) is returned instead.
```

##### Example 3:

```
Input: nums = [2,2,3,1]
Output: 1
Explanation:
The first distinct maximum is 3.
The second distinct maximum is 2 (both 2's are counted together since they have the same value).
The third distinct maximum is 1.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

Follow-up: Can you find an `O(n)` solution?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def thirdMax(self, nums: List[int]) -> int:
        m1 = m2 = m3 = -math.inf
        for num in nums:
            if num > m1:
                m1, m2, m3 = num, m1, m2
            elif num > m2 and num != m1:
                m2, m3 = num, m2
            elif num > m3 and num not in [m1, m2]:
                m3 = num

        return m3 if m3 != -math.inf else m1
```

## Notes
- Trivial just make sure we handle __distinct__ requirement of prompt.