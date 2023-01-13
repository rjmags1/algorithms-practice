# 399. Evaluate Division - Medium

You are given an array of variable pairs `equations` and an array of real numbers `values`, where `equations[i] = [Ai, Bi]` and `values[i]` represent the equation `Ai / Bi = values[i]`. Each `Ai` or `Bi` is a string that represents a single variable.

You are also given some `queries`, where `queries[j] = [Cj, Dj]` represents the `jth` query where you must find the answer for `Cj / Dj = ?`.

Return the answers to all queries. If a single answer cannot be determined, return `-1.0`.

Note: The input is always valid. You may assume that evaluating the queries will not result in division by zero and that there is no contradiction.

##### Example 1:

```
Input: equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]
Output: [6.00000,0.50000,-1.00000,1.00000,-1.00000]
Explanation: 
Given: a / b = 2.0, b / c = 3.0
queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ?
return: [6.0, 0.5, -1.0, 1.0, -1.0 ]
```

##### Example 2:

```
Input: equations = [["a","b"],["b","c"],["bc","cd"]], values = [1.5,2.5,5.0], queries = [["a","c"],["c","b"],["bc","cd"],["cd","bc"]]
Output: [3.75000,0.40000,5.00000,0.20000]
```

##### Example 3:

```
Input: equations = [["a","b"]], values = [0.5], queries = [["a","b"],["b","a"],["a","c"],["x","y"]]
Output: [0.50000,2.00000,-1.00000,-1.00000]
```

##### Constraints:

- `1 <= equations.length <= 20`
- `equations[i].length == 2`
- `1 <= Ai.length, Bi.length <= 5`
- `values.length == equations.length`
- `0.0 < values[i] <= 20.0`
- `1 <= queries.length <= 20`
- `queries[i].length == 2`
- `1 <= Cj.length, Dj.length <= 5`
- `Ai, Bi, Cj, Dj` consist of lower case English letters and digits.

## Solution

```
from collections import defaultdict, deque

# Time: O(q * (v + e))
# Space: O(v + e)
class Solution:
    def calcEquation(self, equations: List[List[str]], values: List[float], queries: List[List[str]]) -> List[float]:
        FORWARD, REVERSE = 0, 1
        g, n = defaultdict(list), len(equations)
        def bfs(start, target):
            if start == target:
                return 1, 1
            q = deque([(start, 1, 1)])
            seen = set()
            while q:
                curr, num, den = q.popleft()
                if curr in seen:
                    continue
                if curr == target:
                    return num, den
                seen.add(curr)
                for neighbor, weight, direction in g[curr]:
                    if neighbor in seen:
                        continue
                    num2 = num * weight if direction == FORWARD else num
                    den2 = den * weight if direction == REVERSE else den
                    q.append((neighbor, num2, den2))

            return -1, -1

        for i in range(n):
            (a, b), v = equations[i], values[i]
            g[a].append((b, v, FORWARD))
            g[b].append((a, v, REVERSE))

        result = []
        for a, b in queries:
            if a not in g or b not in g:
                result.append(-1.0)
                continue
            num, den = bfs(a, b)
            if num == -1:
                result.append(-1.0)
            else:
                result.append(num / den)

        return result
```

## Notes
- Each equation represents an edge in an undirected graph. We can use bfs or dfs to find the path that represents the answer to a particular query, and we do not need to worry about multiple paths existing because we are told there are no contradictions in the input in the prompt. We need to be careful about not dividing in each step of the path search for a query because the final answer will not be as accurate due to float imprecision as if we accumulate the appropriate numerator and denominator of the final result during our path search.