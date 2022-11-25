# 269. Alien Dictionary - Hard

There is a new alien language that uses the English alphabet. However, the order among the letters is unknown to you.

You are given a list of strings `words` from the alien language's dictionary, where the strings in `words` are sorted lexicographically by the rules of this new language.

Return a string of the unique letters in the new alien language sorted in lexicographically increasing order by the new language's rules. If there is no solution, return `""`. If there are multiple solutions, return any of them.

##### Example 1:

```
Input: words = ["wrt","wrf","er","ett","rftt"]
Output: "wertf"
```

##### Example 2:

```
Input: words = ["z","x"]
Output: "zx"
```

##### Example 3:

```
Input: words = ["z","x","z"]
Output: ""
Explanation: The order is invalid, so return "".
```

##### Constraints:

- `1 <= words.length <= 100`
- `1 <= words[i].length <= 100`
- `words[i]` consists of only lowercase English letters.

## Solution

```
# Time: O(n^2)
# Space: O(c^2) where n is len(words) and c is number of unique characters
class Solution:
    def firstdiff(self, x, y):
        m, n = len(x), len(y)
        for i in range(min(len(x), len(y))):
            if x[i] != y[i]:
                return x[i], y[i]
        return None, None
    
    def alienOrder(self, words: List[str]) -> str:
        copy = []
        for i, w in enumerate(words):
            if i == 0:
                copy.append(w)
                continue
            prev = words[i - 1]
            if len(prev) > len(w) and prev[:len(w)] == w:
                return ""
            if w != prev:
                copy.append(w)
        words = copy
        
        n = len(words)
        g = defaultdict(set)
        indegree = defaultdict(int)
        for i, before in enumerate(words):
            for c in before:
                indegree[c] += 0
            if i == n - 1:
                break
            after = words[i + 1]
            parent, child = self.firstdiff(before, after)
            if parent:
                if child not in g[parent]:
                    indegree[child] += 1
                g[parent].add(child)
        
        edges, chars = len(g), list(indegree.keys())
        if edges == 0:
            return "".join(chars)
        
        roots = [l for l, indeg in indegree.items() if indeg == 0]
        q = deque(roots)
        order = []
        while q:
            curr = q.popleft()
            order.append(curr)
            for child in g[curr]:
                indegree[child] -= 1
                if indegree[child] == 0:
                    q.append(child)
                    
        return "".join(order) if len(order) == len(chars) else ""
```

## Notes
- Exceedingly tedious problem. Model relevant single letter orderings as edges in a directed graph and then do top sort on the graph. Need to watch out for edge cases where we are given an invalid order, i.e., a prefix of a word in the dictionary comes after the longer word, which is annoying because Leetcode typically does not bother their users with obviously invalid inputs. 
- Also need to make sure you check the graph for cycles because if there are some then it is impossible to construct a valid letter ordering. This could be done with basic dfs cycle check or run top sort and realize that any cycle nodes will not make it into top sort ordering, and so if the top sort order is less than the number of characters we will know there is a cycle in the graph and so it is impossible to form a valid letter ordering.
- Though it is not conceptually incorrect to compare every word against every other word and get the first letter difference between them, this version of the solution will TLE on leetcode. This makes sense because doing so adds redundant (though not duplicate) edges to the graph and will largely slow down the top sort, but was a large source of my struggles with this problem.