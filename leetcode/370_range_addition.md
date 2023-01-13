# 370. Range Addition - Medium

You are given an integer `length` and an array `updates` where `updates[i] = [startIdxi, endIdxi, inci]`.

You have an array `arr` of length `length` with all zeros, and you have some operation to apply on `arr`. In the `ith` operation, you should increment all the elements `arr[startIdxi], arr[startIdxi + 1], ..., arr[endIdxi]` by `inci`.

Return `arr` after applying all the updates.

##### Example 1:

```
Input: length = 5, updates = [[1,3,2],[2,4,3],[0,2,-2]]
Output: [-2,0,3,5,3]
```

##### Example 2:

```
Input: length = 10, updates = [[2,4,6],[5,6,8],[1,9,-4]]
Output: [0,-4,2,2,2,4,4,-4,-4,-4]
```

##### Constraints:

- <code>1 <= length <= 10<sup>5</sup></code>
- <code>0 <= updates.length <= 10<sup>4</sup></code>
- <code>0 <= startIdxi <= endIdxi < length</code>
- <code>-1000 <= inci <= 1000</code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def getModifiedArray(self, length: int, updates: List[List[int]]) -> List[int]:
        dp = [0] * (length + 1)
        for start, stop, inc in updates:
            dp[start] += inc
            dp[stop + 1] -= inc
        result = [dp[0]]
        for i in range(1, length):
            result.append(result[-1] + dp[i])
        return result
```

## Notes
- Instead of updating every single position listed in each interval of updates, we can consider the initial zero array of length `length` as a histogram, such that intervals of updates represent a relative increase and then decrease of size `inc` for the bars in the relevant range. If we record the cumulative of all rises and falls at each index, we can solve the question in linear time by adding the overall gain/loss at a particular index to the accumulation of all the gains and losses that came before it.