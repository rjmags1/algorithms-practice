# 1481. Least Number of Unique Integers after K Removals - Medium

Given an array of integers `arr` and an integer `k`. Find the least number of unique integers after removing exactly `k` elements.

##### Example 1:

```
Input: arr = [5,5,4], k = 1
Output: 1
Explanation: Remove the single 4, only 5 is left.
```

##### Example 2:

```
Input: arr = [4,3,1,1,3,3,2], k = 3
Output: 2
Explanation: Remove 4, 2 and either one of the two 1s or three 3s. 1 and 3 will be left.
```

##### Constraints:

- `1 <= arr.length <= 10^5`
- `1 <= arr[i] <= 10^9`
- `0 <= k <= arr.length`

## Solution 1

```
import heapq
from collections import Counter

# Time: O(klog(n))
# Space: O(n)
class Solution:
    def findLeastNumOfUniqueInts(self, arr: List[int], k: int) -> int:
        h = [freq for freq in Counter(arr).values()]
        result = len(h)
        heapq.heapify(h)
        while h and h[0] <= k:
            k -= heapq.heappop(h)
            result -= 1
        return result
```

## Notes
- To minimize the number of unique numbers in the array after `k` removals we need to prioritize removing those numbers that have the lowest frequencies. We can do this with a min-heap of frequencies as shown above.

## Solution 2

```
import heapq
from collections import Counter

# Time: O(n)
# Space: O(n)
class Solution:
    def findLeastNumOfUniqueInts(self, arr: List[int], k: int) -> int:
        freqs = [freq for freq in Counter(arr).values()]
        buckets = [0] * (len(arr) + 1)
        for f in freqs:
            buckets[f] += 1
        result = len(freqs)
        for freq, freqcount in enumerate(buckets):
            if k < freq:
                break
            if freqcount == 0:
                continue
            nums = freq * freqcount
            if nums <= k:
                k -= nums
                result -= freqcount
            else:
                result -= k // freq
                break
        return result
```

## Notes
- We can get linear time with the same conceptual greedy strategy but a different bucket based implementation.