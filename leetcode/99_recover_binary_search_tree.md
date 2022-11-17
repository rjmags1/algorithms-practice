# 99. Recover Binary Search Tree - Medium

You are given the `root` of a binary search tree (BST), where the values of exactly two nodes of the tree were swapped by mistake. Recover the tree without changing its structure.

##### Example 1:

```
Input: root = [1,3,null,null,2]
Output: [3,1,null,null,2]
Explanation: 3 cannot be a left child of 1 because 3 > 1. Swapping 1 and 3 makes the BST valid.
```

##### Example 2:

```
Input: root = [3,1,4,null,null,2]
Output: [2,1,4,null,null,3]
Explanation: 2 cannot be in the right subtree of 3 because 2 < 3. Swapping 2 and 3 makes the BST valid.
```

##### Constraints:


- The number of nodes in the tree is in the range `[2, 1000]`.
- <code>-2<sup>31</sup> <= Node.val <= 2<sup>31</sup> - 1</code>


Follow-up: A solution using `O(n)` space is pretty straight-forward. Could you devise a constant `O(1)` space solution?

## Solution 1

```
# Time: O(n)
# Space: O(n) (O(log(n)) for balanced tree)
class Solution:
    a = b = prev = None
    def recoverTree(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        def inorder(node):
            if self.a is not None:
                return 
            if node.left:
                inorder(node.left)
                
            if self.prev is None:
                self.prev = node
            elif self.a is None and self.prev.val > node.val:
                self.a = self.prev
                return
            
            self.prev = node
            if node.right:
                inorder(node.right)
            
        def revorder(node):
            if self.b is not None:
                return
            if node.right:
                revorder(node.right)
            
            if self.prev is None:
                self.prev = node
            elif self.b is None and self.prev.val < node.val:
                self.b = self.prev
                return
            
            self.prev = node
            if node.left:
                revorder(node.left)
        
        inorder(root)
        if self.a is None:
            self.a = self.prev
        self.prev = None
        
        revorder(root)
        if self.b is None:
            self.b = self.prev
        
        self.a.val, self.b.val = self.b.val, self.a.val
```

## Notes
- There will only ever be `2` out of order nodes according to the prompt. Inorder traversal of a bst will visit the nodes in ascending order by their values, reverse order traversal will visit nodes in descending order by their values. It is essentially finding two swapped nodes in a sorted list.


## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    first = second = prev = None
    def recoverTree(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        def rec(node):
            if node.left:
                rec(node.left)
                
            if self.prev and self.prev.val > node.val:
                if self.first is None:
                    self.first = self.prev
                    self.second = node
                else:
                    self.second = node
            
            self.prev = node
            if node.right:
                rec(node.right)
        
        rec(root)
        self.first.val, self.second.val = self.second.val, self.first.val
```

## Notes
- We can find two swapped elements in an otherwise sorted list in one pass by realizing that the first out of order element will be greater than the one following it (disrupting the otherwise ascending sorted order of inorder BST traversal), and the second out of order element will always be smaller than the one before it (also disrupting the sorted order). 
- This is actually trivial to notice as soon as you visualize the inorder traversal of a BST's nodes as a sorted list, however for newcomers, regardless of innate ability, it takes time to develop this kind of intuition/familiarity with data structures.
- Getting this right in the code is more subtle than it seems, because the element following the first out of order element will always be smaller than the one before it by definition. The element following the first out of order element could be the second out of order element, or it could actually be in its correct sorted position but be smaller than the element before it because the element before it is out of place. So after we find the first out of order element, we need to check if there is another element besides the one after the first out of order element that is smaller than the one before it, because if we do find one that means the element after the first out of order element is actually in its correct sorted position and the only reason it is smaller than the one before it is because the one before it was out of order itself. 
