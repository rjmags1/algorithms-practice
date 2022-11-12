# 155. Min Stack - Medium

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

Implement the `MinStack` class:

- `MinStack()` initializes the stack object.
- `void push(int val)` pushes the element `val` onto the stack.
- `void pop()` removes the element on the top of the stack.
- `int top()` gets the top element of the stack.
- `int getMin()` retrieves the minimum element in the stack.

You must implement a solution with `O(1)` time complexity for each function.

##### Example 1:

```
Input
["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]

Output
[null,null,null,null,-3,null,0,-2]

Explanation
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2
```

##### Constraints:

- <code>-2<sup>31</sup> <= val <= 2<sup>31</sup> - 1</code>
- Methods `pop`, `top` and `getMin` operations will always be called on non-empty stacks.
- At most <code>3 * 10<sup>4</sup></code> calls will be made to `push`, `pop`, `top`, and `getMin`.

## Solution

```
# Time: O(1) all methods
# Space: O(n) for an instance of MinStack containing n elements
class MinStack:
    def __init__(self):
        self.stack = []
        self.mins = []

    def push(self, val: int) -> None:
        self.stack.append(val)
        self.mins.append(min(val, self.mins[-1]) if self.mins else val)

    def pop(self) -> None:
        self.mins.pop()
        return self.stack.pop()
        
    def top(self) -> int:
        return self.stack[-1]

    def getMin(self) -> int:
        return self.mins[-1]
```

## Notes
- We always need to have access to the most recently added element in addition to the minimum value present in the stack. Why not record the minimum value in the stack, for each element in the stack at the time of its `push` with another list?