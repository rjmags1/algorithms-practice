# 373. Find K Pairs with Smallest Sums - Medium

You are given two integer arrays `nums1` and `nums2` sorted in ascending order and an integer `k`.

Define a pair `(u, v)` which consists of one element from the first array and one element from the second array.

Return the `k` pairs `(u1, v1), (u2, v2), ..., (uk, vk)` with the smallest sums.

##### Example 1:

```
Input: nums1 = [1,7,11], nums2 = [2,4,6], k = 3
Output: [[1,2],[1,4],[1,6]]
Explanation: The first 3 pairs are returned from the sequence: [1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]
```

##### Example 2:

```
Input: nums1 = [1,1,2], nums2 = [1,2,3], k = 2
Output: [[1,1],[1,1]]
Explanation: The first 2 pairs are returned from the sequence: [1,1],[1,1],[1,2],[2,1],[1,2],[2,2],[1,3],[1,3],[2,3]
```

##### Example 3:

```
Input: nums1 = [1,2], nums2 = [3], k = 3
Output: [[1,3],[2,3]]
Explanation: All possible pairs are returned from the sequence: [1,3],[2,3]
```

##### Constraints:

- <code>1 <= nums1.length, nums2.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums1[i], nums2[i] <= 10<sup>9</sup></code>
- <code>1 <= k <= 10<sup>4</sup></code>
- `nums1` and `nums2` both are sorted in ascending order.

## Solution

```
import heapq

# Time: O(klog(k))
# Space: O(k)
class Solution:
    def kSmallestPairs(self, nums1: List[int], nums2: List[int], k: int) -> List[List[int]]:
        m, n = len(nums1), len(nums2)
        h = [(nums1[0] + nums2[0], 0, 0)]
        result = []
        seen = set()
        while h and len(result) < k:
            ps, i, j = heapq.heappop(h)
            if (i, j) in seen:
                continue
            seen.add((i, j))
            result.append([nums1[i], nums2[j]])
            if i < m - 1 and (i + 1, j) not in seen:
                heapq.heappush(h, (nums1[i + 1] + nums2[j], i + 1, j))
            if j < n - 1 and (i, j + 1) not in seen:
                heapq.heappush(h, (nums1[i] + nums2[j + 1], i, j + 1))
        return result
```

## Notes
- We are asked to find the `k` smallest of something, and since we cannot enumerate all possible pairs in quadratic time due to input constraints, heap or greedy should come to mind as possible approaches. With this in mind, heap is more general and so should try heap first before trying to mess around with greedy which is generally more difficult to intuit. Now, how to apply heap to this problem? We can think of pairs as nodes in a directed, cyclic graph, where each pair has directed edges to pairs corresponding to incrementing `i` or `j`. We can avoid enumerating all possible pairs by performing 'priority BFS' on this graph with the help of heap.