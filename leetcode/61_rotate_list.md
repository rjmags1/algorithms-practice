# 61. Rotate List - Medium

Given the `head` of a linked list, rotate the list to the right by `k` places.

##### Example 1:

```
Input: head = [1,2,3,4,5], k = 2
Output: [4,5,1,2,3]
```

##### Example 2:

```
Input: head = [0,1,2], k = 4
Output: [2,0,1]
```

##### Constraints:

- The number of nodes in the list is in the range `[0, 500]`.
- `-100 <= Node.val <= 100`
- <code>0 <= k <= 2 * 10<sup>9</sup></code>

## Solution

```
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

# Time: O(n)
# Space: O(1)
class Solution:
    def rotateRight(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        if not head or not head.next or k == 0:
            return head
        
        l, curr = 0, head
        while curr:
            curr = curr.next
            l += 1
        
        k %= l
        if k == 0:
            return head
        
        p1 = p2 = head
        i = 0
        while p2.next is not None:
            p2 = p2.next
            if i >= k:
                p1 = p1.next
            i += 1
            
        newHead = p1.next
        p1.next, p2.next = None, head
        return newHead
```

## Notes
- Pretty straightforward. We have to spend a pass on finding the length of the LL because `k` is allowed to be greater than the length according to problem constraints.