# 624. Maximum Distance in Arrays - Medium

You are given `m` `arrays`, where each array is sorted in ascending order.

You can pick up two integers from two different arrays (each array picks one) and calculate the distance. We define the distance between two integers `a` and `b` to be their absolute difference `|a - b|`.

Return the maximum distance.

##### Example 1:

```
Input: arrays = [[1,2,3],[4,5],[1,2,3]]
Output: 4
Explanation: One way to reach the maximum distance 4 is to pick 1 in the first or third array and pick 5 in the second array.
```

##### Example 2:

```
Input: arrays = [[1],[1]]
Output: 0
```

##### Constraints:

- `m == arrays.length`
- <code>2 <= m <= 10<sup>5</sup></code>
- `1 <= arrays[i].length <= 500`
- <code>-10<sup>4</sup> <= arrays[i][j] <= 10<sup>4</sup></code>
- `arrays[i]` is sorted in ascending order.
- There will be at most <code>10<sup>5</sup></code> integers in all the arrays.

## Solution

```
# Time: O(m)
# Space: O(1)
class Solution:
    def maxDistance(self, arrays: List[List[int]]) -> int:
        min_seen = arrays[0][0]
        max_seen = arrays[0][-1]
        result = -inf
        for i in range(1, len(arrays)):
            result = max(result, abs(max_seen - arrays[i][0]))
            result = max(result, abs(arrays[i][-1] - min_seen))
            min_seen = min(min_seen, arrays[i][0])
            max_seen = max(max_seen, arrays[i][-1])
        
        return result
```

## Notes
- The max distance will be the difference between the smallest (`a`) and largest (`b`) integers in all of the `arrays`. `a` will occupy index `0` of its array and `b` will occupy index `-1` of its array. So just iterate through each array in `arrays`, keep track of smallest and largest integers seen so far, and see if the difference between max seen so far and min of current array, or difference between min seen so far and max of current array is the max distance. We do it this way to avoid returning a max distance that is the difference between integers of the same array, but also because it is useless to involve integers not at the ends of individual arrays, since those will never generate the max distance.
