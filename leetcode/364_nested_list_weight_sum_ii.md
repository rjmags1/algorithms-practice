# 364. Nested List Weight Sum II - Medium

You are given a nested list of integers `nestedList`. Each element is either an integer or a list whose elements may also be integers or other lists.

The depth of an integer is the number of lists that it is inside of. For example, the nested list `[1,[2,2],[[3],2],1]` has each integer's value set to its depth. Let `maxDepth` be the maximum depth of any integer.

The weight of an integer is `maxDepth - (the depth of the integer) + 1`.

Return the sum of each integer in `nestedList` multiplied by its weight.

##### Example 1:

```
Input: nestedList = [[1,1],2,[1,1]]
Output: 8
Explanation: Four 1's with a weight of 1, one 2 with a weight of 2.
1*1 + 1*1 + 2*2 + 1*1 + 1*1 = 8
```

##### Example 2:

```
Input: nestedList = [1,[4,[6]]]
Output: 17
Explanation: One 1 at depth 3, one 4 at depth 2, and one 6 at depth 1.
1*3 + 4*2 + 6*1 = 17
```

##### Constraints:

- `1 <= nestedList.length <= 50`
- The values of the integers in the nested list is in the range `[-100, 100]`.
- The maximum depth of any integer is less than or equal to `50`.

## Solution

```
from collections import defaultdict

# Time: O(k) where k = num integers plus num lists
# Space: O(n) where n = num integers plus num depths
class Solution:
    def depthSumInverse(self, nestedList: List[NestedInteger]) -> int:
        depths, maxd = defaultdict(list), -math.inf
        def rec(nl, d):
            nonlocal maxd
            for ni in nl:
                maxd = max(maxd, d)
                if ni.isInteger():
                    depths[d].append(ni.getInteger())
                else:
                    rec(ni.getList(), d + 1)

        rec(nestedList, 1)
        weighted = lambda d, x: (maxd - d + 1) * x
        result = 0
        for d, nums in depths.items():
            for x in nums:
                result += weighted(d, x)
        return result
```

## Notes
- Prompt should say `maxDepth` is maximum `NestedInteger` depth, not max integer depth. Anyway besides dealing with the prompt and `NestedInteger` API this question is basic graph traversal. With DFS we need to traverse twice to get max depth and then calculate summation, unless we use the idea of summation/basic arithmetic to calculate the `sum(maxdepth * ints) - sum(depth * ints) + sum(ints)`. One could also use bfs to do this in one pass.