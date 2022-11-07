# 83. Remove Duplicates From Sorted List - Easy

Given the `head` of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.

##### Example 1:

```
Input: head = [1,1,2]
Output: [1,2]
```

##### Example 2:

```
Input: head = [1,1,2,3,3]
Output: [1,2,3]
```

##### Constraints:


- The number of nodes in the list is in the range `[0, 300]`.
- `-100 <= Node.val <= 100`
- The list is guaranteed to be sorted in ascending order.


## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:
        curr = head
        while curr is not None:
            if curr.next is None or curr.val != curr.next.val:
                curr = curr.next
                continue
            
            nxt = curr.next
            while nxt is not None and curr.val == nxt.val:
                nxt = nxt.next
            curr.next = nxt
            curr = nxt
        
        return head
```

## Notes
- Much easier than 82. since we only need to delete the duplicates, not all nodes for which there are duplicates.