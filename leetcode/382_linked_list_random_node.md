# 382. Linked List Random Node - Medium

Given a singly linked list, return a random node's value from the linked list. Each node must have the same probability of being chosen.

Implement the `Solution` class:

- `Solution(ListNode head)` Initializes the object with the head of the singly-linked list `head`.
- `int getRandom()` Chooses a node randomly from the list and returns its value. All the nodes of the list should be equally likely to be chosen.

##### Example 1:

```
Input
["Solution", "getRandom", "getRandom", "getRandom", "getRandom", "getRandom"]
[[[1, 2, 3]], [], [], [], [], []]
Output
[null, 1, 3, 2, 2, 3]

Explanation
Solution solution = new Solution([1, 2, 3]);
solution.getRandom(); // return 1
solution.getRandom(); // return 3
solution.getRandom(); // return 2
solution.getRandom(); // return 2
solution.getRandom(); // return 3
// getRandom() should return either 1, 2, or 3 randomly. Each element should have equal probability of returning.
```

##### Constraints:

- The number of nodes in the linked list will be in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-10<sup>4</sup> <= Node.val <= 10<sup>4</sup></code>
- At most <code>10<sup>4</sup></code> calls will be made to `getRandom`.

Follow-up: 

- What if the linked list is extremely large and its length is unknown to you?
- Could you solve this efficiently without using extra space?

## Solution

```
# Overall Space: O(1)
class Solution:
    # Time: O(1)
    def __init__(self, head: Optional[ListNode]):
        self.ll = head

    # Time: O(n)
    def getRandom(self) -> int:
        result, size = self.ll.val, 1
        curr = self.ll.next
        while curr:
            size += 1
            if random.randrange(1, size + 1) == 1:
                result = curr.val
            curr = curr.next
        return result
```

## Notes
- Reservoir sampling. This solution addresses both followup questions - the more naive approach would be to store all the nodes in an array and then use `random.choice`. It would be better to not use linear extra space if possible especially in the case that the input linked list may be very large.
- This algorithm guarantees randomness by ensuring that all nodes have the same probability of making it into the reservoir and not getting replaced.