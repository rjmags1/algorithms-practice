# 430. Flatten a Multilevel Doubly Linked List - Medium

You are given a doubly linked list, which contains nodes that have a next pointer, a previous pointer, and an additional child pointer. This child pointer may or may not point to a separate doubly linked list, also containing these special nodes. These child lists may have one or more children of their own, and so on, to produce a multilevel data structure as shown in the example below.

Given the head of the first level of the list, flatten the list so that all the nodes appear in a single-level, doubly linked list. Let `curr` be a node with a child list. The nodes in the child list should appear after `curr` and before `curr.next` in the flattened list.

Return the `head` of the flattened list. The nodes in the list must have all of their child pointers set to `null`.

##### Example 1:

![](../assets/430-mldll.jpg)

```
Input: head = [1,2,3,4,5,6,null,null,null,7,8,9,10,null,null,11,12]
Output: [1,2,3,7,8,11,12,9,10,4,5,6]
```

##### Example 2:

```
Input: head = [1,2,null,3]
Output: [1,3,2]
```

##### Example 3:

```
Input: head = []
Output: []
```

##### Constraints:

- The number of Nodes will not exceed `1000`.
- <code>1 <= Node.val <= 10<sup>5</sup></code>

## Solution

```
# Time: O(n)
# Space: O(d)
class Solution:
    def flatten(self, head: 'Optional[Node]') -> 'Optional[Node]':
        if head is None:
            return None

        def rec(head):
            curr, prev = head, None
            while curr:
                nxt = curr.next
                if curr.child:
                    childtail = rec(curr.child)
                    curr.next, curr.child.prev = curr.child, curr
                    childtail.next = nxt
                    if nxt:
                        nxt.prev = childtail
                    curr.child = None
                    prev, curr = childtail, nxt
                else:
                    prev, curr = curr, nxt
            return prev
        
        rec(head)
        return head
```

## Notes
- Could also be done iteratively with a stack; be careful about advancing the `prev` and `curr` pointers after linking a child list, and don't forget to set child pointers to `None` after visiting a node.