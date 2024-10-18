# 622. Design Circular Queue - Medium

Design your implementation of the circular queue. The circular queue is a linear data structure in which the operations are performed based on FIFO (First In First Out) principle, and the last position is connected back to the first position to make a circle. It is also called "Ring Buffer".

One of the benefits of the circular queue is that we can make use of the spaces in front of the queue. In a normal queue, once the queue becomes full, we cannot insert the next element even if there is a space in front of the queue. But using the circular queue, we can use the space to store new values.

Implement the `MyCircularQueue` class:

- `MyCircularQueue(k)` Initializes the object with the size of the queue to be `k`.
- `int Front()` Gets the front item from the queue. If the queue is empty, return `-1`.
- `int Rear()` Gets the last item from the queue. If the queue is empty, return `-1`.
- `boolean enQueue(int value)` Inserts an element into the circular queue. Return `true` if the operation is successful.
- `boolean deQueue()` Deletes an element from the circular queue. Return `true` if the operation is successful.
- `boolean isEmpty()` Checks whether the circular queue is empty or not.
- `boolean isFull()` Checks whether the circular queue is full or not.

You must solve the problem without using the built-in queue data structure in your programming language.

##### Example 1:

```
Input
["MyCircularQueue", "enQueue", "enQueue", "enQueue", "enQueue", "Rear", "isFull", "deQueue", "enQueue", "Rear"]
[[3], [1], [2], [3], [4], [], [], [], [4], []]
Output
[null, true, true, true, false, 3, true, true, true, 4]

Explanation
MyCircularQueue myCircularQueue = new MyCircularQueue(3);
myCircularQueue.enQueue(1); // return True
myCircularQueue.enQueue(2); // return True
myCircularQueue.enQueue(3); // return True
myCircularQueue.enQueue(4); // return False
myCircularQueue.Rear();     // return 3
myCircularQueue.isFull();   // return True
myCircularQueue.deQueue();  // return True
myCircularQueue.enQueue(4); // return True
myCircularQueue.Rear();     // return 4
```

##### Constraints:

- `1 <= k <= 1000`
- `0 <= value <= 1000`
- At most `3000` calls will be made to `enQueue`, `deQueue`, `Front`, `Rear`, `isEmpty`, and `isFull`.

## Solution

```
class MyCircularQueue:

    def __init__(self, k: int):
        self.q = [None for _ in range(k)]
        self.capacity = k
        self.size = 0
        self.front_i = 0
        self.back_i = 0
        self.front = None
        self.back = None

    def enQueue(self, value: int) -> bool:
        if self.size == self.capacity:
            return False

        self.q[self.back_i] = value
        self.size += 1
        self.back_i += 1
        if self.back_i == self.capacity:
            self.back_i = 0
        
        self.back = value
        if self.size == 1:
            self.front = value

        return True

    def deQueue(self) -> bool:
        if self.size == 0:
            return False

        result = self.q[self.front_i]
        self.q[self.front_i] = None
        self.size -= 1
        self.front_i += 1
        if self.front_i == self.capacity:
            self.front_i = 0

        if self.size > 0:
            self.front = self.q[self.front_i]

        return True

    def Front(self) -> int:
        if self.size == 0:
            return -1
        return self.front

    def Rear(self) -> int:
        if self.size == 0:
            return -1
        return self.back

    def isEmpty(self) -> bool:
        return self.size == 0

    def isFull(self) -> bool:
        return self.size == self.capacity


# Your MyCircularQueue object will be instantiated and called as such:
# obj = MyCircularQueue(k)
# param_1 = obj.enQueue(value)
# param_2 = obj.deQueue()
# param_3 = obj.Front()
# param_4 = obj.Rear()
# param_5 = obj.isEmpty()
# param_6 = obj.isFull()
```

## Notes
- "Ring buffer" makes the idea of this implementation clear. Note how the current front and rear values are updated in the `enQueue` and `deQueue` methods. Implementing `Front` and `Rear` methods any other way introduces a lot of extra edge cases that are difficult to handle/