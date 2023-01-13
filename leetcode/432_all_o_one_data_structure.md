# 432. All O' One Data Structure - Hard

Design a data structure to store the strings' count with the ability to return the strings with minimum and maximum counts.

Implement the `AllOne` class:

- `AllOne()` Initializes the object of the data structure.
- `inc(String key)` Increments the count of the string `key` by `1`. If `key` does not exist in the data structure, insert it with count `1`.
- `dec(String key)` Decrements the count of the string `key` by `1`. If the count of `key` is `0` after the decrement, remove it from the data structure. It is guaranteed that `key` exists in the data structure before the decrement.
- `getMaxKey()` Returns one of the keys with the maximal count. If no element exists, return an empty string `""`.
- `getMinKey()` Returns one of the keys with the minimum count. If no element exists, return an empty string `""`.

Note that each function must run in `O(1)` average time complexity.

##### Example 1:

```
Input
["AllOne", "inc", "inc", "getMaxKey", "getMinKey", "inc", "getMaxKey", "getMinKey"]
[[], ["hello"], ["hello"], [], [], ["leet"], [], []]
Output
[null, null, null, "hello", "hello", null, "hello", "leet"]

Explanation
AllOne allOne = new AllOne();
allOne.inc("hello");
allOne.inc("hello");
allOne.getMaxKey(); // return "hello"
allOne.getMinKey(); // return "hello"
allOne.inc("leet");
allOne.getMaxKey(); // return "hello"
allOne.getMinKey(); // return "leet"
```

##### Constraints:

- `1 <= key.length <= 10`
- `key` consists of lowercase English letters.
- It is guaranteed that for each call to `dec`, `key` is existing in the data structure.
- At most <code>5 * 10<sup>4</sup></code> calls will be made to `inc`, `dec`, `getMaxKey`, and `getMinKey`.

## Solution

```
from collections import defaultdict

class Bucket:
    def __init__(self, count):
        self.count = count
        self.keys = set()
        self.prev = self.next = None

# Time: all methods O(1) average 
# Space: O(n)
class AllOne:
    def __init__(self):
        self.head, self.tail = Bucket(0), Bucket(math.inf)
        self.head.next, self.tail.prev = self.tail, self.head
        self.counts2buckets = {}
        self.words2counts = defaultdict(int)

    def inc(self, key: str) -> None:
        self.words2counts[key] += 1
        count = self.words2counts[key]
        if count not in self.counts2buckets:
            self.counts2buckets[count] = Bucket(count)
            b = self.counts2buckets[count]
            b.keys.add(key)
            if count == 1:
                b.prev, b.next = self.head, self.head.next
                self.head.next.prev = b
                self.head.next = b
            else:
                prevbucket = self.counts2buckets[count - 1]
                b.next, b.prev = prevbucket.next, prevbucket
                prevbucket.next.prev = b
                prevbucket.next = b
        else:
            self.counts2buckets[count].keys.add(key)

        if count > 1:
            prevbucket = self.counts2buckets[count - 1]
            prevbucket.keys.remove(key)
            if len(prevbucket.keys) == 0:
                prevbucket.prev.next, prevbucket.next.prev = prevbucket.next, prevbucket.prev
                self.counts2buckets.pop(count - 1)

    def dec(self, key: str) -> None:
        self.words2counts[key] -= 1
        count = self.words2counts[key]
        if count == 0:
            self.words2counts.pop(key)
        if count not in self.counts2buckets and count > 0:
            self.counts2buckets[count] = Bucket(count)
            b = self.counts2buckets[count]
            b.keys.add(key)
            oldbucket = self.counts2buckets[count + 1]
            b.next, b.prev = oldbucket, oldbucket.prev
            oldbucket.prev.next = b
            oldbucket.prev = b
        elif count in self.counts2buckets:
            self.counts2buckets[count].keys.add(key)
        
        oldbucket = self.counts2buckets[count + 1]
        oldbucket.keys.remove(key)
        if len(oldbucket.keys) == 0:
            oldbucket.prev.next, oldbucket.next.prev = oldbucket.next, oldbucket.prev
            self.counts2buckets.pop(count + 1)

    def getMaxKey(self) -> str:
        if self.head.next is self.tail:
            return ""
        for key in self.tail.prev.keys:
            return key

    def getMinKey(self) -> str:
        if self.head.next is self.tail:
            return ""
        for key in self.head.next.keys:
            return key
```

## Notes
- Buckets of words with a particular count, where buckets are arranged in sorted order via doubly linked list. We need to be able to lookup count-bucket and word-count relationships, so we have 2 hash tables for that. 