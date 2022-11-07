# 25. Reverse Nodes in k-Group - Hard

Given the `head` of a linked list, reverse the nodes of the list `k` at a time, and return the modified list.

`k` is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of `k` then left-out nodes, in the end, should remain as it is.

You may not alter the values in the list's nodes, only nodes themselves may be changed.

##### Example 1:

```
Input: head = [1,2,3,4,5], k = 2
Output: [2,1,4,3,5]
```

##### Example 2:

```
Input: head = [1,2,3,4,5], k = 3
Output: [3,2,1,4,5]
```

##### Constraints:

- The number of nodes in the list is `n`.
- `1 <= k <= n <= 5000`
- `0 <= Node.val <= 1000`

Follow-up: Can you solve the problem in `O(1)` extra memory space?


## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        def reverse(start, stop):
            curr = newTail = start
            prev = newHead = None
            while curr is not stop:
                if curr.next is stop:
                    newHead = curr
                temp = curr.next
                curr.next = prev
                prev, curr = curr, temp
            
            return newHead, newTail
        
        p1 = sentinel = ListNode()
        sentinel.next = p2 = head
        count = 0
        while count < k:
            p2 = p2.next
            count += 1

        while count == k:
            kHead = p1.next
            newHead, newTail = reverse(kHead, p2)
            p1.next, newTail.next = newHead, p2
            p1 = newTail
            
            count = 0
            while p2 is not None and count < k:
                p2 = p2.next
                count += 1
            
        return sentinel.next
```

## Notes
- This problem is tricky to solve iteratively because it is easy to miss edge cases related to not reversing the last group if there are less than `k` nodes in it, as well as correctly splicing out k-groups and then reinserting them after reversal.
- Again, using `sentinel` in a LL problem helps us avoid complicated logic involving capturing the head of the result, which in this case is `newHead` of the first k-group.