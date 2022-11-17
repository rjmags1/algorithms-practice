# 2. Add Two Numbers - Medium

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number `0` itself.

 

##### Example 1:

`Input: l1 = [2,4,3], l2 = [5,6,4]`
`Output: [7,0,8]`
`Explanation: 342 + 465 = 807.`

##### Example 2:

`Input: l1 = [0], l2 = [0]`
`Output: [0]`

##### Example 3:

`Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]`
`Output: [8,9,9,9,0,0,0,1]`

 

##### Constraints:

- The number of nodes in each linked list is in the range `[1, 100]`.
- `0 <= Node.val <= 9`
- It is guaranteed that the list represents a number that does not have leading zeros.

## Solution
```
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

# Time: O(max(m, n))
# Space: O(max(m, n))
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        sentinel = ListNode()
        prev = sentinel
        carry = 0
        while l1 or l2 or carry:
            curr = ListNode()
            prev.next = curr
            digit1, digit2 = l1.val if l1 else 0, l2.val if l2 else 0
            curr.val = digit1 + digit2 + carry
            if curr.val > 9:
                curr.val -= 10
                carry = 1
            else:
                carry = 0
            
            l1, l2 = l1.next if l1 else None, l2.next if l2 else None
            prev = curr
        
        return sentinel.next
```

## Notes
- Use of `sentinel` generally useful in Linked List problems where you are generating a new LL or modifying an existing one and need to keep track of a head node that could potentially be different in the result than it was in the input.
- Don't forget to carry when `l1.val` and `l2.val` have double digit sum.
- Don't miss edge case where `l1` or `l2` are both `None` but `carry == 1`, i.e. `5 + 5 = 10`.