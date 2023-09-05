# 239. Sliding Window Maximum - Hard

You are given an array of integers `nums`, there is a sliding window of size `k` which is moving from the very left of the array to the very right. You can only see the `k` numbers in the window. Each time the sliding window moves right by one position.

Return the max sliding window.

##### Example 1:

```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation: 
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
```

##### Example 2:

```
Input: nums = [1], k = 1
Output: [1]
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>
- <code>1 <= k <= nums.length</code>

## Solution 1

```
# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        h, result = [], []
        for i, num in enumerate(nums):
            heapq.heappush(h, (-num, i))
            if i < k - 1:
                continue
            while h[0][1] <= i - k:
                heapq.heappop(h)
            result.append(-h[0][0])
        return result
```

## Notes
- Fairly straightforward, just use a heap to keep track of the largest element in the current window, lazily removing heap elements that are outside of the current window from the heap.
- This approach passes but is not very efficient percentile wise because we can end up storing a linear amount of elements in a heap; consider an input such as `[1000, -1000, -1000, 1000, -1000, -1000, 1000, -1000, -1000, 1000, ...]` and `k = 3`. You could see all the negative elements would make it into the heap without making it out. For larger values of `k` and correspondingly larger valleys in the input, you could see how towards the end of the algorithm we would have approximately `n` elements in the heap.

## Solution 2

```
# Time: O(n)
# Space: O(k)
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        q, result = deque(), []
        for i, num in enumerate(nums):
            while q and q[0][1] <= i - k:
                q.popleft()
            while q and q[-1][0] < num:
                q.pop()
            q.append((num, i))
            if i < k - 1:
                continue
            result.append(q[0][0])
            
        return result
```

## Notes
- This solution is an improvement on the last, not just because we avoid bloating our data structure for tracking elements in the current window, but we also get constant addition and removal from this data structure.
- We can use a double-ended queue to track the maxes for current and subsequent sliding windows, if we take advantage of `O(1)` removal from either end of double-ended queue to maintain a queue that only contains elements in the current sliding window, __sorted in non-ascending__ order. 
- The tricky part of this problem is getting the non-ascending order part. Each time we add an element to the queue, there is no sense keeping elements in the queue that are smaller than it.