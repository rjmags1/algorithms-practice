# 611. Valid Triangle Number - Medium

Given an integer array `nums`, return the number of triplets chosen from the array that can make triangles if we take them as side lengths of a triangle.

##### Example 1:

```
Input: nums = [2,2,3,4]
Output: 3
Explanation: Valid combinations are: 
2,3,4 (using the first 2)
2,3,4 (using the second 2)
2,2,3
```

##### Example 2:

```
Input: nums = [4,2,3,4]
Output: 4
```

##### Constraints:

- `1 <= nums.length <= 1000`
- `0 <= nums[i] <= 1000`

## Solution

```
# Time: O(n^2)
# Space: O(n) for sorting (timsort)
class Solution:
    def triangleNumber(self, nums: List[int]) -> int:
        nums = sorted(nums)
        result, n = 0, len(nums)
        for i in range(n - 2):
            j = i + 1
            for k in range(i + 2, n):
                while j < k and nums[i] + nums[j] <= nums[k]:
                    j += 1
                result += k - j
        return result
```

## Notes
- Instead of enumerating all triplet permutations, which results in a TLE for this question, we can make use of the idea that we only need to compare the largest number against the sum of the two smaller numbers in a triplet combination to determine if the triplet can form a triangle. If we sort and fix the smallest side for a particular triplet, we can find the number of compatible pairs in linear time for each smallest side by asking, for each largest side, how many sides combined with the smallest side are greater than the largest side? 