# 450. Delete Node in a BST - Medium

Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.

Basically, the deletion can be divided into two stages:

- Search for a node to remove.
- If the node is found, delete the node.

##### Example 1:

```
Input: root = [5,3,6,2,4,null,7], key = 3
Output: [5,4,6,2,null,null,7]
Explanation: Given key to delete is 3. So we find the node with value 3 and delete it.
One valid answer is [5,4,6,2,null,null,7], shown in the above BST.
Please notice that another valid answer is [5,2,6,null,4,null,7] and it's also accepted.
```

##### Example 2:

```
Input: root = [5,3,6,2,4,null,7], key = 0
Output: [5,3,6,2,4,null,7]
Explanation: The tree does not contain a node with value = 0.
```

##### Example 3:

```
Input: root = [], key = 0
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- Each node has a unique value.
- `root` is a valid binary search tree.
- <code>-10<sup>5</sup> <= key <= 10<sup>5</sup></code>
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>

Follow-up: Could you solve it with time complexity `O(height of tree)`?

## Solution

```
# Time: O(h)
# Space: O(1)
class Solution:
    def deleteNode(self, root: Optional[TreeNode], key: int) -> Optional[TreeNode]:
        def find():
            parent, curr = None, root
            while curr:
                if curr.val == key:
                    return parent, curr
                parent = curr
                if key < curr.val:
                    curr = curr.left
                else:
                    curr = curr.right
            return None, None
        
        def getsuccessor(node):
            successor, parent = node.right, node
            if not successor.left:
                parent.right = successor.right
                successor.right = None
                return successor

            while successor.left:
                parent = successor
                successor = successor.left
            parent.left = successor.right
            successor.right = None
            return successor
        
        dparent, d = find()
        result = root
        if not d:
            return result

        if dparent is None: #root
            if root.left and root.right:
                result = getsuccessor(root)
                result.left, result.right = root.left, root.right
            elif root.left:
                result = root.left
            elif root.right:
                result = root.right
            else:
                result = None
            root.left = root.right = None
        elif d.left is None and d.right is None: # leaf
            if dparent.left is d:
                dparent.left = None
            else:
                dparent.right = None
        else: # nonroot, nonleaf
            leftchild = dparent.left is d
            if d.right:
                s = getsuccessor(d)
                if leftchild:
                    dparent.left = s
                else:
                    dparent.right = s
                s.left, s.right = d.left, d.right
            else:
                if leftchild:
                    dparent.left = d.left
                else:
                    dparent.right = d.left
            d.left = d.right = None

        return result
```

## Notes
- There are a number of cases to handle if we want to delete the node in `O(height)` time. The most complicated is the case where the node has a left and right child, in which case we need to find the successor of the node to be deleted in the right child subtree, correctly splice out the successor and insert it into the position of the deleted node. To correctly insert the successor node we need to keep track of if the deleted node is a left or right child. The cases where the node to be deleted is a leaf or has one child is trivial but still depends on if the node to be deleted is a left child or right child, and we need to be sure to correctly handle the case where the original root of the tree is the node to be deleted.