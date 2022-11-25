# 281. Zigzag Iterator - Medium

Given two vectors of integers `v1` and `v2`, implement an iterator to return their elements alternately.

Implement the `ZigzagIterator` class:

- `ZigzagIterator(List<int> v1, List<int> v2)` initializes the object with the two vectors `v1` and `v2`.
- `boolean hasNext()` returns `true` if the iterator still has elements, and `false` otherwise.
- int `next()` returns the current element of the iterator and moves the iterator to the next element.


##### Example 1:

```
Input: v1 = [1,2], v2 = [3,4,5,6]
Output: [1,3,2,4,5,6]
Explanation: By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,3,2,4,5,6].
```

##### Example 2:

```
Input: v1 = [1], v2 = []
Output: [1]
```

##### Example 3:

```
Input: v1 = [], v2 = [1]
Output: [1]
```

##### Constraints:

- <code>0 <= v1.length, v2.length <= 1000</code>
- <code>1 <= v1.length + v2.length <= 2000</code>
- <code>-2<sup>31</sup> <= v1[i], v2[i] <= 2<sup>31</sup> - 1</code>

Follow-up: What if you are given k vectors? How well can your code be extended to such cases? 

## Solution

```
# Time: O(1) all ops
# Space: O(n + m) where n is num vecs and m is total elements
class Node:
    def __init__(self, val):
        self.val = val
        self.next = self.prev = None

class DLL:
    def __init__(self):
        self.head, self.tail = Node(None), Node(None)
        self.head.next, self.tail.prev = self.tail, self.head
    
    def empty(self):
        return self.head.next == self.tail
    
    def remove(self, node):
        node.prev.next, node.next.prev = node.next, node.prev
        node.next = node.prev = None
    
    def append(self, node):
        node.prev, node.next = self.tail.prev, self.tail
        self.tail.prev.next = node
        self.tail.prev = node

class ZigzagIterator:
    V, I = 0, 1
    def __init__(self, v1: List[int], v2: List[int]):
        self.vecs = DLL()
        if v1:
            self.vecs.append(Node({self.V: v1, self.I: 0}))
        if v2:
            self.vecs.append(Node({self.V: v2, self.I: 0}))
        self.curr = self.vecs.head.next
        
    def next(self) -> int:
        result = self.curr.val[self.V][self.curr.val[self.I]]
        self.curr.val[self.I] += 1
        nxt = self.curr.next
        if nxt is self.vecs.tail:
            nxt = self.vecs.head.next
        if self.curr.val[self.I] == len(self.curr.val[self.V]):
            self.vecs.remove(self.curr)
        self.curr = nxt
        return result

    def hasNext(self) -> bool:
        return self.vecs.head.next is not self.vecs.tail
```

## Notes
- Extensible to `k` vectors due to properties of DLL (constant removal).