# 283. Move Zeroes - Easy

Given an integer array `nums`, move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.

Note that you must do this in-place without making a copy of the array.

##### Example 1:

```
Input: nums = [0,1,0,3,12]
Output: [1,3,12,0,0]
```

##### Example 2:

```
Input: nums = [0]
Output: [0]
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

Follow-up: Could you minimize the total number of operations done? 

## Solution 1

```
class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        z = nz = 0
        n = len(nums)
        for i in range(n):
            if nums[i] == 0:
                z += 1
            else:
                nz += 1
                
        j = 0
        for i in range(n):
            if nums[i] != 0:
                nums[j] = nums[i]
                j += 1
                if j == nz:
                    break
        for i in range(nz, n):
            nums[i] = 0
```

## Notes
- Count the number of zeroes and nonzeroes.