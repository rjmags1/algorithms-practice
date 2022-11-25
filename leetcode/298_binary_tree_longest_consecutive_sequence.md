# 298. Binary Tree Longest Consecutive Sequence - Medium

Given the `root` of a binary tree, return the length of the longest consecutive sequence path.

A consecutive sequence path is a path where the values increase by one along the path.

Note that the path can start at any node in the tree, and you cannot go from a node to its parent in the path.

##### Example 1:

```
Input: root = [1,null,3,2,4,null,null,null,5]
Output: 3
Explanation: Longest consecutive sequence path is 3-4-5, so return 3.
```

##### Example 2:

```
Input: root = [2,null,3,2,null,1]
Output: 2
Explanation: Longest consecutive sequence path is 2-3, not 3-2-1, so return 2.
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 3 * 10<sup>4</sup>]</code>.
- <code>-3 * 10<sup>4</sup> <= Node.val <= 3 * 10<sup>4</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(h)
class Solution:
    def longestConsecutive(self, root: Optional[TreeNode]) -> int:
        result = 0
        def rec(node, prev, pathlen):
            if node is None:
                return
            
            if node.val == prev + 1:
                nonlocal result
                pathlen += 1
                result = max(result, pathlen)
            else:
                pathlen = 1
                
            rec(node.left, node.val, pathlen)
            rec(node.right, node.val, pathlen)
        
        rec(root, root.val - 1, 0)
        return result
```

## Notes
- Recursive dfs

## Solution 2

```
# Time: O(n)
# Space: O(h)
class Solution:
    def longestConsecutive(self, root: Optional[TreeNode]) -> int:
        result = 0
        stack = [(root, root.val - 1, 0)]
        while stack:
            curr, prevval, prevlen = stack.pop()
            if curr is None:
                continue
                
            pathlen = prevlen + 1 if curr.val == prevval + 1 else 1
            result = max(result, pathlen)
            stack.append((curr.left, curr.val, pathlen))
            stack.append((curr.right, curr.val, pathlen))
            
        return result
```

## Notes
- Iterative dfs/preorder traversal. Note this problem could also be solved with a level order traversal/bfs.