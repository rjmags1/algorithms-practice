# 232. Implement Queue Using Stacks - Easy

Implement a first in first out (FIFO) queue using only two stacks. The implemented queue should support all the functions of a normal queue (`push`, `peek`, `pop`, and `empty`).

Implement the `MyQueue` class:

- `void push(int x)` Pushes element `x` to the back of the queue.
- `int pop()` Removes the element from the front of the queue and returns it.
- `int peek()` Returns the element at the front of the queue.
- `boolean empty()` Returns `true` if the queue is empty, `false` otherwise.

Notes:

- You must use only standard operations of a stack, which means only push to top, peek/pop from top, size, and is empty operations are valid.
- Depending on your language, the stack may not be supported natively. You may simulate a stack using a list or deque (double-ended queue) as long as you use only a stack's standard operations.


##### Example 1:

```
Input
["MyQueue", "push", "push", "peek", "pop", "empty"]
[[], [1], [2], [], [], []]
Output
[null, null, null, 1, 1, false]

Explanation
MyQueue myQueue = new MyQueue();
myQueue.push(1); // queue is: [1]
myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
myQueue.peek(); // return 1
myQueue.pop(); // return 1, queue is [2]
myQueue.empty(); // return false
```

##### Constraints:

- `1 <= x <= 9`
- At most `100` calls will be made to `push`, `pop`, `peek`, and `empty`.
- All the calls to `pop` and `peek` are valid.

Follow-up: Can you implement the queue such that each operation is amortized `O(1)` time complexity? In other words, performing `n` operations will take overall `O(n)` time even if one of those operations may take longer.

## Solution 1

```
# Overall Space: O(n)
class MyQueue:
    def __init__(self):
        self.curr = []
        self.other = []

    # Time: O(1)
    def push(self, x: int) -> None:
        self.curr.append(x)

    # Time: O(n)
    def pop(self) -> int:
        while len(self.curr) > 1:
            self.other.append(self.curr.pop())
        result = self.curr.pop()
        while self.other:
            self.curr.append(self.other.pop())
        return result

    # Time: O(1)
    def peek(self) -> int:
        return self.curr[0]

    # Time: O(1)
    def empty(self) -> bool:
        return not self.curr
```

## Notes
- When we pop into the second stack to access the first element of the first stack, the elements in the second stack by the time we access the first element of the first stack will be in reverse order, so they need to be popped back onto the first stack.

## Solution 2

```
# Overall Space: O(n)
class MyQueue:
    def __init__(self):
        self.s1 = []
        self.s2 = []

    # Time: O(1)
    def push(self, x: int) -> None:
        self.s1.append(x)

    # Time: O(1) amortized
    def pop(self) -> int:
        if not self.s2:
            while self.s1:
                self.s2.append(self.s1.pop())
        return self.s2.pop()

    # Time: O(1)
    def peek(self) -> int:
        return self.s1[0] if not self.s2 else self.s2[-1]

    # Time: O(1)
    def empty(self) -> bool:
        return not self.s1 and not self.s2
```

## Notes
- Note how in Solution 1 we are constantly popping into the second stack, getting the front of stack1 for return, and then popping back into the first stack to preserve the original order. This is unnecessary - we can just leave the second stack as is, as it will keep the front of the queue in a position we can access in a single operation the next time pop is called. Whenever `pop` is called, if there is anything in the second stack, we can just return the top of it. If not, we can pop the first stack into the second, as before.
- The time complexity of `pop` is constant if amortized over `n` elements because each element will be added into the first stack, popped and added to the second stack, and popped from the second stack once each. In other words, for every call to `pop` where we empty `k` elements from the first stack into the second in `O(k)`, there will be `k` `O(1)` calls to `pop`.