# 225. Implement Stack using Queues - Easy

Implement a last-in-first-out (LIFO) stack using only two queues. The implemented stack should support all the functions of a normal stack (`push`, `top`, `pop`, and `empty`).

Implement the `MyStack` class:

- `void push(int x)` Pushes element `x` to the top of the stack.
- `int pop()` Removes the element on the top of the stack and returns it.
- `int top()` Returns the element on the top of the stack.
- `boolean empty()` Returns `true` if the stack is empty, `false` otherwise.

Notes:

- You must use only standard operations of a queue, which means that only push to back, peek/pop from front, size and is empty operations are valid.
- Depending on your language, the queue may not be supported natively. You may simulate a queue using a list or deque (double-ended queue) as long as you use only a queue's standard operations.


##### Example 1:

```
Input
["MyStack", "push", "push", "top", "pop", "empty"]
[[], [1], [2], [], [], []]
Output
[null, null, null, 2, 2, false]

Explanation
MyStack myStack = new MyStack();
myStack.push(1);
myStack.push(2);
myStack.top(); // return 2
myStack.pop(); // return 2
myStack.empty(); // return False
```

##### Constraints:

- `1 <= x <= 9`
- At most `100` calls will be made to `push`, `pop`, `top`, and `empty`.
- All the calls to `pop` and `top` are valid.

Follow-up: Can you implement the stack using only one queue? 

## Solution 1

```
# Overall space: O(n)
class MyStack:
    def __init__(self):
        self.curr = deque()
        self.other = deque()

    # Time: O(1)
    def push(self, x: int) -> None:
        self.curr.append(x)

    # Time: O(n)
    def pop(self) -> int:
        while len(self.curr) > 1:
            self.other.append(self.curr.popleft())
        result = self.curr.popleft()
        self.curr, self.other = self.other, self.curr
        return result

    # Time: O(1)
    def top(self) -> int:
        return self.curr[-1]

    # Time: O(1)
    def empty(self) -> bool:
        return len(self.curr) == 0
```

## Notes
- Cannot do better than O(n) for `pop` or `push` because we are forced to only use standard queue operations to implement the stack; to get the last element of the queue with this constraint, we must pop from the front of the queue until the last element is at the front so we can return it.

## Solution 2

```
class MyStack:
    def __init__(self):
        self.q = deque()

    def push(self, x: int) -> None:
        self.q.append(x)

    def pop(self) -> int:
        n = len(self.q)
        moved = 0
        while moved < n - 1:
            self.q.append(self.q.popleft())
            moved += 1
        return self.q.popleft()

    def top(self) -> int:
        return self.q[-1]

    def empty(self) -> bool:
        return len(self.q) == 0
```

## Notes
- Instead of using another queue we can append non-last elements right after popping them from the same array until the last element is at the front of the queue.