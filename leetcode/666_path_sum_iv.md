# 666. Path Sum IV - Medium

If the depth of a tree is smaller than `5`, then this tree can be represented by an array of three-digit integers. For each integer in this array:

- The hundreds digit represents the depth `d` of this node where `1 <= d <= 4`.
- The tens digit represents the position `p` of this node in the level it belongs to where `1 <= p <= 8`. The position is the same as that in a full binary tree.
- The units digit represents the value `v` of this node where `0 <= v <= 9`.

Given an array of ascending three-digit integers `nums` representing a binary tree with a depth smaller than `5`, return the sum of all paths from the root towards the leaves.

It is guaranteed that the given array represents a valid connected binary tree.

##### Example 1:

```
Input: nums = [113,215,221]
Output: 12
Explanation: The tree that the list represents is shown.
The path sum is (3 + 5) + (3 + 1) = 12.
```

##### Example 2:

```
Input: nums = [113,221]
Output: 4
Explanation: The tree that the list represents is shown. 
The path sum is (3 + 1) = 4.
```

##### Constraints:

- `1 <= nums.length <= 15`
- `110 <= nums[i] <= 489`
- `nums` represents a valid binary tree with depth less than `5`.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def pathSum(self, nums: List[int]) -> int:
        nodes = [None] * 15
        for num in nums:
            d = num // 100 - 1
            p = ((num % 100) // 10) - 1
            nodes[(2 ** d) - 1 + p] = num % 10
        result = 0
        def rec(i, s):
            nonlocal result
            s += nodes[i]
            if i > 6:
                result += s
                return
            li, ri = i * 2 + 1, i * 2 + 2
            if nodes[li] is None and nodes[ri] is None:
                result += s
                return
            if nodes[li] is not None:
                rec(li, s)
            if nodes[ri] is not None:
                rec(ri, s)

        rec(0, 0)
        return result
```

## Notes
- Use digit values to organize node values into an array such that the values of children nodes of a particular node can be determined using index calculations similar to heap.