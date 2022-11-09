# 147. Insertion Sort List - Medium

Given the `head` of a singly linked list, sort the list using insertion sort, and return the sorted list's head.

The steps of the insertion sort algorithm:

    Insertion sort iterates, consuming one input element each repetition and growing a sorted output list.
    At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list and inserts it there.
    It repeats until no input elements remain.

The following is a graphical example of the insertion sort algorithm. The partially sorted list (black) initially contains only the first element in the list. One element (red) is removed from the input data and inserted in-place into the sorted list with each iteration.

##### Example 1:

```
Input: head = [4,2,1,3]
Output: [1,2,3,4]
```

##### Example 2:

```
Input: head = [-1,5,3,4,0]
Output: [-1,0,3,4,5]
```

##### Constraints:

- The number of nodes in the list is in the range `[1, 5000]`.
- `-5000 <= Node.val <= 5000`

## Solution

```
# Time: O(n^2)
# Space: O(1)
class Solution:
    def insertionSortList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        shead = ListNode(-inf, head)
        curr = head.next
        head.next = None
        while curr:
            nxtcurr = curr.next
            scurr, prev = shead.next, shead
            while scurr and curr.val > scurr.val:
                prev = scurr
                scurr = scurr.next
            prev.next = curr
            curr.next = scurr
            if scurr is None:
                stail = scurr
            curr = nxtcurr
        
        return shead.next
```

## Notes
- Fairly simple, we just follow the directions in the prompt. Using a sentinel node greatly simplifies edge cases where an incoming node has a value less than the value of the head of the currently sorted sublist.