# 444. Sequence Reconstruction - Medium

You are given an integer array `nums` of length `n` where `nums` is a permutation of the integers in the range `[1, n]`. You are also given a 2D integer array `sequences` where `sequences[i]` is a subsequence of `nums`.

Check if `nums` is the shortest possible and the only supersequence. The shortest supersequence is a sequence with the shortest length and has all `sequences[i]` as subsequences. There could be multiple valid supersequences for the given array `sequences`.

- For example, for `sequences = [[1,2],[1,3]]`, there are two shortest supersequences, `[1,2,3]` and `[1,3,2]`.
- While for `sequences = [[1,2],[1,3],[1,2,3]]`, the only shortest supersequence possible is `[1,2,3]`. `[1,2,3,4]` is a possible supersequence but not the shortest.

Return `true` if `nums` is the only shortest supersequence for `sequences`, or `false` otherwise.

A subsequence is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.

##### Example 1:

```
Input: nums = [1,2,3], sequences = [[1,2],[1,3]]
Output: false
Explanation: There are two possible supersequences: [1,2,3] and [1,3,2].
The sequence [1,2] is a subsequence of both: [1,2,3] and [1,3,2].
The sequence [1,3] is a subsequence of both: [1,2,3] and [1,3,2].
Since nums is not the only shortest supersequence, we return false.
```

##### Example 2:

```
Input: nums = [1,2,3], sequences = [[1,2]]
Output: false
Explanation: The shortest possible supersequence is [1,2].
The sequence [1,2] is a subsequence of it: [1,2].
Since nums is not the shortest supersequence, we return false.
```

##### Example 3:

```
Input: nums = [1,2,3], sequences = [[1,2],[1,3],[2,3]]
Output: true
Explanation: The shortest possible supersequence is [1,2,3].
The sequence [1,2] is a subsequence of it: [1,2,3].
The sequence [1,3] is a subsequence of it: [1,2,3].
The sequence [2,3] is a subsequence of it: [1,2,3].
Since nums is the only shortest supersequence, we return true.
```

##### Constraints:

- <code>n == nums.length</code>
- <code>1 <= n <= 10<sup>4</sup></code>
- <code>1 <= sequences.length <= 10<sup>4</sup></code>
- <code>1 <= sequences[i].length <= 10<sup>4</sup></code>
- <code>1 <= sum(sequences[i].length) <= 10<sup>5</sup></code>
- <code>1 <= sequences[i][j] <= n</code>
- `nums` is a permutation of all the integers in the range `[1, n]`.
- All the arrays of `sequences` are unique.
- `sequences[i]` is a subsequence of `nums`.

## Solution

```
from collections import defaultdict

# Time: O(n + m)
# Space: O(n)
class Solution:
    def sequenceReconstruction(self, nums: List[int], sequences: List[List[int]]) -> bool:
        g = defaultdict(set)
        n = len(nums)
        indegree = {node: set() for node in range(1, n + 1)}
        for seq in sequences:
            for i in range(1, len(seq)):
                a, b = seq[i - 1], seq[i]
                g[a].add(b)
                indegree[b].add(a)
        q = [node for node, indeg in indegree.items() if len(indeg) == 0]
        seqlen = 0
        while q:
            if len(q) > 1:
                return False
            curr = q.pop()
            seqlen += 1
            for node in g[curr]:
                indegree[node].remove(curr)
                if len(indegree[node]) == 0:
                    q.append(node)

        return seqlen == n
```

## Notes
- `nums` is the only possible supersequence of minimal length of all `sequences` if it is the only topological order of numbers that respects all of the orderings specified in `sequences`. All we need to do for this question is run top sort using all the relative orderings in `sequences` as edges in a graph. If there is ever more than `1` element in the zero indegree queue after processing the previous top sorted element, there are multiple possible topological orderings; if the topological order does not include all the elements in `nums`, there is no valid topological order.