# 203. Remove Linked List Elements - Easy

Given the `head` of a linked list and an integer `val`, remove all the nodes of the linked list that has `Node.val == val`, and return the new head.

##### Example 1:

```
Input: head = [1,2,6,3,4,5,6], val = 6
Output: [1,2,3,4,5]
```

##### Example 2:

```
Input: head = [], val = 1
Output: []
```

##### Example 3:

```
Input: head = [7,7,7,7], val = 7
Output: []
```

##### Constraints:

- The number of nodes in the list is in the range <code>[0, 10<sup>4</sup>]</code>.
- `1 <= Node.val <= 50`
- `0 <= val <= 50`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def removeElements(self, head: Optional[ListNode], val: int) -> Optional[ListNode]:
        prev = sentinel = ListNode(None, head)
        curr = head
        while curr:
            if curr.val == val:
                prev.next = curr.next
            else:
                prev = curr
            curr = curr.next
        return sentinel.next
```

## Notes
- Sentinel node simplifies cases where `head` and consecutive nodes after if have their values equal to `val`. 
- Need to be careful about advancing `prev` - should only do so when we do not excise a node from the list.