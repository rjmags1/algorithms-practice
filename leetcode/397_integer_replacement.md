# 397. Integer Replacement - Medium

Given a positive integer `n`, you can apply one of the following operations:

- If `n` is even, replace `n` with `n / 2`.
- If `n` is odd, replace `n` with either `n + 1` or `n - 1`.

Return the minimum number of operations needed for `n` to become `1`.

##### Example 1:

```
Input: n = 8
Output: 3
Explanation: 8 -> 4 -> 2 -> 1
```

##### Example 2:

```
Input: n = 7
Output: 4
Explanation: 7 -> 8 -> 4 -> 2 -> 1
or 7 -> 6 -> 3 -> 2 -> 1
```

##### Example 3:

```
Input: n = 4
Output: 2
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
from collections import deque

Time: O(n)
Space: O(n)
class Solution:
    def integerReplacement(self, n: int) -> int:
        q = deque([(n, 0)])
        seen = set()
        while q:
            curr, steps = q.popleft()
            if curr == 1:
                return steps
            if curr in seen:
                continue

            seen.add(curr)
            if curr & 1:
                if curr + 1 not in seen:
                    q.append((curr + 1, steps + 1))
                if curr - 1 not in seen:
                    q.append((curr - 1, steps + 1))
            elif curr // 2 not in seen:
                q.append((curr // 2, steps + 1))
```

## Notes
- The time and space complexity is a rough upper bound, and comes from the fact that <code>2<sup>log<sub>2</sub>x</sup> ~ x</code>. The actual runtime tends to be closer to logarithmic. 
- We are essentially navigating a binary tree rooted at `n` with BFS; nodes with odd value have `2` children and those with even values have `1`. We do not re-explore previously seen nodes because that would be inefficient, ie, would result in a non-minimal length operations sequence.
- In general for math questions that involve specific state transitions, if you can't figure out the formula right away/need a formal proof considering a bfs approach is always a good alternative. A similar problem that comes to mind for this is the Jug Problem (Leetcode 365).