# 295. Find Median From Data Stream - Hard

The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value, and the median is the mean of the two middle values.

- For example, for `arr = [2,3,4]`, the median is `3`.
- For example, for `arr = [2,3]`, the `median is (2 + 3) / 2 = 2.5`.

Implement the MedianFinder class:

- `MedianFinder()` initializes the `MedianFinder` object.
- `void addNum(int num)` adds the integer `num` from the data stream to the data structure.
- `double findMedian()` returns the median of all elements so far. Answers within <code>10<sup>-5</sup></code> of the actual answer will be accepted.


##### Example 1:

```
Input
["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
[[], [1], [2], [], [3], []]
Output
[null, null, null, 1.5, null, 2.0]

Explanation
MedianFinder medianFinder = new MedianFinder();
medianFinder.addNum(1);    // arr = [1]
medianFinder.addNum(2);    // arr = [1, 2]
medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
medianFinder.addNum(3);    // arr[1, 2, 3]
medianFinder.findMedian(); // return 2.0
```

##### Constraints:

- <code>-10<sup>5</sup> <= num <= 10<sup>5</sup></code>
- There will be at least one element in the data structure before calling `findMedian`.
- At most <code>5 * 10<sup>4</sup></code> calls will be made to `addNum` and `findMedian`.

##### Follow-up: 

- If all integer numbers from the stream are in the range `[0, 100]`, how would you optimize your solution?
- If 99% of all integer numbers from the stream are in the range `[0, 100]`, how would you optimize your solution?

## Solution

```
# Overall Space:  O(n)
class MedianFinder:
    def __init__(self):
        self.small = []
        self.large = []

    # Time: O(log(n))
    def addNum(self, num: int) -> None:
        if not self.small and not self.large:
            self.small.append(-num)
            return
        if not self.large:
            if num < -self.small[0]:
                self.large.append(-self.small.pop())
                self.small.append(-num)
            else:
                self.large.append(num)
            return
        
        largestSmall, smallestLarge = -self.small[0], self.large[0]
        if num < largestSmall:
            heapq.heappush(self.small, -num)
        else:
            heapq.heappush(self.large, num)
            
        self.resize()
    
    # Time: O(log(n))
    def resize(self):
        m, n = len(self.small), len(self.large)
        if abs(m - n) < 2:
            return
        oversized = self.small if m > n else self.large
        undersized = self.large if m > n else self.small
        heapq.heappush(undersized, -heapq.heappop(oversized))

    # Time: O(1)
    def findMedian(self) -> float:
        m, n = len(self.small), len(self.large)
        if m - n == 0:
            return (-self.small[0] + self.large[0]) / 2
        return -self.small[0] if m > n else self.large[0]
```

## Notes
- To find the median we always want to know about the numbers at the midpoint of the sorted array of added numbers. More specifically, if there is an even number of total numbers, we need to know about the `2` central elements, otherwise just the middle one. If we maintain a max heap for the small numbers (left side of sorted array) and a min heap for the large numbers (right side of center of sorted array), we can always know the center numbers at any given time. The standard python `heapq` functionality is min heap, but we can easily convert to max heap by flipping the sign of heap elements.
- To ensure the tops of the heaps always point to the smallest number in the right half of the sorted array of added numbers and the largest number in the left half of the sorted array of added numbers, we need to resize them if one ever gets `2` larger in size than the other. This is trivial; just remove the top of the oversized heap and put it into the undersized heap. This is all we need to because the top of the small half will be the largest number in its heap, and the top of the large half will be the smallest number in its heap. 
- To address the followups, if we know added numbers are going to be in a reasonably sized range, we can just bucket the numbers via frequency array and keep track of the total numbers added. To find the median, we just do `total / 2`, and then iterate over the frequencies until we get to the number whose frequency causes the remaining of `total / 2` to become negative or zero. If there are going to be a minimal number of outliers, we can add 2 buckets, one for outliers lower than the range lower bound and another for outliers higher than the range upper bound.