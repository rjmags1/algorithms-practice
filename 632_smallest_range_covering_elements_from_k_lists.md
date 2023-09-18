# 632. Smallest Range Covering Elements from K Lists - Hard

You have `k` lists of sorted integers in non-decreasing order. Find the smallest range that includes at least one number from each of the `k` lists.

We define the range `[a, b]` is smaller than range `[c, d]` if `b - a < d - c` or `a < c` if `b - a == d - c`.

##### Example 1:

```
Input: nums = [[4,10,15,24,26],[0,9,12,20],[5,18,22,30]]
Output: [20,24]
Explanation: 
List 1: [4, 10, 15, 24,26], 24 is in range [20,24].
List 2: [0, 9, 12, 20], 20 is in range [20,24].
List 3: [5, 18, 22, 30], 22 is in range [20,24].
```

##### Example 2:

```
Input: nums = [[1,2,3],[1,2,3],[1,2,3]]
Output: [1,1]
```

##### Constraints:

- <code>nums.length == k</code>
- <code>1 <= k <= 3500</code>
- <code>1 <= nums[i].length <= 50</code>
- <code>-10<sup>5</sup> <= nums[i][j] <= 10<sup>5</sup></code>
- `nums[i]` is sorted in non-decreasing order.

## Solution 1

```
# Time: O(nlog(n)) where n is total numbers
# Space: O(n)
class Solution:
    def smallestRange(self, nums):
        minHeap = []
        for i, arr in enumerate(nums):
            heapq.heappush(minHeap, (arr[0], i, 0))
        sortedElems = []
        idxMap = []
        while len(minHeap) > 0:
            nextSmallest, i, j = heapq.heappop(minHeap)
            sortedElems.append(nextSmallest)
            idxMap.append(i)
            if j < len(nums[i]) - 1:
                heapq.heappush(minHeap, (nums[i][j + 1], i, j + 1))

        window, left, leftKIdx = {}, 0, idxMap[0]
        result = [sortedElems[0], sortedElems[-1]]
        k = len(nums)
        for right, num in enumerate(sortedElems):
            kIdx = idxMap[right]
            if kIdx not in window:
                window[kIdx] = 0
            window[kIdx] += 1

            while len(window) == k:
                if result[-1] - result[0] > num - sortedElems[left]:
                    result = [sortedElems[left], num]
                window[leftKIdx] -= 1
                if window[leftKIdx] == 0:
                    del window[leftKIdx]
                left += 1
                leftKIdx = idxMap[left] if left < len(sortedElems) else None

        return result
```

## Notes
- We can convert to sliding window problem such that we look for the sliding window with the smallest range `[a, b]`, where ranges are only considered if they contain numbers from all of the arrays within `nums`.

## Solution 2

```
import heapq

# Time: O(mlog(k)) where m is max length of any nums[i]
# Space: O(k)
class Solution:
    def smallestRange(self, nums: List[List[int]]) -> List[int]:
        k = len(nums)
        h = [(nums[i][0], i, 0) for i in range(k)]
        heapq.heapify(h)

        curr_max = max(x[0] for x in nums)
        result = [-10e5, 10e5]
        while len(h) == k:
            curr_min, i, j = heapq.heappop(h)
            if curr_max - curr_min < result[1] - result[0]:
                result = [curr_min, curr_max]
            if j < len(nums[i]) - 1:
                curr_max = max(curr_max, nums[i][j + 1])
                heapq.heappush(h, (nums[i][j + 1], i, j + 1))

        return result
```

## Notes
- Greedily consider sets of numbers from all arrays in `nums` such that we are always trying to increase the minimum of the previous set. Doing this guarantees that we will eventually encounter the min range containing a number from each array in `nums`.