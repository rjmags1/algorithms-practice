# 480. Sliding Window Median - Hard

The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle values.

- For examples, if `arr = [2,3,4]`, the median is `3`.
- For examples, if `arr = [1,2,3,4]`, the median is `(2 + 3) / 2 = 2.5`.

You are given an integer array `nums` and an integer `k`. There is a sliding window of size `k` which is moving from the very left of the array to the very right. You can only see the `k` numbers in the window. Each time the sliding window moves right by one position.

Return the median array for each window in the original array. Answers within <code>10<sup>-5</sup></code> of the actual value will be accepted.

##### Example 1:

```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [1.00000,-1.00000,-1.00000,3.00000,5.00000,6.00000]
Explanation: 
Window position                Median
---------------                -----
[1  3  -1] -3  5  3  6  7        1
 1 [3  -1  -3] 5  3  6  7       -1
 1  3 [-1  -3  5] 3  6  7       -1
 1  3  -1 [-3  5  3] 6  7        3
 1  3  -1  -3 [5  3  6] 7        5
 1  3  -1  -3  5 [3  6  7]       6
```

##### Example 2:

```
Input: nums = [1,2,3,4,2,3,1,4,2], k = 3
Output: [2.00000,3.00000,3.00000,3.00000,2.00000,3.00000,2.00000]
```

##### Constraints:

- <code>1 <= k <= nums.length <= 10<sup>5</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

## Solution

```
import heapq

class SlidingWindowMedianFinder:
    INBIG, INSMALL = 0, 1
    def __init__(self, k):
        self.k = k
        self.big, self.small = [], []
        self.bigsize = self.smallsize = 0
        self.locations = {}
    
    def addgetmed(self, num, i):
        if i >= self.k:
            if self.locations[i - self.k] == self.INBIG:
                self.bigsize -= 1
            else:
                self.smallsize -= 1
            self.locations.pop(i - self.k)

        self._balance(i)
        if not self.small or num <= -self.small[0][0]:
            heapq.heappush(self.small, (-num, i))
            self.locations[i] = self.INSMALL
            self.smallsize += 1
        else:
            heapq.heappush(self.big, (num, i))
            self.locations[i] = self.INBIG
            self.bigsize += 1
        self._balance(i)

        self._lazyremove(i)
        totalsize = self.bigsize + self.smallsize
        if totalsize & 1:
            return self.big[0][0] if self.bigsize > self.smallsize else -self.small[0][0]
        return (self.big[0][0] + -self.small[0][0]) / 2
    
    def _lazyremove(self, i):
        while self.big and self.big[0][1] <= i - self.k:
            heapq.heappop(self.big)
        while self.small and self.small[0][1] <= i - self.k:
            heapq.heappop(self.small)
    
    def _balance(self, i):
        if abs(self.bigsize - self.smallsize) <= 1:
            return
        
        oversized, undersized = self.big, self.small
        if self.bigsize < self.smallsize:
            oversized, undersized = self.small, self.big
            self.bigsize += 1
            self.smallsize -= 1
        else:
            self.bigsize -= 1
            self.smallsize += 1

        self._lazyremove(i)
        popped = heapq.heappop(oversized)
        num, idx = popped
        num = -num
        self.locations[idx] = self.INBIG if oversized is self.small else self.INSMALL
        heapq.heappush(undersized, (num, idx))

# Time: O(nlog(n))
# Space: O(n) 
class Solution:
    def medianSlidingWindow(self, nums: List[int], k: int) -> List[float]:
        finder = SlidingWindowMedianFinder(k)
        for i in range(k - 1):
            finder.addgetmed(nums[i], i)
        return [finder.addgetmed(nums[i], i) for i in range(k - 1, len(nums))]
```

## Notes
- We use two heaps to implement a modified `MedianFinder`, `SlidingWindowMedianFinder`, to determine the median of a stream of numbers in constant time, with the caveat that streamed numbers outside the bounds of the `k` window get lazily removed from our heaps. This can be quite the implementation headache; the way I did it in the above solution is tracking the number of in bounds elements in each heap, which requires keeping track of which heap each element in the `SlidingWindowMedianFinder` resides.