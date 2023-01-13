# 493. Reverse Pairs - Hard

Given an integer array `nums`, return the number of reverse pairs in the array.

A reverse pair is a pair `(i, j)` where:

- `0 <= i < j < nums.length` and
- `nums[i] > 2 * nums[j]`.

##### Example 1:

```
Input: nums = [1,3,2,3,1]
Output: 2
Explanation: The reverse pairs are:
(1, 4) --> nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) --> nums[3] = 3, nums[4] = 1, 3 > 2 * 1
```

##### Example 2:

```
Input: nums = [2,4,3,5,1]
Output: 3
Explanation: The reverse pairs are:
(1, 4) --> nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) --> nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) --> nums[3] = 5, nums[4] = 1, 5 > 2 * 1
```

##### Constraints:

- <code>1 <= nums.length <= 5 * 10<sup>4</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>

## Solution

```
from bisect import bisect_left

class BIT:
    def __init__(self, n):
        self.n = n
        self.bit = [0] * (n + 1)
    
    def rmb(self, k):
        return k & -k

    def update(self, val):
        k = val + 1
        while k <= self.n:
            self.bit[k] += 1
            k += self.rmb(k)
    
    def query(self, val):
        k, result = val + 1, 0
        while k > 0:
            result += self.bit[k]
            k -= self.rmb(k)
        return result

# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def reversePairs(self, nums: List[int]) -> int:
        ranks = sorted(list(set(nums)))
        n = len(ranks)
        maxnum = ranks[-1]
        bit = BIT(len(ranks))
        result = 0
        for num in nums:
            rankquery = bisect_left(ranks, 2 * num + 1)
            result += bit.query(n - 1) - bit.query(rankquery - 1)
            bit.update(bisect_left(ranks, num))
        return result
```

## Notes
- Anytime we need to query the number of elements with index `< i` that have some important property relative to the element at `i`, binary index tree of element ranks/virtual index is the way to go. Most other solutions to this problem and others like it rely on a modified merge-sort approach that is more of a headache in my opinion than the BIT approach. See notes of 327. Count of Range Sum for more details on this more advanced technique.