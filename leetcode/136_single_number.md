# 136. Single Number - Easy

Given a non-empty array of integers `nums`, every element appears twice except for one. Find that single one.

You must implement a solution with a linear runtime complexity and use only constant extra space.

##### Example 1:

```
Input: nums = [2,2,1]
Output: 1
```

##### Example 2:

```
Input: nums = [4,1,2,1,2]
Output: 4
```

##### Example 3:

```
Input: nums = [1]
Output: 1
```

##### Constraints:

- <code>1 <= nums.length <= 3 * 10<sup>4</sup></code>
- <code>-3 * 10<sup>4</sup> <= nums[i] <= 3 * 10<sup>4</sup></code>
- Each element in the array appears twice except for one element which appears only once.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        mask = 0
        for num in nums:
            mask ^= num
        return mask
```

## Notes
- XOR is commutative: `a ^ b ^ a == a ^ a ^ b == (a ^ a) ^ b == 0 ^ b == b`. It is just like addition and multiplication are commutative, though maybe not as intuitive because we don't learn about XOR in elementary school.
- If you are a beginner and don't know about this trick, you'll probably get extremely discouraged over trying to abide by the constraints in the prompt to no avail despite this being an Easy ranked problem.