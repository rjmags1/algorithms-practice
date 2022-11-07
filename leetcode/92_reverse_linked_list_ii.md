# 92. Reverse Linked List II - Medium

Given the `head` of a singly linked list and two integers `left` and `right` where `left <= right`, reverse the nodes of the list from position `left` to position `right`, and return the reversed list.

##### Example 1:

```
Input: head = [1,2,3,4,5], left = 2, right = 4
Output: [1,4,3,2,5]
```

##### Example 2:

```
Input: head = [5], left = 1, right = 1
Output: [5]
```

##### Constraints:


- The number of nodes in the list is `n`.
- `1 <= n <= 500`
- `-500 <= Node.val <= 500`
- `1 <= left <= right <= n`


Follow-up: Could you do it in one pass?

## Solution

```
# Time: O(n) (one pass)
# Space: O(1)
class Solution:
    def reverseBetween(self, head: Optional[ListNode], left: int, right: int) -> Optional[ListNode]:
        if left == right or head.next is None:
            return head
        
        curr = sentinel = ListNode()
        i, sentinel.next = 0, head
        lprev = l = r = prev = None
        while i <= right:
            if i == left - 1:
                lprev = curr
                l = curr.next
            if i == right:
                r = curr.next
                
            if i > left:
                temp = curr.next
                curr.next = prev
                prev, curr = curr, temp
            else:
                prev, curr = curr, curr.next
            i += 1
                
        lprev.next, l.next = prev, r
        return sentinel.next
```

## Notes
- Fairly straightforward to do this one pass, though much simpler to do it in two. For the one-pass approach above just need to keep track of all the relevant nodes in order to flip the reversed sublist once we exit the main iteration.