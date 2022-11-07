# 88. Merge Sorted Array - Easy

You are given two integer arrays `nums1` and `nums2`, sorted in non-decreasing order, and two integers `m` and `n`, representing the number of elements in `nums1` and `nums2` respectively.

Merge `nums1` and `nums2` into a single array sorted in non-decreasing order.

The final sorted array should not be returned by the function, but instead be stored inside the array `nums1`. To accommodate this, `nums1` has a length of `m + n`, where the first `m` elements denote the elements that should be merged, and the last `n` elements are set to `0` and should be ignored. `nums2` has a length of `n`.

##### Example 1:

```
Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
Output: [1,2,2,3,5,6]
Explanation: The arrays we are merging are [1,2,3] and [2,5,6].
The result of the merge is [1,2,2,3,5,6] with the underlined elements coming from nums1.
```

##### Example 2:

```
Input: nums1 = [1], m = 1, nums2 = [], n = 0
Output: [1]
Explanation: The arrays we are merging are [1] and [].
The result of the merge is [1].
```

##### Example 3:

```
Input: nums1 = [0], m = 0, nums2 = [1], n = 1
Output: [1]
Explanation: The arrays we are merging are [] and [1].
The result of the merge is [1].
Note that because m = 0, there are no elements in nums1. The 0 is only there to ensure the merge result can fit in nums1.
```

##### Constraints:


- `nums1.length == m + n`
- `nums2.length == n`
- `0 <= m, n <= 200`
- `1 <= m + n <= 200`
- <code>-10<sup>9</sup> <= nums1[i], nums2[j] <= 10<sup>9</sup></code>


Follow-up: Can you come up with an algorithm that runs in `O(m + n)` time?

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        def revrange(arr, i, j):
            while i < j:
                arr[i], arr[j] = arr[j], arr[i]
                i += 1
                j -= 1
        
        revrange(nums1, 0, m + n - 1)
        revrange(nums1, n, m + n - 1)
        i = n
        j = 0
        for k in range(m + n):
            if i < m + n and j < n:
                if nums1[i] < nums2[j]:
                    nums1[k] = nums1[i]
                    i += 1
                else:
                    nums1[k] = nums2[j]
                    j += 1
            elif i < m + n:
                nums1[k] = nums1[i]
                i += 1
            else:
                nums1[k] = nums2[j]
                j += 1
                
```

## Notes
- This is a lot of extra work just to iterate LTR in our main loop. We are better off going RTL.


## Solution 2

```
class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        k = m + n - 1
        i, j = m - 1, n - 1
        for k in range(m + n - 1, -1, -1):
            if i >= 0 and j >= 0:
                if nums1[i] > nums2[j]:
                    nums1[k] = nums1[i]
                    i -= 1
                else:
                    nums1[k] = nums2[j]
                    j -= 1
            elif i >= 0:
                nums1[k] = nums1[i]
                i -= 1
            else:
                nums1[k] = nums2[j]
                j -= 1
```

## Notes:
- If we merge the two arrays in reverse order (RTL), we avoid the extra passes necessary to reverse `nums1` and the `m` numbers in `nums1` that we need to do this LTR.