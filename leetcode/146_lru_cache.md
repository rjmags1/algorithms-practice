# 146. LRU Cache - Medium

Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

Implement the `LRUCache` class:

- `LRUCache(int capacity)` Initialize the LRU cache with positive size `capacity`.
- `int get(int key)` Return the value of the `key` if the `key` exists, otherwise return `-1`.
- `void put(int key, int value)` Update the value of the `key` if the `key` exists. Otherwise, add the `key-value` pair to the cache. If the number of keys exceeds the `capacity` from this operation, evict the least recently used key.

The functions `get` and `put` must each run in `O(1)` average time complexity.

##### Example 1:

```
Input
["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, null, -1, 3, 4]

Explanation
LRUCache lRUCache = new LRUCache(2);
lRUCache.put(1, 1); // cache is {1=1}
lRUCache.put(2, 2); // cache is {1=1, 2=2}
lRUCache.get(1);    // return 1
lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
lRUCache.get(2);    // returns -1 (not found)
lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
lRUCache.get(1);    // return -1 (not found)
lRUCache.get(3);    // return 3
lRUCache.get(4);    // return 4
```

##### Constraints:

- `1 <= capacity <= 3000`
- <code>0 <= key <= 10<sup>4</sup></code>
- <code>0 <= value <= 10<sup>5</sup></code>
- At most <code>2 * 10<sup>5</sup></code> calls will be made to get and put.

## Solution 1

```
Time: O(1) all methods
Space: O(c)
class DLLNode:
    def __init__(self, key, val, prev=None, next=None):
        self.key = key
        self.val = val
        self.prev = prev
        self.next = next
    
class DLL:
    def __init__(self):
        self.head = DLLNode(None, None)
        self.tail = DLLNode(None, None)
        self.head.next = self.tail
        self.tail.prev = self.head
    
    def remove(self, node) -> DLLNode:
        node.prev.next, node.next.prev = node.next, node.prev
        node.next = node.prev = None
        return node
    
    def removeFromFront(self) -> DLLNode:
        return self.remove(self.head.next)
    
    def append(self, node) -> DLLNode:
        node.next = self.tail
        node.prev = self.tail.prev
        self.tail.prev.next = node
        self.tail.prev = node
    
class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.nodes = {}
        self.dll = DLL()

    def get(self, key: int) -> int:
        if key not in self.nodes:
            return -1
        node = self.nodes[key]
        self.dll.append(self.dll.remove(node))
        return node.val

    def put(self, key: int, value: int) -> None:
        if key in self.nodes:
            node = self.nodes[key]
            node.val = value
            self.dll.append(self.dll.remove(node))
            return
        
        if len(self.nodes) == self.capacity:
            self.evict()
        node = DLLNode(key, value)
        self.nodes[key] = node
        self.dll.append(node)
    
    def evict(self) -> None:
        evicted = self.dll.removeFromFront()
        del self.nodes[evicted.key]
```

## Notes
- We use a doubly-linked-list to achieve constant time `get` and `put` operations. The DLL allows us to easily shuffle k-v pairs in the cache in the way we need to to implement an LRU cache. That is, we need to be able to grab a k-v pair from the LRU queue and put it in the back every time it gets looked up or value reassigned.
- Like many cases where we use auxiliary data structures to implement a main data structure, it is useful to implement the auxiliary as its own thing instead of intertwining its implementation with the thing it is being used to implement. It is less for the brain to keep track of and generally better to respect natural abstractions instead of fighting against them.

## Solution 2

```
# Time: O(1) all methods
# Space: O(c)
class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.pairs = OrderedDict()

    def get(self, key: int) -> int:
        if key not in self.pairs:
            return -1
        self.pairs.move_to_end(key)
        return self.pairs[key]

    def put(self, key: int, value: int) -> None:
        if key in self.pairs:
            self.pairs[key] = value
            self.pairs.move_to_end(key)
            return
        
        if len(self.pairs) == self.capacity:
            self.pairs.popitem(last=False)
        self.pairs[key] = value
```

## Notes
- Much more succinct implementation using python's `OrderedDict` class. Need to be careful about how you call `popitem` and `move_to_end` because the default behavior will pop from the back and move to the back, which is not what we want for this problem - we want a queue like data structure.