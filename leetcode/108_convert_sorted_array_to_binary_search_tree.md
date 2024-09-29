# 108. Convert Sorted Array to Binary Search Tree - Easy

Given an integer array `nums` where the elements are sorted in ascending order, convert it to a height-balanced binary search tree.

##### Example 1:

```
Input: nums = [-10,-3,0,5,9]
Output: [0,-3,9,-10,null,5]
Explanation: [0,-10,5,null,-3,null,9] is also accepted.
```

##### Example 2:

```
Input: nums = [1,3]
Output: [3,1]
Explanation: [1,null,3] and [3,1] are both height-balanced BSTs.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>
- `nums` is sorted in a strictly increasing order.


## Solution 1

```
# Time: O(n)
# Space: O(n), O(log(n)) if we don't count result space
class Solution:
    def sortedArrayToBST(self, nums: List[int]) -> Optional[TreeNode]:
        def rec(i, j):
            if i > j:
                return None
            
            mid = (i + j) // 2
            root = TreeNode(nums[mid])
            root.left = rec(i, mid - 1)
            root.right = rec(mid + 1, j)
            return root
        
        return rec(0, len(nums) - 1)
```

## Notes
- Recursive. Always use `mid` to ensure result is height-balanced - distributes nodes evenly about root and all subroots.