# 19. Remove Nth Node From End of List - Medium

Given the `head` of a linked list, remove the <code>n<sup>th</sup></code> node from the end of the list and return its head.

##### Example 1:

```
Input: head = [1,2,3,4,5], n = 2
Output: [1,2,3,5]
```

##### Example 2:

```
Input: head = [1], n = 1
Output: []
```

##### Example 3:

```
Input: head = [1,2], n = 1
Output: [1]
```

##### Constraints:

- The number of nodes in the list is `sz`. 
- `1 <= sz <= 30`
- `0 <= Node.val <= 100`
- `1 <= n <= sz`

Follow-up: Could you do it in one pass?

## Solution

```
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next

# Time: O(n)
# Space: O(n)
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        sentinel = ListNode()
        sentinel.next = head
        p1 = p2 = head
        prev = sentinel
        dist = 0
        while p2 is not None:
            p2 = p2.next
            dist += 1
            if dist > n:
                prev = p1
                p1 = p1.next
        
        prev.next = p1.next
        return sentinel.next

```

## Notes
- Sentinel node simplifies edge case where `head` is the <code>n<sup>th</sup></code> node from the end.
- Feeler pointer allows us to only traverse the full LL once.

## Solution - C++

```
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */

 // Time: O(n)
 // Space: O(1)
 // No memory leak
class Solution {
public:
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        ListNode* p1 = head;
        ListNode* p2 = nullptr;
        int distance = 0;
        while (p1 != nullptr) {
            p1 = p1->next;
            if (distance == n) {
                p2 = p2 == nullptr ? head : p2->next;
            }
            else distance++;
        }
        if (p2 == nullptr) {
            ListNode* result = head->next;
            delete head;
            return result;
        }
        ListNode* gone = p2->next;
        p2->next = p2->next->next;
        delete gone;
        return head;
    }
};
```

## Notes
- A lot of the c++ solutions on leetcode have memory leaks.