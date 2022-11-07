# 86. Partition List - Medium

Given the `head` of a linked list and a value `x`, partition it such that all nodes less than `x` come before nodes greater than or equal to `x`.

You should preserve the original relative order of the nodes in each of the two partitions.

##### Example 1:

```
Input: head = [1,4,3,2,5,2], x = 3
Output: [1,2,2,4,3,5]
```

##### Example 2:

```
Input: head = [2,1], x = 2
Output: [1,2]
```

##### Constraints:

- The number of nodes in the list is in the range `[0, 200]`.
- `-100 <= Node.val <= 100`
- `-200 <= x <= 200`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def partition(self, head: Optional[ListNode], x: int) -> Optional[ListNode]:
        sentinel1, sentinel2 = ListNode(), ListNode()
        curr, p1, p2 = head, sentinel1, sentinel2
        while curr is not None:
            if curr.val < x:
                p1.next = curr
                curr = curr.next
                p1 = p1.next
                p1.next = None
            else:
                p2.next = curr
                curr = curr.next
                p2 = p2.next
                p2.next = None
                
        p1.next = sentinel2.next
        return sentinel1.next
```

## Notes
- Use sentinel nodes to build a list of nodes with values `< x` and another with values `>= x`, then link them together after we have visited all nodes in the LL LTR.