# 433. Minimum Genetic Mutation - Medium

A gene string can be represented by an 8-character long string, with choices from `'A'`, `'C'`, `'G'`, and `'T'`.

Suppose we need to investigate a mutation from a gene string `startGene` to a gene string `endGene` where one mutation is defined as one single character changed in the gene string.

- For example, `"AACCGGTT" --> "AACCGGTA"` is one mutation.

There is also a gene bank `bank` that records all the valid gene mutations. A gene must be in `bank` to make it a valid gene string.

Given the two gene strings `startGene` and `endGene` and the gene bank `bank`, return the minimum number of mutations needed to mutate from `startGene` to `endGene`. If there is no such a mutation, return `-1`.

Note that the starting point is assumed to be valid, so it might not be included in the bank.

##### Example 1:

```
Input: startGene = "AACCGGTT", endGene = "AACCGGTA", bank = ["AACCGGTA"]
Output: 1
```

##### Example 2:

```
Input: startGene = "AACCGGTT", endGene = "AAACGGTA", bank = ["AACCGGTA","AACCGCTA","AAACGGTA"]
Output: 2
```

##### Constraints:

- `0 <= bank.length <= 10`
- `startGene.length == endGene.length == bank[i].length == 8`
- `startGene`, `endGene`, and `bank[i]` consist of only the characters `['A', 'C', 'G', 'T']`.

## Solution

```
from collections import defaultdict, deque

# Time: O(n)
# Space: O(n^2)
class Solution:
    def minMutation(self, startGene: str, endGene: str, bank: List[str]) -> int:
        g = defaultdict(list)
        bank.append(startGene)
        sbank = set(bank)
        for node in sbank:
            for node2 in sbank:
                if node == node2:
                    continue
                if len([i for i in range(8) if node[i] != node2[i]]) == 1:
                    g[node].append(node2)
                    g[node2].append(node)

        q = deque([(startGene, 0)])
        seen = set()
        while q:
            gene, steps = q.popleft()
            if gene in seen:
                continue
            if gene == endGene:
                return steps
            
            seen.add(gene)
            for neighbor in g[gene]:
                if neighbor not in seen:
                    q.append((neighbor, steps + 1))

        return -1
```

## Notes
- BFS. Note we really don't need to construct a graph for this problem because of the small number of nodes, which would reduce space complexity to constant. Note how BFS guarantees we find the shortest path.