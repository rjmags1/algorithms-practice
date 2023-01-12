# 280. Wiggle Sort - Medium

Given an integer array `nums`, reorder it such that `nums[0] <= nums[1] >= nums[2] <= nums[3]....`

You may assume the input array always has a valid answer.

##### Example 1:

```
Input: nums = [3,5,2,1,6,4]
Output: [3,5,1,6,2,4]
Explanation: [1,6,2,5,3,4] is also accepted.
```

##### Example 2:

```
Input: nums = [6,6,5,6,3,8]
Output: [6,6,5,6,3,8]
```

##### Example 3:

```

```

##### Constraints:

- <code>1 <= nums.length <= 5 * 10<sup>4</sup></code>
- <code>0 <= nums[i] <= 10<sup>4</sup></code>
- It is guaranteed that there will be an answer for the given input nums.

Follow-up: Could you solve the problem in `O(n)` time complexity?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        for i in range(len(nums) - 1):
            if not i & 1 and nums[i] > nums[i + 1]:
                nums[i], nums[i + 1] = nums[i + 1], nums[i]
            if i & 1 and nums[i] < nums[i + 1]:
                nums[i], nums[i + 1] = nums[i + 1], nums[i]
```

## Notes
- A sorting solution could work where we interweave the next smallest number with the next largest number, where the smallest and largest numbers are init to the first half of the sorted list and the end of the second half of the sorted list. 
- However, with some experimentation one could see that this is not necessary. At odd indexes we can just swap the current number with the next number if it is less than it. At even indexes we can swap the current number with the next number if it is greater than it. This works because even indices are supposed to be valleys and odd indices are supposed to be peaks, and we are guaranteed that our input will be wiggle-sortable. If we ever get to an odd index that is not a peak, it means the next number is greater than the current number, and the previous number is less than the current number, everytime. So, it is safe to swap the current and next numbers as `nums[:i + 1]` will remain wiggle-sorted after. Similar logic applies to the case where an even index is not a valley.