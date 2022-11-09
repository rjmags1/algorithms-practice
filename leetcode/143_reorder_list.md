# 143. Reorder List - Medium

You are given the head of a singly linked-list. The list can be represented as:

<code>
L<sub>0</sub> → L<sub>1</sub> → … → L<sub>n - 1</sub> → L<sub>n</sub>
</code>

Reorder the list to be on the following form:

<code>
L<sub>0</sub> → L<sub>n</sub> → L<sub>1</sub> → L<sub>n - 1</sub> → L<sub>2</sub> → L<sub>n - 2</sub> → …
</code>

You may not modify the values in the list's nodes. Only nodes themselves may be changed.

##### Example 1:

```
Input: head = [1,2,3,4]
Output: [1,4,2,3]
```

##### Example 2:

```
Input: head = [1,2,3,4,5]
Output: [1,5,2,4,3]
```

##### Constraints:

- The number of nodes in the list is in the range <code>[1, 5 * 10<sup>4</sup>]</code>.
- `1 <= Node.val <= 1000`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        """
        Do not return anything, modify head in-place instead.
        """
        if not head.next or not head.next.next:
            return head
        
        p1 = p2 = head
        prev = None
        while p2:
            prev = p1
            p1 = p1.next
            p2 = p2.next.next if p2.next else None
        prev.next = None
            
        tail = prev = None
        while p1:
            if p1.next is None:
                tail = p1
            temp = p1.next
            p1.next = prev
            prev, p1 = p1, temp
        
        p1 = head
        p2 = tail
        while p2:
            temp1, temp2 = p1.next, p2.next
            p1.next, p2.next = p2, temp1
            p1, p2 = temp1, temp2
            
        return head
```

## Notes
- Straightforward with a little experience with LL problems. Use fast pointer approach to get second half of list, reverse the second half, then interweave. Results in 1.5 passes of the original LL.