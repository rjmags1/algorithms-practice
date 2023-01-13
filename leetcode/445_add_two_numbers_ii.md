# 445. Add Two Numbers II - Medium

You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

##### Example 1:

```
Input: l1 = [7,2,4,3], l2 = [5,6,4]
Output: [7,8,0,7]
```

##### Example 2:

```
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [8,0,7]
```

##### Example 3:

```
Input: l1 = [0], l2 = [0]
Output: [0]
```

##### Constraints:

- The number of nodes in each linked list is in the range `[1, 100]`.
- `0 <= Node.val <= 9`
- It is guaranteed that the list represents a number that does not have leading zeros.

Follow-up: Could you solve it without reversing the input lists?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        n1 = n2 = 0
        curr1, curr2 = l1, l2
        while curr1 or curr2:
            if curr1:
                n1 += 1
                curr1 = curr1.next
            if curr2:
                n2 += 1
                curr2 = curr2.next
        diff = abs(n1 - n2)
        if n1 < n2:
            l1, l2 = l2, l1
        
        result, dist = ListNode(0), 0
        prev = result
        while l1 and l2:
            new = ListNode(l1.val)
            l1 = l1.next
            if dist >= diff:
                new.val += l2.val
                l2 = l2.next
            dist += 1
            new.next = prev
            prev = new
        curr, prev = prev, None
        while curr:
            if curr.val > 9:
                curr.next.val += 1
                curr.val -= 10
            nxt = curr.next
            curr.next = prev
            curr, prev = nxt, curr
        return result.next if result.val == 0 else result
```

## Notes
- To avoid reversing the inputs, we want to postpone performing carry operations until we have performed all digit wise addition; as we do digit addition we add the new node to the result linked list such that the result linked list is reversed after digit wise additions are completed. This allows us to perform carry operations and unreverse the result linked list at the same time. If we hadn't added new nodes to the result in reverse order, we would not be able to perform carries without reversing the inputs.