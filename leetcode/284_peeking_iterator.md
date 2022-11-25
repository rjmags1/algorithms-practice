# 284. Peeking Iterator - Medium

Design an iterator that supports the `peek` operation on an existing iterator in addition to the `hasNext` and the `next` operations.

Implement the `PeekingIterator` class:

- `PeekingIterator(Iterator<int> nums)` Initializes the object with the given integer iterator `iterator`.
- `int next()` Returns the next element in the array and moves the pointer to the next element.
- `boolean hasNext()` Returns `true` if there are still elements in the array.
- `int peek()` Returns the next element in the array without moving the pointer.

Note: Each language may have a different implementation of the constructor and `Iterator`, but they all support the `int next()` and boolean `hasNext()` functions.

##### Example 1:

```
Input
["PeekingIterator", "next", "peek", "next", "next", "hasNext"]
[[[1, 2, 3]], [], [], [], [], []]
Output
[null, 1, 2, 2, 3, false]

Explanation
PeekingIterator peekingIterator = new PeekingIterator([1, 2, 3]); // [1,2,3]
peekingIterator.next();    // return 1, the pointer moves to the next element [1,2,3].
peekingIterator.peek();    // return 2, the pointer does not move [1,2,3].
peekingIterator.next();    // return 2, the pointer moves to the next element [1,2,3]
peekingIterator.next();    // return 3, the pointer moves to the next element [1,2,3]
peekingIterator.hasNext(); // return False
```

##### Constraints:

- `1 <= nums.length <= 1000`
- `1 <= nums[i] <= 1000`
- All the calls to `next` and `peek` are valid.
- At most `1000` calls will be made to `next`, `hasNext`, and `peek`.

Follow-up: How would you extend your design to be generic and work with all types, not just integer?

## Solution 1

```
# Time: O(1) all methods
# Space: O(1)
class PeekingIterator:
    def __init__(self, iterator):
        """
        Initialize your data structure here.
        :type iterator: Iterator
        """
        self.iter = iterator
        self.curr = self.iter.next()
        self.empty = False

    def peek(self):
        """
        Returns the next element in the iteration without advancing the iterator.
        :rtype: int
        """
        return self.curr

    def next(self):
        """
        :rtype: int
        """
        result = self.curr
        if self.iter.hasNext():
            self.curr = self.iter.next()
        else:
            self.empty = True
        return result
        
    def hasNext(self):
        """
        :rtype: bool
        """
        return not self.empty
```

## Notes
- Deceptively simple, just keep the actual iterator one step ahead of the position seen by the `PeekingIterator`, and maintain an instance level reference to the most recently return value of `self.iter.next`.