# 23. Merge k Sorted Lists - Hard

You are given an array of `k` linked-lists `lists`, each linked-list is sorted in ascending order.

Merge all the linked-lists into one sorted linked-list and return it.

##### Example 1:

```
Input: lists = [[1,4,5],[1,3,4],[2,6]]
Output: [1,1,2,3,4,4,5,6]
Explanation: The linked-lists are:
[
  1->4->5,
  1->3->4,
  2->6
]
merging them into one sorted list:
1->1->2->3->4->4->5->6
```

##### Example 2:

```
Input: lists = []
Output: []
```

##### Example 3:

```
Input: lists = [[]]
Output: []
```

##### Constraints:

- `k == lists.length`
- <code>0 <= k <= 10<sup>4</sup></code>
- `0 <= lists[i].length <= 500`
- <code>-10<sup>4</sup> <= lists[i][j] <= 10<sup>4</sup></code>
- `lists[i]` is sorted in ascending order.
- The sum of `lists[i].length` will not exceed <code>10<sup>4</sup></code>.

## Solution 1

```
# Time: O(nlog(k))
# Space: O(k)
class Solution:
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        h = []
        for i, ll in enumerate(lists):
            if ll is not None:
                heapq.heappush(h, (ll.val, i, ll))
        
        curr = sentinel = ListNode()
        while h:
            _, idx, node = heapq.heappop(h)
            curr.next = node
            curr = curr.next
            if node.next:
                heapq.heappush(h, (node.next.val, idx, node.next))
        
        return sentinel.next
```

## Notes
- Sentinel node makes another appearance in a LL problem.
- Python does not compare memory addresses or anything of that sort for objects (LL nodes for this problems), so we use indices of LLs in `lists` to tie-break heap tuples with equivalent node values.

## Solution 2

```
# Time: O(nlog(k))
# Space: O(1)
class Solution:
    def mergeKLists(self, lists: List[Optional[ListNode]]) -> Optional[ListNode]:
        def mergeTwo(l, r):
            curr = sentinel = ListNode()
            while l and r:
                if l.val < r.val:
                    curr.next = l
                    l = l.next
                else:
                    curr.next = r
                    r = r.next
                curr = curr.next
            if l is None:
                curr.next = r
            elif r is None:
                curr.next = l
            
            return sentinel.next
        
        step = 1
        n = len(lists)
        while step < n:
            for i in range(0, n, 2 * step):
                left = lists[i]
                right = lists[i + step] if i + step < n else None
                if right is not None:
                    lists[i] = mergeTwo(left, right)
            
            step *= 2
        
        return lists[0] if lists else None
```

## Notes
- This approach is superior to previous because we do not need an auxiliary data structure to build the result. Instead, we build the result in place by repeatedly iterating over `lists`, merging smaller merged LLs in a divide and conquer fashion.

## Solution - C++

```
#include <queue>
#include <vector>
#include <utility>
#include <greater>

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
class Solution {
public:
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        ListNode* sentinel = new ListNode(-1);
        ListNode* curr = sentinel;

        priority_queue<
            pair<int, ListNode*>, 
            vector<pair<int, ListNode*>>, 
            greater<pair<int, ListNode*>>
        > h;
        for (auto n : lists) {
            if (n != nullptr) {
                h.push({n->val, n});
            }
        }

        while (!h.empty()) {
            ListNode* t = h.top().second;
            h.pop();
            if (t->next != nullptr) {
                h.push({t->next->val, t->next});
            }
            curr->next = t;
            curr = t;
        }

        return sentinel->next;
    }
};
```