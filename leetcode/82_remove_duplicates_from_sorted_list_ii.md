# 82. Remove Duplicates from Sorted List II - Medium

Given the `head` of a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list. Return the linked list sorted as well.

##### Example 1:

```
Input: head = [1,2,3,3,4,4,5]
Output: [1,2,5]
```

##### Example 2:

```
Input: head = [1,1,1,2,3]
Output: [2,3]
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
        prev = sentinel = ListNode(val=None, next=head)
        curr = head
        while curr is not None:
            if curr.next is None or curr.val != curr.next.val:
                prev, curr = curr, curr.next
                continue
            
            nxt = curr.next
            while nxt is not None and nxt.val == curr.val:
                nxt = nxt.next
            curr = prev.next = nxt
            
        return sentinel.next
```

## Notes
- Straightforward linked list problem, just need to be sure to delete all numbers for which there are duplicates, and be careful to not accidentally delete the last non-duplicate node in the LL.
- Notice how the `sentinel` node simplifies edge cases where there are multiple sets of duplicate numbers at the start of the LL.