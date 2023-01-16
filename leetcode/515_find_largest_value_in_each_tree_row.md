# 515. Find Largest Value in Each Tree Row - Medium

Given the `root` of a binary tree, return an array of the largest value in each row of the tree (0-indexed).

##### Example 1:

![](../assets/515-largest_e1.jpg)

```
Input: root = [1,3,2,5,3,null,9]
Output: [1,3,9]
```

##### Example 2:

```
Input: root = [1,2,3]
Output: [1,3]
```

##### Constraints:

- The number of nodes in the tree will be in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>-2<sup>31</sup> <= Node.val <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def largestValues(self, root: Optional[TreeNode]) -> List[int]:
        if not root:
            return []

        curr, result = [root], []
        while curr:
            nxt = []
            result.append(curr[0].val)
            for node in curr:
                result[-1] = max(result[-1], node.val)
                if node.left:
                    nxt.append(node.left)
                if node.right:
                    nxt.append(node.right)
            curr = nxt
        return result
```

## Notes
- Level order traversal