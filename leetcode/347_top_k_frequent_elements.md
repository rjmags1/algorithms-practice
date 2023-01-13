# 347. Top K Frequent Elements - Medium

Given an integer array `nums` and an integer `k`, return the `k` most frequent elements. You may return the answer in any order.

##### Example 1:

```
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]
```

##### Example 2:

```
Input: nums = [1], k = 1
Output: [1]
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-104 <= nums[i] <= 10<sup>4</sup></code>
- `k` is in the range `[1, the number of unique elements in the array]`.

Follow-up: Your algorithm's time complexity must be better than `O(n log n)`, where `n` is the array's size.

## Solution

```
# Time: O(n) avg O(n^2) worst case
# Space: O(n)
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        freqs = list(Counter(nums).items())
        n = len(freqs)
        target = n - k
        start, stop = 0, n - 1
        while start < stop:
            p = start
            pfreq = freqs[p][1]
            l, r = p + 1, stop
            while l <= r:
                lfreq, rfreq = freqs[l][1], freqs[r][1]
                if lfreq > pfreq and rfreq < pfreq:
                    freqs[l], freqs[r] = freqs[r], freqs[l]
                    lfreq, rfreq = freqs[l][1], freqs[r][1]
                if lfreq <= pfreq:
                    l += 1
                if rfreq >= pfreq:
                    r -= 1
            freqs[p], freqs[r] = freqs[r], freqs[p]
            if r == target:
                start = r
                break
            elif r < target:
                start = r + 1
            else:
                stop = r - 1
            
        return [v for v, c in freqs[start:]]
```

## Notes
- Whenever we need the __top `k`__ of something, we should consider using __heap__ or __quickselect__. However, since `k` can be the same as `n` for this question, and we are forbidden from solution with `O(nlog(n))` runtime, we should find a way to use something other than heap. There is a supposedly `O(nlog(k))` solution on leetcode that individually handles the case where `k == n` in constant time then goes forward with the heap solution, but `k` is still very much on the order of `n` in this solution, i.e. `k` could equal `n - 1` and we would end up essentially getting `O(nlog(n))` runtime. A linear approach would be optimal, and quickselect allows us to achieve this (on average) if we quickselect on the frequencies of elements.