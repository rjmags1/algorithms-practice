# 117. Populating Next Right Pointers in Each Node II - Medium

Given a binary tree

```
struct Node {
  int val;
  Node *left;
  Node *right;
  Node *next;
}
```

Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to `NULL`.

Initially, all next pointers are set to `NULL`.

##### Example 1:

```
Input: root = [1,2,3,4,5,null,7]
Output: [1,#,2,3,#,4,5,7,#]
Explanation: Given the above binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 6000]`.
- `-100 <= Node.val <= 100`

Follow-up:
- You may only use constant extra space.
- The recursive approach is fine. You may assume implicit stack space does not count as extra space for this problem.


## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def connect(self, root: 'Node') -> 'Node':
        if not root:
            return root
        
        curr, lmc = root, root.left if root.left else root.right
        while lmc:
            prev = nextlmc = None
            while curr:
                if not nextlmc:
                    nextlmc = curr.left if curr.left else curr.right
                    
                if curr.left and curr.right:
                    if prev:
                        prev.next = curr.left
                    curr.left.next = curr.right
                    prev = curr.right
                elif curr.left:
                    if prev:
                        prev.next = curr.left
                    prev = curr.left
                elif curr.right:
                    if prev:
                        prev.next = curr.right
                    prev = curr.right
                curr = curr.next
                
            curr, lmc = lmc, nextlmc
            
        return root
```

## Notes
- This is the same logic as the constant space solution for 116. Populating Next Right Pointers in Each Node except the logic for linking `next` pointers is more complicated because there can be gaps in levels since we are not guaranteed a perfect binary tree in our input. To address this we need to be more explicit about how we capture the leftmost child of the next row (it is not guaranteed to be the left child of the first node in the current row), and we need address the three possible gap cases as we iterate from left to right with `curr` and link children's `next` pointers using a `prev` pointer: there are no gaps (`curr.left` and `curr.right` are both `not None`), there is one gap here (`curr.left` or `curr.right` is `None`), or there are two gaps here (`curr.left` and `curr.right` are both None).