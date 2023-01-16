# 510. Inorder Successor in BST II - Medium

Given a `node` in a binary search tree, return the in-order successor of that node in the BST. If that node has no in-order successor, return `null`.

The successor of a `node` is the node with the smallest key greater than `node.val`.

You will have direct access to the node but not to the root of the tree. Each node will have a reference to its parent node. Below is the definition for `Node`:

```
class Node {
    public int val;
    public Node left;
    public Node right;
    public Node parent;
}
```

##### Example 1:

![](../assets/510-tree-1.png)

```
Input: tree = [2,1,3], node = 1
Output: 2
Explanation: 1's in-order successor node is 2. Note that both the node and the return value is of Node type.
```

##### Example 2:

![](../assets/510-tree-2.png)

```
Input: tree = [5,3,6,2,4,null,null,1], node = 6
Output: null
Explanation: There is no in-order successor of the current node, so the answer is null.
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>
- All `Nodes` will have unique values.

Follow-up: Could you solve it without looking up any of the node's values?

## Solution

```
# Time: O(h)
# Space: O(1)
class Solution:
    def inorderSuccessor(self, node: 'Node') -> 'Optional[Node]':
        # leftmost in rst if rst else first ancestor to right
        result = None
        if node.right:
            result = node.right
            while result.left:
                result = result.left
        else:
            curr = node
            while curr and result is None:
                if curr.parent and curr.parent.left is curr:
                    result = curr.parent
                curr = curr.parent
        return result
```

## Notes
- Successor of any node in a BST is the leftmost child in the right subtree of a node if it has a right subtree, otherwise it is lowest ancestor of the node for which the node lies in the ancestors left subtree.