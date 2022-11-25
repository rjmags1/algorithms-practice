# 260. Single Number III - Medium

Given an integer array `nums`, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in any order.

You must write an algorithm that runs in linear runtime complexity and uses only constant extra space.

##### Example 1:

```
Input: nums = [1,2,1,3,2,5]
Output: [3,5]
Explanation:  [5, 3] is also a valid answer.
```

##### Example 2:

```
Input: nums = [-1,0]
Output: [-1,0]
```

##### Example 3:

```
Input: nums = [0,1]
Output: [1,0]
```

##### Constraints:

- <code>2 <= nums.length <= 3 * 10<sup>4</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>
- Each integer in `nums` will appear twice, only two integers will appear once.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        mask1 = 0
        for num in nums:
            mask1 ^= num
            
        rightmostinmask1 = mask1 & (~mask1 + 1)
        mask2 = 0
        for num in nums:
            if num & rightmostinmask1:
                mask2 ^= num
                
        return [mask2, mask1^mask2]
```

## Notes
- Since an XOR bitmask will contain all 1-bits of the two single numbers that are not present in the same position in the other single number, we can isolate one of those bits and use it to identify one of the single numbers by only XORing numbers that have a 1-bit in the position of the isolated 1-bit. Once we have one of the single numbers, we can easily identify the other single number by XORing the first single number with the original mask.