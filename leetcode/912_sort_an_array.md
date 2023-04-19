# 912. Sort an Array - Medium

Given an array of integers `nums`, sort the array in ascending order and return it.

You must solve the problem without using any built-in functions in `O(nlog(n))` time complexity and with the smallest space complexity possible.

##### Example 1:

```
Input: nums = [5,2,3,1]
Output: [1,2,3,5]
Explanation: After sorting the array, the positions of some numbers are not changed (for example, 2 and 3), while the positions of other numbers are changed (for example, 1 and 5).
```

##### Example 2:

```
Input: nums = [5,1,1,2,0,0]
Output: [0,0,1,1,2,5]
Explanation: Note that the values of nums are not necessairly unique.
```

##### Constraints:

- <code>1 <= nums.length <= 5 * 10<sup>4</sup></code>
- <code>-5 * 10<sup>4</sup> <= nums[i] <= 5 * 10<sup>4</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def sortArray(self, nums: List[int]) -> List[int]:
        def mergesort(arr, temp, i, j):
            if i >= j:
                return arr
            
            mid = (i + j) // 2
            left = mergesort(temp, arr, i, mid)
            right = mergesort(temp, arr, mid + 1, j)
            k, kl, kr = i, i, mid + 1
            while kl <= mid and kr <= j:
                if temp[kl] <= temp[kr]:
                    arr[k] = temp[kl]
                    kl += 1
                else:
                    arr[k] = temp[kr]
                    kr += 1
                k += 1
            
            while kl <= mid:
                arr[k] = temp[kl]
                kl += 1
                k += 1
            
            while kr <= j:
                arr[k] = temp[kr]
                kr += 1
                k += 1
            
            return arr

        return mergesort(nums, nums[:], 0, len(nums) - 1)
```

## Notes
- This version of mergesort uses a single temp array to achieve linear space, though other implementations will often use a temp array for each recursive call. It is possible to achieve constant space with a heap sort based approach, however I did not feel like implementing a heap myself.