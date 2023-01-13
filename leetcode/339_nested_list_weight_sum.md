# 339. Nested List Weight Sum - Medium

You are given a nested list of integers `nestedList`. Each element is either an integer or a list whose elements may also be integers or other lists.

The depth of an integer is the number of lists that it is inside of. For example, the nested list `[1,[2,2],[[3],2],1]` has each integer's value set to its depth.

Return the sum of each integer in `nestedList` multiplied by its depth.

##### Example 1:

```
Input: nestedList = [[1,1],2,[1,1]]
Output: 10
Explanation: Four 1's at depth 2, one 2 at depth 1. 1*2 + 1*2 + 2*1 + 1*2 + 1*2 = 10.
```

##### Example 2:

```
Input: nestedList = [1,[4,[6]]]
Output: 27
Explanation: One 1 at depth 1, one 4 at depth 2, and one 6 at depth 3. 1*1 + 4*2 + 6*3 = 27.
```

##### Example 3:

```
Input: nestedList = [0]
Output: 0
```

##### Constraints:

- `1 <= nestedList.length <= 50`
- The values of the integers in the nested list is in the range `[-100, 100]`.
- The maximum depth of any integer is less than or equal to `50`.

## Solution 1

```
# Time: O(n + m) where n is number of lists and m is number of ints
# Space: O(d) where d is max depth
class Solution:
    def depthSum(self, nestedList: List[NestedInteger]) -> int:
        def rec(nl, depth):
            result = 0
            for n in nl:
                if n.isInteger():
                    result += n.getInteger() * depth
                else:
                    result += rec(n.getList(), depth + 1)
            return result
        
        return rec(nestedList, 1)
```

## Notes
- Depth first search!

## Solution 2

```
# Time: O(n + m)
# Space: O(n + m)
class Solution:
    def depthSum(self, nestedList: List[NestedInteger]) -> int:
        q = deque([(n, 1) for n in nestedList])
        result = 0
        while q:
            curr, d = q.popleft()
            if curr.isInteger():
                result += d * curr.getInteger()
            else:
                for n in curr.getList():
                    q.append((n, d + 1))
        return result
```

## Notes
- Breadth first search.