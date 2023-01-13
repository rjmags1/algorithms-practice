# 332. Reconstruct Itinerary - Hard

You are given a list of airline `tickets` where `tickets[i] = [fromi, toi]` represent the departure and the arrival airports of one flight. Reconstruct the itinerary in order and return it.

All of the tickets belong to a man who departs from `"JFK"`, thus, the itinerary must begin with `"JFK"`. If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string.

For example, the itinerary `["JFK", "LGA"]` has a smaller lexical order than `["JFK", "LGB"]`.

You may assume all tickets form at least one valid itinerary. You must use all the tickets once and only once.

##### Example 1:

```
Input: tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
Output: ["JFK","MUC","LHR","SFO","SJC"]
```

##### Example 2:

```
Input: tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]
Explanation: Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"] but it is larger in lexical order.
```

##### Constraints:

- `1 <= tickets.length <= 300`
- `tickets[i].length == 2`
- `fromi.length == 3`
- `toi.length == 3`
- `fromi` and `toi` consist of uppercase English letters.
- `fromi != toi`

## Solution 1

```
# Time: O(e!)
# Space: O(v + e)
class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        g = defaultdict(lambda: [[], [], 0])
        for f, d in tickets:
            g[f][0].append(d)
            g[f][1].append(False)
        for f in g.keys():
            g[f][0].sort()
        
        builder, n = [], len(tickets)
        def dfs(node):
            builder.append(node)
            if len(builder) == n + 1:
                return True
            dests, traversed, used = g[node]
            if used == len(traversed):
                builder.pop()
                return False
            
            g[node][2] += 1
            for i, d in enumerate(dests):
                if traversed[i]:
                    continue
                traversed[i] = True
                if dfs(d):
                    return True
                traversed[i] = False
                
            g[node][2] -= 1
            builder.pop()
            return False
                
        dfs("JFK")
        return builder
```

## Notes
- To get the lexicographically smallest itinerary, we need to always attempt to use the next smallest unused edge from the current location, where the next smallest unused edge has the lexicographically smallest destination compared to all the other unused edges. The first itinerary we can build of length `n + 1` will be our answer, because given `n` tickets we will make `n + 1` airport visits.
- To do this, we must keep track of which edges have been used/traversed for each particular airport and which have not. We can cut down on runtime by keeping track of the number of used edges for each node, and if we ever get to a point where the current node/airport has all of its edges used but we have not built a sufficiently large itinerary, we can backtrack without looping through all the previously used edges.
- In terms of time complexity, this is a challenging problem to analyze because it is valid to have airports have multiple flights going back and forth to one another, i.e., cycles may exist in the desired itinerary. However as a very loose upper bound we could use the permutation of all flights, which is factorial in nature.

## Solution 2

```
# Time: O(elog(e))
# Space: O(v + e)
class Solution:
    def findItinerary(self, tickets: List[List[str]]) -> List[str]:
        g = defaultdict(list)
        for f, d in tickets:
            g[f].append(d)
        for f in g.keys():
            g[f].sort(reverse=True)
        
        result = []
        def dfs(node):
            while g[node]:
                dfs(g[node].pop())
            result.append(node)
        
        dfs("JFK")
        return result[::-1]
```

## Notes
- This solution requires an understanding of euler's path, which is a simple concept in its definition but more difficult in terms of understanding how to determine it algorithmically. Euler path in a graph is a path through the graph that traverses each edge exactly once. The idea behind Hierholzers algorithm, which is a way of determining if an euler path exists in a graph in `O(edges)` time, kicks off by locating an appropriate starting node from which to start traversing each edge. Note that for all edges to be traversed, all edges must lie in the same component of a graph - some people say this is the definition of connected, but others say connected implies all edges *and nodes* lie in the same component. The key thing to keep in mind for euler path/hierholzer is an euler path must exist in an undirected graph that has all edges in the same component if there are exactly 0 or 2 nodes with odd degree; similarly for directed graph with all edges in the same component an euler path must exist if there is exactly 1 node with one more outgoing edge than incoming and 1 node with one more incoming edge than outgoing, or zero of neither, and the rest have an even number of incoming and outgoing edges. Odd degree nodes in undirected graph and extra outgoing edge for directed graph are appropriate start locations. Euler circuit is the same idea except deadend paths are excluded from consideration (in other words, 2 odd degrees for undirected or the 1-and-1 for directed is not a euler circuit). Note that all euler circuits are also euler paths.
- For this problem, however, we do not need to worry about ensuring a euler path exists or locating the appropriate start because we have a fixed starting point and are guaranteed by prompt that euler path exists (there is some series of flights that allows us to visit all edges AKA reconstruct the itinerary). So we can just apply hierholzer straightaway, with the caveat that we sort outgoing connections of each airport in ascending order (this ends up dominating our time complexity). This guarantees that the eulerian path we find will be as small as possible lexicographically.
- Because of the great number of shapes graphs can have, it is probably best at first to treat hierholzer as a black box, because it is interesting that it works for all varieties of subcycle shapes as long as there is euler path in the graph. The core logic is that every time we visit a node, we add it to the result order but only after we have visited all of its remaining edges.
- Note how the above implementation ensures that if there is a deadend path, it will end up last in the returned result. There are more idiomatic and code-heavy ways of ensuring the traversal visits the deadend path last (i.e. predetermining the last node in the deadend path based on number of incoming edges) but sticking with this slick implementation style from "the man" Stefan Pochmann.