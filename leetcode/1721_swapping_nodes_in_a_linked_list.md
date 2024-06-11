# 1721. Swapping Nodes in a Linked List

You are given the `head` of a linked list, and an integer `k`.

Return the head of the linked list after swapping the values of the `k`th node from the beginning and the `k`th node from the end (the list is 1-indexed).

##### Example 1:

```
Input: head = [1,2,3,4,5], k = 2
Output: [1,4,3,2,5]
```

##### Example 2:

```
Input: head = [1,2,3,4,5], k = 2
Output: [1,4,3,2,5]
```

##### Constraints:

- The number of nodes in the list is `n`.
- <code>1 <= k <= n <= 10<sup>5</sup></code>
- `0 <= Node.val <= 100`

Follow-up: 

## Solution

```
// Time: O(n)
// Space: O(1)
class Solution {
public:
    ListNode* swapNodes(ListNode* head, int k) {
        if (head->next == nullptr) return head;

        ListNode* p1 = head;
        ListNode* p2 = head;
        ListNode* p3 = head;
        int i = 1;
        while (p1 != nullptr) {
            if (i < k) {
                p3 = p3->next;
            }
            if (i > k) {
                p2 = p2->next;
            }
            p1 = p1->next;
            i++;
        }

        int a = p3->val;
        int b = p2->val;
        p2->val = a;
        p3->val = b;

        return head;
    }
};
```

## Notes
- More complicated if need to swap pointers and cannot just swap values.