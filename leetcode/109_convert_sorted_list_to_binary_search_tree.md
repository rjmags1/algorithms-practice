# 109. Convert Sorted List to Binary Search Tree - Medium

Given the `head` of a singly linked list where elements are sorted in ascending order, convert it to a height-balanced binary search tree.

## Example 1:

```
Input: head = [-10,-3,0,5,9]
Output: [0,-3,9,-10,null,5]
Explanation: One possible answer is [0,-3,9,-10,null,5], which represents the shown height balanced BST.
```

##### Example 2:

```
Input: head = []
Output: []
```

##### Constraints:


- The number of nodes in head is in the range <code>[0, 2 * 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>


## Solution 2

```
# Time: O(n * log(n))
# Space: O(n), O(log(n)) if we don't count result
class Solution:
    def sortedListToBST(self, head: Optional[ListNode]) -> Optional[TreeNode]:
        def rec(h):
            if not h:
                return None
            if not h.next:
                return TreeNode(h.val)
            
            p1, p2 = h, h.next
            prev = None
            while p2:
                prev, p1 = p1, p1.next
                p2 = p2.next.next if p2.next else None
            if prev:
                prev.next = None
            root = TreeNode(p1.val)
            root.left = rec(h)
            root.right = rec(p1.next)
            
            return root
        
        return rec(head)
```

## Notes
- This solution is an improvement on Solution 1 because we do not use any auxiliary memory to generate our result; we just take advantage of properties of LLs themselves. Main trick used here is feeler pointer.
- The key to making this work is having two base cases; the first in solution above handles the case where `p1.next` is `None` after we use a feeler pointer to find `mid` in the `while` loop. The second base case in above handles the case where there is only one node in the LL, which is necessary because without it infinitely repeated calls to `rec(h)` would get made when assigning to `root.left`.
- It is critical to unlink the left sublist that will be used to construct the left subtree for a given `root`, otherwise we would never break down the list into smaller and smaller sublists as we recursively build our binary tree.