# 24. Swap Nodes in Pairs - Medium

Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)

##### Example 1:

```
Input: head = [1,2,3,4]
Output: [2,1,4,3]
```

##### Example 2:

```
Input: head = []
Output: []
```

##### Example 3:

```
Input: head = [1]
Output: [1]
```

##### Constraints:

- The number of nodes in the list is in the range `[0, 100]`.
- `0 <= Node.val <= 100`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def swapPairs(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head is None or head.next is None:
            return head
        
        p1, p2 = head, head.next
        prev = sentinel = ListNode()
        while p2:
            nxt = p2.next if p2 else None
            prev.next, p1.next, p2.next = p2, nxt, p1
            prev, p1, p2 = p1, nxt, nxt.next if nxt else None
        
        return sentinel.next
```

## Notes
- Go pair by pair through the LL, swapping the pair order.
- Be careful about advancing pointers after swapping `p1` and `p2`.

## Solution - C++

```
class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return head;
        }

        ListNode* left = head;
        ListNode* curr = head->next;
        ListNode* result = curr;
        while (curr != nullptr) {
            if (curr->next == nullptr) {
                curr->next = left;
                left->next = nullptr;
                return result;
            }
            ListNode* right = curr->next;
            curr->next = left;
            if (right->next != nullptr) {
                left->next = right->next;
            }
            else {
                left->next = right;
            }
            left = right;
            curr = right->next;
        }

        return result;
    }
};
```