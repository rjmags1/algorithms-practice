# 369. Plus One Linked List - Medium

Given a non-negative integer represented as a linked list of digits, plus one to the integer.

The digits are stored such that the most significant digit is at the `head` of the list.

##### Example 1:

```
Input: head = [1,2,3]
Output: [1,2,4]
```

##### Example 2:

```
Input: head = [0]
Output: [1]
```

##### Constraints:

- The number of nodes in the linked list is in the range `[1, 100]`.
- `0 <= Node.val <= 9`
- The number represented by the linked list does not contain leading zeros except for the zero itself. 

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def plusOne(self, head: ListNode) -> ListNode:
        stack, curr = [], head
        while curr.next:
            stack.append(curr)
            curr = curr.next
        curr.val += 1
        while stack and curr.val == 10:
            curr.val = 0
            curr = stack.pop()
            curr.val += 1
        if head.val == 10:
            head.val = 0
            new = ListNode(1)
            new.next = head
            head = new
        return head
```

## Notes
- Iterative stack based solution.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def plusOne(self, head: ListNode) -> ListNode:
        prev, curr = None, head
        while curr:
            temp = curr.next
            curr.next = prev
            prev, curr = curr, temp

        curr = prev
        prev = None
        curr.val += 1
        while curr:
            if curr.val == 10:
                curr.val = 0
                if curr.next:
                    curr.next.val += 1
            temp = curr.next
            curr.next = prev
            curr, prev = temp, curr

        return head if head.val != 0 else ListNode(1, head)
```

## Notes
- Constant space via list reversal and subsequent unreversal.