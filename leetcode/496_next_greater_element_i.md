# 496. Next Greater Element I - Easy

The next greater element of some element `x` in an array is the first greater element that is to the right of `x` in the same array.

You are given two distinct 0-indexed integer arrays `nums1` and `nums2`, where `nums1` is a subset of `nums2`.

For each `0 <= i < nums1.length`, find the index `j` such that `nums1[i] == nums2[j]` and determine the next greater element of `nums2[j]` in `nums2`. If there is no next greater element, then the answer for this query is `-1`.

Return an array `ans` of length `nums1.length` such that `ans[i]` is the next greater element as described above.

##### Example 1:

```
Input: nums1 = [4,1,2], nums2 = [1,3,4,2]
Output: [-1,3,-1]
Explanation: The next greater element for each value of nums1 is as follows:
- 4 is underlined in nums2 = [1,3,4,2]. There is no next greater element, so the answer is -1.
- 1 is underlined in nums2 = [1,3,4,2]. The next greater element is 3.
- 2 is underlined in nums2 = [1,3,4,2]. There is no next greater element, so the answer is -1.
```

##### Example 2:

```
Input: nums1 = [2,4], nums2 = [1,2,3,4]
Output: [3,-1]
Explanation: The next greater element for each value of nums1 is as follows:
- 2 is underlined in nums2 = [1,2,3,4]. The next greater element is 3.
- 4 is underlined in nums2 = [1,2,3,4]. There is no next greater element, so the answer is -1.
```

##### Constraints:

- <code>1 <= nums1.length <= nums2.length <= 1000</code>
- <code>0 <= nums1[i], nums2[i] <= 10<sup>4</sup></code>
- All integers in `nums1` and `nums2` are unique.
- All the integers of `nums1` also appear in `nums2`.

Follow-up: Could you find an `O(nums1.length + nums2.length)` solution?

## Solution

```
# Time: O(max(m, n))
# Space: O(n)
class Solution:
    def nextGreaterElement(self, nums1: List[int], nums2: List[int]) -> List[int]:
        n1, n2 = len(nums1), len(nums2)
        idxs, dp, stack = {}, [-1] * n2, []
        for i, num in enumerate(nums2):
            idxs[num] = i
            while stack and nums2[stack[-1]] < num:
                dp[stack.pop()] = num
            stack.append(i)
        
        return [dp[idxs[num]] for num in nums1]
```

## Notes
- Stack of numbers in `nums2` for which we have not yet identified a next greater element. Find all next greater elements for all `j` in `nums2` with the stack, store in `dp`, and then use `dp` to construct the final result using `nums1`. To do the last step of building answer from `dp` in linear time, we need to be able to lookup the indices of each number in `nums2` in constant time so we can lookup elements of `nums1` and access the relevant value in `dp`.