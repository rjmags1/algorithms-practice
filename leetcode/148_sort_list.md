# 148. Sort List - Medium

Given the `head` of a linked list, return the list after sorting it in ascending order.

##### Example 1:

```
Input: head = [4,2,1,3]
Output: [1,2,3,4]
```

##### Example 2:

```
Input: head = [4,2,1,3]
Output: [1,2,3,4]
```

##### Example 3:

```
Input: head = []
Output: []
```

##### Constraints:

- The number of nodes in the list is in the range <code>[0, 5 * 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>

Follow-up: Can you sort the linked list in `O(nlog(n))` time and `O(1)` memory (i.e. constant space)?

## Solution

```
# Time: O(n * log(n))
# Space: O(1)
class Solution:
    def length(self, l):
        result = 0
        while l:
            result += 1
            l = l.next
        return result
    
    def mergeTwoSortedLLs(self, h1, h2):
        curr = sentinel = ListNode()
        p1, p2 = h1, h2
        while p1 or p2:
            if p1 and p2:
                if p1.val < p2.val:
                    curr.next = p1
                    p1 = p1.next
                else:
                    curr.next = p2
                    p2 = p2.next
            elif p2:
                curr.next = p2
                if not p2.next:
                    tail = p2
                p2 = p2.next
            else:
                curr.next = p1
                if not p1.next:
                    tail = p1
                p1 = p1.next
            curr = curr.next
        
        return sentinel.next, tail
        
    def sortList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head or not head.next:
            return head
        
        l = self.length(head)
        sentinel = ListNode(None, head)
        size = 1
        while size < l:
            prev1, curr = sentinel, sentinel.next
            while curr:
                s, h1 = 1, curr
                prev2 = None
                while curr and s <= size:
                    if s == size:
                        prev2 = curr
                        break
                    curr = curr.next
                    s += 1
                if not curr or not curr.next:
                    break
                
                s, h2 = 1, curr.next
                curr = h2
                while curr and s < size:
                    s += 1
                    curr = curr.next
                
                # unlink
                nxtcurr = curr.next if curr else None
                if curr:
                    curr.next = None
                prev1.next = prev2.next = None
                # merge
                h, t = self.mergeTwoSortedLLs(h1, h2)
                # relink
                prev1.next, t.next = h, nxtcurr
                # advance
                prev1, curr = t, nxtcurr
            
            size *= 2
            
        return sentinel.next
```

## Notes
- We use a divide and conquer approach similar to 23. Merge K Sorted Lists, aka iterative merge sort. There are some optimizations that could be done to this solution to reduce the number of passes, particularly in the `mergeTwoSortedLLs` function, but it still works. Could also use a fast pointer technique to get the end of `prev2`, but this is a bit of a monster solution for a medium level question so not going to optimize further.