# 206. Reverse Linked List - Easy

Given the `head` of a singly linked list, reverse the list, and return the reversed list.

##### Example 1:

```
Input: head = [1,2,3,4,5]
Output: [5,4,3,2,1]
```

##### Example 2:

```
Input: head = [1,2]
Output: [2,1]
```

##### Example 3:

```
Input: head = []
Output: []
```

##### Constraints:

- The number of nodes in the list is the range `[0, 5000]`.
- `-5000 <= Node.val <= 5000`

Follow-up: A linked list can be reversed either iteratively or recursively. Could you implement both?

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        curr, prev = head, None
        while curr:
            temp = curr.next
            curr.next = prev
            curr, prev = temp, curr
        
        return prev
```

## Notes
- Iterative

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def reverseList(self, head: Optional[ListNode], prev=None) -> Optional[ListNode]:
        if head is None:
            return prev
        
        temp = head.next
        head.next = prev
        return self.reverseList(temp, head)
```

## Notes
- Recursive. Note the linear space due to call stack.