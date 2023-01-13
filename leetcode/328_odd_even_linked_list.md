# 328. Odd Even Linked List - Medium

Given the `head` of a singly linked list, group all the nodes with odd indices together followed by the nodes with even indices, and return the reordered list.

The first node is considered odd, and the second node is even, and so on.

Note that the relative order inside both the even and odd groups should remain as it was in the input.

You must solve the problem in `O(1)` extra space complexity and `O(n)` time complexity.

##### Example 1:

```
Input: head = [1,2,3,4,5]
Output: [1,3,5,2,4]
```

##### Example 2:

```
Input: head = [2,1,3,5,6,4,7]
Output: [2,3,6,7,1,5,4]
```

##### Constraints:

- The number of nodes in the linked list is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>-10<sup>6</sup> <= Node.val <= 10<sup>6</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def oddEvenList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head is None:
            return head
        
        sentinel, curr, prev = ListNode(), head.next, head
        k = sentinel
        while curr:
            temp = curr.next
            curr.next = None
            k.next = curr
            k = curr
            
            prev.next = temp
            prev = prev.next if prev.next else prev
            curr = temp.next if temp else None
        prev.next = sentinel.next
        return head
```

## Notes
- Put all even nodes into their own separate list for attachment after full main list traversal. Edge cases to watch out for: not advancing `prev` (AKA tail at end of main traversal) to `None` for even length lists in last iteration, and null reference error for `curr.next.next`.