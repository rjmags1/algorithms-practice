# 234. Palindrome Linked List - Easy

Given the `head` of a singly linked list, return `true` if it is a palindrome or `false` otherwise.

##### Example 1:

```
Input: head = [1,2,2,1]
Output: true
```

##### Example 2:

```
Input: head = [1,2]
Output: false
```

##### Constraints:

- The number of nodes in the list is in the range <code>[1, 10<sup>5</sup>]</code>.
- `0 <= Node.val <= 9`

Follow-up: Could you do it in `O(n)` time and `O(1)` space?

## Solution

```
# Time: O(n) (single pass)
# Space: O(1)
class Solution:
    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        if not head or not head.next:
            return True
        
        p1 = p2 = head
        prev = None
        odd = False
        while p2:
            if p2.next is None:
                odd = True
            p2 = p2.next.next if p2.next else None
            temp = p1.next
            p1.next = prev
            prev, p1 = p1, temp
        
        p2 = prev if not odd else prev.next
        while p1 and p2:
            if p1.val != p2.val:
                return False
            p1, p2 = p1.next, p2.next
        return p1 is None and p2 is None
```

## Notes
- Navigate to the center of the list with a fast pointer and record whether there are an odd number of nodes in the list based on if the fast pointer lands on the last node of the list or not. While navigating to the center of the list, reverse the first half of the list with the slow pointer. Now we can do a simple inside-out check palindrome check.