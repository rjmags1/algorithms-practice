# 116. Populating Next Right Pointers in Each Node - Medium

You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition:

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
Input: root = [1,2,3,4,5,6,7]
Output: [1,#,2,3,#,4,5,6,7,#]
Explanation: Given the above perfect binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 2<sup>12</sup> - 1]</code>.
- `-1000 <= Node.val <= 1000`

Follow-up:

- You may only use constant extra space.
- The recursive approach is fine. You may assume implicit stack space does not count as extra space for this problem.


## Solution 1

```
# Time: O(n)
# Space: O(log(n))
class Solution:
    def connect(self, root: 'Optional[Node]') -> 'Optional[Node]':
        def rec(curr, parent):
            if curr is None:
                return
            
            if parent and parent.left is curr:
                curr.next = parent.right
            rec(curr.left, curr)
            if parent and parent.right is curr:
                curr.next = parent.next.left if parent.next else None
            rec(curr.right, curr)
            
            return curr
        
        return rec(root, None)
```

## Notes
- We need to point `curr.next` to `parent.right` before recursing on `curr.left` so we can point `curr.left`'s right child to the appropriate "next right" node per the problem.
- Note the logarithmic space complexity, it is due to recursive call stack. We can say for sure we have logarithmic space complexity because the prompt guarantees perfect binary tree.


## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def connect(self, root: 'Optional[Node]') -> 'Optional[Node]':
        if not root:
            return root
        
        curr, lmc = root, root.left
        while lmc:
            while curr:
                curr.left.next = curr.right
                curr.right.next = curr.next.left if curr.next else None
                curr = curr.next
            curr = lmc
            lmc = curr.left
        return root
```

## Notes
- With a bit of experimentation can see that we don't need recursive call stack to keep track of parents of nodes for us. We can do this in level-order using constant space because of `next` pointers, as long as we remember the first child (leftmost child) of the next row before we traverse the current row/level.