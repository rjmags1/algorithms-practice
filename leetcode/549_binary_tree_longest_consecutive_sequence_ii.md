# 549. Binary Tree Longest Consecutive Sequence II - Medium

Given the `root` of a binary tree, return the length of the longest consecutive path in the tree.

A consecutive path is a path where the values of the consecutive nodes in the path differ by one. This path can be either increasing or decreasing.

- For example, `[1,2,3,4]` and `[4,3,2,1]` are both considered valid, but the path `[1,2,4,3]` is not valid.

On the other hand, the path can be in the child-Parent-child order, where not necessarily be parent-child order.

##### Example 1:

```
Input: root = [1,2,3]
Output: 2
Explanation: The longest consecutive path is [1, 2] or [2, 1].
```

##### Example 2:

```
Input: root = [2,1,3]
Output: 3
Explanation: The longest consecutive path is [1, 2, 3] or [3, 2, 1].
```

##### Constraints:

- The number of nodes in the tree is in the range [1, 3 * 104].
- <code>-3 * 10<sup>4</sup> <= Node.val <= 3 * 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def longestConsecutive(self, root: Optional[TreeNode]) -> int:
        result = 0
        def rec(node):
            nonlocal result
            if node is None:
                return 0, 0

            prevleftup, prevleftdown = rec(node.left)
            prevrightup, prevrightdown = rec(node.right)
            leftup = leftdown = rightup = rightdown = 1
            if node.left:
                diff = node.val - node.left.val
                if diff == 1:
                    leftup = prevleftup + 1
                elif diff == -1:
                    leftdown = prevleftdown + 1
            if node.right:
                diff = node.val - node.right.val
                if diff == 1:
                    rightup = prevrightup + 1
                elif diff == -1:
                    rightdown = prevrightdown + 1
            result = max(result, leftup, leftdown, rightup, rightdown, 
                        leftup + rightdown - 1, leftdown + rightup - 1)

            return max(leftup, rightup), max(leftdown, rightdown)

        rec(root)
        return result
```

## Notes
- This problem is the same as finding the max path length in a binary tree with the caveat that the values of nodes in the path must be increment/decrement arithmetic sequences. Paths may go straight up the tree (branches) or be rooted at a node such that the left side of the path goes up the tree to the root and then turns around and goes down the right side. So each node needs to return the max increment and max decrement branch lengths rooted at it to its parent, so the parent can return its own such information as well as determining the length of the path rooted at the parent.