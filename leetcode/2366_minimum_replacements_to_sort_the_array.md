# 2366. Minimum Replacements to Sort the Array - Hard

You are given a 0-indexed integer array `nums`. In one operation you can replace any element of the array with any two elements that sum to it.

- For example, consider `nums = [5,6,7]`. In one operation, we can replace `nums[1]` with `2` and `4` and convert `nums` to `[5,2,4,7]`.

Return the minimum number of operations to make an array that is sorted in non-decreasing order.

##### Example 1:

```
Input: nums = [3,9,3]
Output: 2
Explanation: Here are the steps to sort the array in non-decreasing order:
- From [3,9,3], replace the 9 with 3 and 6 so the array becomes [3,3,6,3]
- From [3,3,6,3], replace the 6 with 3 and 3 so the array becomes [3,3,3,3,3]
There are 2 steps to sort the array in non-decreasing order. Therefore, we return 2.
```

##### Example 2:

```
Input: nums = [1,2,3,4,5]
Output: 0
Explanation: The array is already in non-decreasing order. Therefore, we return 0.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>1 <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minimumReplacement(self, nums: List[int]) -> int:
        n, result = len(nums), 0
        prev = nums[-1]
        for i in reversed(range(n - 1)):
            curr = nums[i]
            if curr <= prev:
                prev = curr
                continue

            sub_elements = curr // prev
            if curr % prev > 0:
                sub_elements += 1
                prev = curr // sub_elements

            result += sub_elements - 1
        
        return result
```

## Notes
- Tricky problem, the solution is unique and math-oriented. The idea is to split any order-breaking elements such that the resulting replacements are as large as possible. In order to achieve this, we should handle the largest out of order elements first by iterating RTL. Otherwise we may end up performing more split operations than necessary. For any out of order element, there are two cases to handle: the order-breaking element is evenly divisible by the element to its right, or it is not. In the former case we simply split the out of order element into a bunch of elements equal to the element to the right. The latter case is conceptually more complicated - it will always require one more split operation than the former, and results in sub-elements whose values are dependent on the number of split operations.