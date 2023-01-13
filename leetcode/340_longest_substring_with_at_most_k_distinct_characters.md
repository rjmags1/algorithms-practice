# 340 Longest Substring with At Most K Distinct Characters - Medium

Given a string `s` and an integer `k`, return the length of the longest substring of `s` that contains at most `k` distinct characters.

##### Example 1:

```
Input: s = "eceba", k = 2
Output: 3
Explanation: The substring is "ece" with length 3.
```

##### Example 2:

```
Input: s = "aa", k = 1
Output: 2
Explanation: The substring is "aa" with length 2.
```

##### Constraints:

- <code>1 <= s.length <= 5 * 10<sup>4</sup></code>
- <code>0 <= k <= 50</code>

## Solution 1

```
class Node:
    def __init__(self, val=None, i=None):
        self.val = val
        self.i = i
        self.prev = self.next = None

class OrderedDict:
    def __init__(self):
        self.head, self.tail = Node(), Node()
        self.head.next, self.tail.prev = self.tail, self.head
        self.nodes = {}
    
    def size(self):
        return len(self.nodes)
    
    def has(self, val):
        return val in self.nodes
    
    def remove(self, val):
        node = self.nodes.pop(val)
        node.prev.next, node.next.prev = node.next, node.prev
        node.next = node.prev = None
        return node
    
    def insert(self, val, i):
        node = Node(val, i) if val not in self.nodes else self.remove(val)
        node.i = i
        self.nodes[val] = node
        node.prev, node.next = self.tail.prev, self.tail
        self.tail.prev.next = node
        self.tail.prev = node
    
    def popleft(self):
        return self.remove(self.front().val)
    
    def front(self):
        return self.head.next

# Time: O(n) (one pass)
# Space: O(k)
class Solution:
    def lengthOfLongestSubstringKDistinct(self, s: str, k: int) -> int:
        if k == 0:
            return 0
        
        od = OrderedDict()
        result = start = 0
        for i, c in enumerate(s):
            if not od.has(c) and od.size() == k:
                start = od.popleft().i + 1
            od.insert(c, i)
            result = max(result, i - start + 1)
                
        return result
```

## Notes
- For this question, sliding window should be the first idea to jump to mind; we can maintain a substring window that contains `<= k` distinct characters and return the longest the window gets as we traverse `s`. This would be much better than a more naive `O(nk)` approach. There is an easier 2-pass solution involving a character frequency hash table not shown here. To obtain a single pass solution, we need to be able to determine, in constant time, __out of the `k` characters in the current window, which one has the lowest index for its rightmost appearance in the current window__; the next window will start after that. Naively attempting to achieve this with a queue, heap, or other more common data structure will not work. Consider how a case such as `s = cecba, k = 2` would fail because popping index `0`; with a heap, each time the rightmost index for an element in the heap gets updated, the entire heap would need to be re-heapified. 

## Solution 2

```
# Time: O(n)
# Space: O(k)
class Solution:
    def lengthOfLongestSubstringKDistinct(self, s: str, k: int) -> int:
        if k == 0:
            return 0
        
        od = OrderedDict()
        result = start = 0
        for i, c in enumerate(s):
            if c not in od and len(od) == k:
                _, j = od.popitem(last=False)
                start = j + 1
            if c in od:
                od.move_to_end(c, True)
            od[c] = i
            result = max(result, i - start + 1)
                
        return result
```

## Notes
- Same idea as above just using python `OrderedDict`. The ordered dict behaves like a stack with default implementation so just remember to use the `last` keyword argument for `OrderedDict.pop()` functionality similar to `deque.popleft()`.