# 275. H-Index II - Medium

Given an array of integers `citations` where `citations[i]` is the number of citations a researcher received for their `ith` paper and `citations` is sorted in an ascending order, return compute the researcher's `h`-index.

According to the definition of h-index on Wikipedia: A scientist has an index `h` if `h` of their `n` papers have at least `h` citations each, and the other `n − h` papers have no more than `h` citations each.

If there are several possible values for `h`, the maximum one is taken as the `h`-index.

You must write an algorithm that runs in logarithmic time.

##### Example 1:

```
Input: citations = [0,1,3,5,6]
Output: 3
Explanation: [0,1,3,5,6] means the researcher has 5 papers in total and each of them had received 0, 1, 3, 5, 6 citations respectively.
Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, their h-index is 3.
```

##### Example 2:

```
Input: citations = [1,2,100]
Output: 2
```

##### Constraints:

- <code>1 <= n <= 10<sup>5</sup></code>
- `n == citations.length`
- `0 <= citations[i] <= 1000`
- `citations` is sorted in ascending order.

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def hIndex(self, citations: List[int]) -> int:
        n = len(citations)
        l, r = 0, n - 1
        while l < r:
            mid = (l + r) // 2
            paperc = citations[mid]
            h = n - mid
            if paperc >= h:
                r = mid
            else:
                l = mid + 1
        return n - r if citations[r] > 0 else 0
```

## Notes
- Like the other h-index problem, we are looking for the smallest element `k` which is greater than or equal to the number of elements (including itself) greater than the magnitude of the `k`. Since we are given an array of numbers in ascending sorted order, we can perform binary search to find this `k` in logarithmic time.
- We also need to look out for the special case where none of the researcher's papers have any citations. In this case, the h-index will always be zero.  