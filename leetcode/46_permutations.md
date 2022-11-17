# 46. Permutations

Given an array `nums` of distinct integers, return all the possible permutations. You can return the answer in any order.

##### Example 1:

```
Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
```

##### Example 2:

```
Input: nums = [0,1]
Output: [[0,1],[1,0]]
```

##### Example 3:

```
Input: nums = [1]
Output: [[1]]
```

##### Constraints:

- `1 <= nums.length <= 6`
- `-10 <= nums[i] <= 10`
- All the integers of `nums` are unique.

## Solution

```
# Time: O(n! * n)
# Space: O(n! * n)
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        n = len(nums)
        result = []
        def buildPerms(i):
            if i == n:
                result.append(nums[:])
                return
            
            for j in range(i, n):
                nums[i], nums[j] = nums[j], nums[i]
                buildPerms(i + 1)
                nums[i], nums[j] = nums[j], nums[i]
        
        buildPerms(0)
        return result
```

## Notes
- The solution to this problem is obvious if you have decent exposure to recursion and draw out all possible permutations in a short example. It becomes clear from the example that index `0` can be occupied by any of the `n` elements, index `1` can be occupied by any elements not used for index `0`, and so forth. This is the definition of permutation, and is where the factorial portion of the time complexity comes from.
- We save a lot of space and time in this implementation by swapping, recursing, and then unswapping back to the previous configuration, and only building new arrays when we have built a full permutation by swapping. This is much more efficient than building a new array in each recursive call, which more naive solutions tend to do. 