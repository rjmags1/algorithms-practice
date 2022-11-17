# 105. Construct Binary Tree from Preorder and Inorder Traversal - Medium

Given two integer arrays `preorder` and `inorder` where `preorder` is the preorder traversal of a binary tree and `inorder` is the inorder traversal of the same tree, construct and return the binary tree.

##### Example 1:

```
Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
Output: [3,9,20,null,null,15,7]
```

##### Example 2:

```
Input: preorder = [-1], inorder = [-1]
Output: [-1]
```

##### Constraints:

- `1 <= preorder.length <= 3000`
- `inorder.length == preorder.length`
- `-3000 <= preorder[i], inorder[i] <= 3000`
- `preorder` and `inorder` consist of unique values.
- Each value of `inorder` also appears in `preorder`.
- `preorder` is guaranteed to be the preorder traversal of the tree.
- `inorder` is guaranteed to be the inorder traversal of the tree.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    p = 0
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        inorderIdxs = {}
        for i, val in enumerate(inorder):
            inorderIdxs[val] = i
            
        def rec(i, j):
            if i > j:
                return None
            
            root = TreeNode(preorder[self.p])
            self.p += 1
            rootInorderIdx = inorderIdxs[root.val]
            root.left = rec(i, rootInorderIdx - 1)
            root.right = rec(rootInorderIdx + 1, j)
            return root
        
        return rec(0, len(preorder) - 1)
```

## Notes
- This is a pretty tricky problem and requires tricky pattern recognition without having seen it before. I think it should be ranked hard. The logic behind how the tree gets built is based on the definition of `preorder`.
- `preorder[0]` will always point to `root`'s value, left child of a node if it has one will always be after that node's value in the `preorder`, nodes in the same subtree will be adjacent to each other in `inorder`, and the nodes in a `root`s left subtree will be to the left of it in `inorder`, and nodes in the right subtree will be to the right of it in `inorder`. We take advantage of these facts to build the tree top-down. 