# 460. LFU Cache - Hard

Design and implement a data structure for a Least Frequently Used (LFU) cache.

Implement the `LFUCache` class:

- `LFUCache(int capacity)` Initializes the object with the `capacity` of the data structure.
- `int get(int key)` Gets the value of the `key` if the key exists in the cache. Otherwise, returns `-1`.
- `void put(int key, int value)` Update the `value` of the `key` if present, or inserts the `key` if not already present. When the cache reaches its capacity, it should invalidate and remove the least frequently used `key` before inserting a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency), the least recently used `key` would be invalidated.

To determine the least frequently used `key`, a use counter is maintained for each `key` in the cache. The `key` with the smallest use counter is the least frequently used `key`.

When a `key` is first inserted into the cache, its use counter is set to `1` (due to the put operation). The use counter for a `key` in the cache is incremented either a `get` or `put` operation is called on it.

The functions get and put must each run in `O(1)` average time complexity.

##### Example 1:

```
Input
["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, 3, null, -1, 3, 4]

Explanation
// cnt(x) = the use counter for key x
// cache=[] will show the last used order for tiebreakers (leftmost element is  most recent)
LFUCache lfu = new LFUCache(2);
lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
lfu.get(1);      // return 1
                 // cache=[1,2], cnt(2)=1, cnt(1)=2
lfu.put(3, 3);   // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
                 // cache=[3,1], cnt(3)=1, cnt(1)=2
lfu.get(2);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,1], cnt(3)=2, cnt(1)=2
lfu.put(4, 4);   // Both 1 and 3 have the same cnt, but 1 is LRU, invalidate 1.
                 // cache=[4,3], cnt(4)=1, cnt(3)=2
lfu.get(1);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,4], cnt(4)=1, cnt(3)=3
lfu.get(4);      // return 4
                 // cache=[4,3], cnt(4)=2, cnt(3)=3
```

##### Constraints:

- <code>0 <= capacity <= 10<sup>4</sup></code>
- <code>0 <= key <= 10<sup>5</sup></code>
- <code>0 <= value <= 10<sup>9</sup></code>
- At most <code>2 * 10<sup>5</sup></code> calls will be made to get and put.

## Solution

```
from collections import OrderedDict

class Bucket:
    def __init__(self, hitcount):
        self.keys = OrderedDict()
        self.prev = self.next = None
        self.hitcount = hitcount

# Overall Time: O(1) average all methods
# Overall Space: O(n)
class LFUCache:
    def __init__(self, capacity: int):
        self.head, self.tail = Bucket(None), Bucket(None)
        self.head.next, self.tail.prev = self.tail, self.head
        self.n = capacity
        self.hits = {}
        self.buckets = {}

    def get(self, key: int) -> int:
        if key not in self.hits:
            return -1

        oldkeyhits = self.hits[key]
        oldbucket = self.buckets[oldkeyhits]
        keyhits = oldkeyhits + 1
        # update hits
        self.hits[key] = keyhits

        # move key to new bucket from old bucket
        result = self.buckets[oldkeyhits].keys.pop(key)
        if keyhits not in self.buckets:
            bucket = self.buckets[keyhits] = Bucket(keyhits)
            nxt = oldbucket.next
            nxt.prev = oldbucket.next = bucket
            bucket.next, bucket.prev = nxt, oldbucket
        self.buckets[keyhits].keys[key] = result

        # delete old bucket if empty after move
        if len(oldbucket.keys) == 0:
            oldbucket.prev.next, oldbucket.next.prev = oldbucket.next, oldbucket.prev
            oldbucket.prev = oldbucket.next = None
            self.buckets.pop(oldkeyhits)
        
        return result

    def put(self, key: int, value: int) -> None:
        if self.n == 0:
            return

        if key in self.hits:
            oldkeyhits = self.hits[key]
            oldbucket = self.buckets[oldkeyhits]
            keyhits = oldkeyhits + 1

            # update hits
            self.hits[key] = keyhits

            # move to new bucket and update value
            self.buckets[oldkeyhits].keys.pop(key)
            if keyhits not in self.buckets:
                bucket = self.buckets[keyhits] = Bucket(keyhits)
                nxt = oldbucket.next
                nxt.prev = oldbucket.next = bucket
                bucket.next, bucket.prev = nxt, oldbucket
            self.buckets[keyhits].keys[key] = value
    
            # delete old bucket if empty after move
            if len(oldbucket.keys) == 0:
                oldbucket.prev.next, oldbucket.next.prev = oldbucket.next, oldbucket.prev
                oldbucket.prev = oldbucket.next = None
                self.buckets.pop(oldkeyhits)
        
        else:
            # if adding new key exceed cap, del oldest from lowest hits bucket
            if len(self.hits) == self.n:
                self.hits.pop(self.head.next.keys.popitem(last=False)[0])

            # add new key into 1-hit bucket, creating if it needed
            if len(self.hits) == 0 or self.head.next.hitcount > 1:
                bucket = Bucket(1)
                nxt = self.head.next
                nxt.prev = self.head.next = bucket
                bucket.next, bucket.prev = nxt, self.head
                self.buckets[1] = bucket
            self.head.next.keys[key] = value

            # add new key to self.hits
            self.hits[key] = 1
```

## Notes
- Doubly linked list of buckets of k-v pairs where all pairs in the bucket have the same number of uses AKA `hits`. Buckets are ordered dictionaries themselves in order to satisfy the constraint that when there are multiple least frequently used k-v pairs we should invalidate the least recently used one. Not hard from a conceptual perspective but correctly addressing all edge cases makes this one tricky.