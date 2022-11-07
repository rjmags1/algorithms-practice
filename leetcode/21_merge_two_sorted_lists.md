# 21. Merge Two Sorted Lists - Easy

You are given the heads of two sorted linked lists `list1` and `list2`.

Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.

##### Example 1:

```
Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]
```

##### Example 2:

```
Input: list1 = [], list2 = []
Output: []
```

##### Example 3:

```
Input: list1 = [], list2 = [0]
Output: [0]
```

##### Constraints:

- The number of nodes in both lists is in the range `[0, 50]`.
- `-100 <= Node.val <= 100`
- Both `list1` and `list2` are sorted in non-decreasing order.

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
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        sentinel = ListNode()
        curr = sentinel
        p1, p2 = list1, list2
        while p1 and p2:
            if p1.val < p2.val:
                curr.next = p1
                p1 = p1.next
            else:
                curr.next = p2
                p2 = p2.next
            curr = curr.next
            curr.next = None
        
        if p1 is not None:
            curr.next = p1
        if p2 is not None:
            curr.next = p2
        
        return sentinel.next
```

## Notes
- Sentinel simplifies edge cases where `list1` and `list2` heads have same value.