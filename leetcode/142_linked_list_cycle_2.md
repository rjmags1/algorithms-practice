# 142. Linked List Cycle II - Medium

Given the `head` of a linked list, return the node where the cycle begins. If there is no cycle, return `null`.

There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the `next` pointer. Internally, `pos` is used to denote the index of the node that tail's `next` pointer is connected to (0-indexed). It is `-1` if there is no cycle. Note that `pos` is not passed as a parameter.

Do not modify the linked list.

##### Example 1:

```
Input: head = [3,2,0,-4], pos = 1
Output: tail connects to node index 1
Explanation: There is a cycle in the linked list, where tail connects to the second node.
```

##### Example 2:

```
Input: head = [3,2,0,-4], pos = 1
Output: tail connects to node index 1
Explanation: There is a cycle in the linked list, where tail connects to the second node.
```

##### Example 3:

```
Input: head = [1], pos = -1
Output: no cycle
Explanation: There is no cycle in the linked list.
```

##### Constraints:

- The number of the nodes in the list is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>
- `pos` is `-1` or a valid index in the linked-list.

Follow-up: Can you solve it using `O(1)` (i.e. constant) memory?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def detectCycle(self, head: Optional[ListNode]) -> Optional[ListNode]:
        t = h = head
        while h:
            h = h.next.next if h.next else None
            t = t.next
            if h is t:
                break
                
        if not h:
            return None
        
        p1, p2 = t, head
        while p1 is not p2:
            p1, p2 = p1.next, p2.next
        return p1
```

## Notes
- This problem can be annoying to get right implementation-wise, and conceptually it is subtle to understand because even if you build the correct system of equations needed to derive the correct conceptual approach, actually deriving the correct conceptual approach from the equations is a bit subtle because it requires a bit of interpretation beyond saying "ok this variable equals that variable".
- Consider the image below. The distance the hare travels, call it `X`, will always be twice as large as the distance the tortoise travels, call this `Y`. The length of the cycle, call it `C`, is `C = a + b`. The distance the tortoise travels is `Y = F + a`. The distance the hare travels is `X = F + a + nC`, where `n` is some integer `> 0` and represents the number of cycles the hare travels before intersecting with the tortoise. Since `2Y = X`, we have `2(F + a) = F + a + nC`, which can be simplified to `F + a = nC`, or `F = nC - a`.
- Ok, most intermediate algo people could probably derive these equations naively. The tricky part is interpreting `F = nC - a`. It means: "the distance `F` is equivalent to some multiple of the cycle length, minus a single `a`". Hence, if we find the intersection point, and then start one pointer iterating one step at a time from `head` and a second pointer iterating one step at a time from the intersection point, those pointers will eventually meet at the start of the cycle.
<img src="../assets/142-tortoise-hare.png"/>