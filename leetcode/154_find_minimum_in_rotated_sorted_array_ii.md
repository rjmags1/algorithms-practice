# 154. Find Minimum in Rotated Sorted Array - Hard

Suppose an array of length `n` sorted in ascending order is rotated between `1` and `n` times. For example, the array `nums = [0,1,4,4,5,6,7]` might become:

- `[4,5,6,7,0,1,4]` if it was rotated `4` times.
- `[0,1,4,4,5,6,7]` if it was rotated `7` times.

Notice that rotating an array `[a[0], a[1], a[2], ..., a[n-1]]` `1` time results in the array `[a[n-1], a[0], a[1], a[2], ..., a[n-2]]`.

Given the sorted rotated array `nums` that may contain duplicates, return the minimum element of this array.

You must decrease the overall operation steps as much as possible.

##### Example 1:

```
Input: nums = [1,3,5]
Output: 1
```

##### Example 2:

```
Input: nums = [2,2,2,0,1]
Output: 0
```

##### Constraints:

- `n == nums.length`
- `1 <= n <= 5000`
- `-5000 <= nums[i] <= 5000`
- `nums` is sorted and rotated between `1` and `n` times.

Follow-up: This problem is similar to Find Minimum in Rotated Sorted Array, but `nums` may contain duplicates. Would this affect the runtime complexity? How and why?

## Solution

```
# Time: O(log(n)) best, O(n) worst
# Space: O(1)
class Solution:
    def findMin(self, nums: List[int]) -> int:
        def linearSearch(i, j):
            result = inf
            for k in range(i, j + 1):
                result = min(result, nums[k])
            return result
        
        l, r = 0, len(nums) - 1
        while l < r:
            if nums[l] == nums[r]:
                return linearSearch(l, r)
            
            mid = (l + r) // 2
            m = nums[mid]
            rightSorted = nums[mid + 1] <= nums[r]
            if rightSorted:
                if m > nums[mid + 1]:
                    return nums[mid + 1]
                else:
                    r = mid
            else:
                if nums[mid - 1] > m:
                    return m
                else:
                    l = mid + 1
                    
        return nums[r]
```

## Notes
- This question is the same as 153. Find Minimum in Sorted Array but we can have duplicate elements. It relies on the same core logic: in a rotated array, one of the two halves surrounding a particular `mid` value during a binary search must be sorted. Based on this fact, we can say with certainty based on the element located at `mid` and which of the two halves are sorted, if `mid` is located adjacent to the rotation point.
- The tricky part about the possibility of duplicate elements showing up in our input is that it can be impossible to tell which of the two halves is sorted without resorting to a linear search: take a case such as `[4, 1, 4, 4, 4, 4, 4]`. We can see with our eyes that for `mid = 3`, the left side is sorted, but there is no way for our binary search algorithm to know in constant time if the left or right is sorted by comparing the start and end values of the respective halves. In this case we have no choice but to resort to a linear search.