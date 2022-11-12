# 153. Find Minimum in Rotated Sorted Array - Medium

Suppose an array of length `n` sorted in ascending order is rotated between `1` and `n` times. For example, the array `nums = [0,1,2,4,5,6,7]` might become:

- `[4,5,6,7,0,1,2]` if it was rotated `4` times.
- `[0,1,2,4,5,6,7]` if it was rotated `7` times.

Notice that rotating an array `[a[0], a[1], a[2], ..., a[n-1]]` 1 time results in the array `[a[n-1], a[0], a[1], a[2], ..., a[n-2]]`.

Given the sorted rotated array `nums` of unique elements, return the minimum element of this array.

You must write an algorithm that runs in `O(log n)` time.

##### Example 1:

```
Input: nums = [3,4,5,1,2]
Output: 1
Explanation: The original array was [1,2,3,4,5] rotated 3 times.
```

##### Example 2:

```
Input: nums = [4,5,6,7,0,1,2]
Output: 0
Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
```

##### Example 3:

```
Input: nums = [11,13,15,17]
Output: 11
Explanation: The original array was [11,13,15,17] and it was rotated 4 times. 
```

##### Constraints:

- `n == nums.length`
- `1 <= n <= 5000`
- `-5000 <= nums[i] <= 5000`
- All the integers of `nums` are unique.
- `nums` is sorted and rotated between `1` and `n` times.

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def findMin(self, nums: List[int]) -> int:
        l, r = 0, len(nums) - 1
        while l < r:
            mid = (l + r) // 2
            rightSorted = nums[mid + 1] <= nums[r]
            if rightSorted:
                if nums[mid] < nums[mid + 1]:
                    r = mid
                else:
                    return nums[mid + 1]
            else:
                if nums[mid] > nums[mid - 1]:
                    l = mid + 1
                else:
                    return nums[mid]
                
        return nums[r]
```

## Notes
- The prompt basically shouts at us to use binary search for this problem, since we are searching for a particular element and are told we must do it in logarithmic time. With a little bit of observation, or experience with other rotated array problems, we know that for any particular subarray in a rotated array will have one or both of its halves (divided in the middle) sorted. We can also see that the smallest element in `nums` will always come after the rotation point.
- With that knowledge in mind, this is still a pretty tricky medium problem that you need to walk through several examples for in order to catch all edge cases and know to look for the rotation point, not necessarily the smallest element as we do binary search.
- The trick to figuring this problem out is realizing that for any particular `mid`, if the right side (excluding `mid`) is sorted and the element at `mid` is greater than the one after it we have found the rotation point in the array, after which will always reside the smallest element in the array. Otherwise, we can rule out the right side. Note that for a subarray of size `<= 3`, the right side will always be considered sorted because it is a single element. 
- Similarly, if the left side is sorted but the right is not, and the element before `mid` is greater than the element at mid, then we have found the rotation point in the array, and the element at mid is the smallest one in the array. Otherwise we can rule out the whole left side. 