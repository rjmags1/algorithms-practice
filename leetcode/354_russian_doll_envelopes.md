# 354. Russian Doll Envelopes - Hard

You are given a 2D array of integers `envelopes` where `envelopes[i] = [wi, hi]` represents the width and the height of an envelope.

One envelope can fit into another if and only if both the width and height of one envelope are greater than the other envelope's width and height.

Return the maximum number of envelopes you can Russian doll (i.e., put one inside the other).

Note: You cannot rotate an envelope.

##### Example 1:

```
Input: envelopes = [[5,4],[6,4],[6,7],[2,3]]
Output: 3
Explanation: The maximum number of envelopes you can Russian doll is 3 ([2,3] => [5,4] => [6,7]).
```

##### Example 2:

```
Input: envelopes = [[1,1],[1,1],[1,1]]
Output: 1
```

##### Constraints:

- <code>envelopes[i].length == 2</code>
- <code>1 <= envelopes.length <= 10<sup>5</sup></code>
- <code>1 <= wi, hi <= 10<sup>5</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def maxEnvelopes(self, envelopes: List[List[int]]) -> int:
        envelopes.sort(key=lambda e: (e[0], -e[1]))
        result = [envelopes[0][1]]
        for i in range(1, len(envelopes)):
            w, h = envelopes[i]
            k = bisect_left(result, h)
            if k == len(result):
                result.append(h)
            else:
                result[k] = h
        return len(result)
```

## Notes
- To solve this question we need to find the length of the longest increasing subsequence, but of 2-dimensional elements. To do this naively, we would need to use quadratic time; this would involve sorting and then using a dp array to store the biggest doll that can be formed with a particular envelope as the outer layer, and for each doll looking at all the dolls smaller than the current one and filling in `dp[i]` for this doll. This strategy is not feasible based on the given input constraints. We need to find `O(nlog(n))` or better.
- This algorithm is a little controversial - an appropriate name would be LIS-length - because it finds the length of the longest increasing subsequence in better than quadratic time without actually building the correct subsequence.