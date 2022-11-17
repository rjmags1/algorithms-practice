# 106. Construct Binary Tree from Inorder and Postorder Traversal - Medium

Given two integer arrays `inorder` and `postorder` where `inorder` is the inorder traversal of a binary tree and `postorder` is the postorder traversal of the same tree, construct and return the binary tree.

##### Example 1:

```
Input: inorder = [9,3,15,20,7], postorder = [9,15,7,20,3]
Output: [3,9,20,null,null,15,7]
```

##### Example 2:

```
Input: inorder = [-1], postorder = [-1]
Output: [-1]
```

##### Constraints:

- `1 <= inorder.length <= 3000`
- `postorder.length == inorder.length`
- `-3000 <= inorder[i], postorder[i] <= 3000`
- `inorder` and `postorder` consist of unique values.
- Each value of `postorder` also appears in `inorder`.
- `inorder` is guaranteed to be the inorder traversal of the tree.
- `postorder` is guaranteed to be the postorder traversal of the tree.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def buildTree(self, inorder: List[int], postorder: List[int]) -> Optional[TreeNode]:
        inorderIdxs = {v: i for i, v in enumerate(inorder)}
        p = len(postorder) - 1
        def rec(i, j):
            nonlocal p
            if i > j:
                return None
            
            root = TreeNode(postorder[p])
            p -= 1
            rootInorderIdx = inorderIdxs[root.val]
            root.right = rec(rootInorderIdx + 1, j)
            root.left = rec(i, rootInorderIdx - 1)
            
            return root
        
        return rec(0, p)
```

## Notes
- This should be a hard level problem as well because of the non-intuitive pattern used to solve the problem; it is not obvious at all the only thing useful about `inorder` is determining the size of left and right subtrees. The logic behind how the tree gets built is based on the definition of `postorder`.
- This is a reflection of 105. Construct Binary Tree from Inorder and Preorder; the logic is the exact same, except in `postorder` the root of our result always has its value at the last index. Additionally, the right child of a given node (if it has one) will always have its value at the index before the root in `postorder`.