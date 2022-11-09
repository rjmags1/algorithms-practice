# 133. Clone Graph - Medium

Given a reference of a node in a connected undirected graph.

Return a deep copy (clone) of the graph.

Each node in the graph contains a value (`int`) and a list (`List[Node]`) of its neighbors.

```
class Node {
    public int val;
    public List<Node> neighbors;
}
```

Test case format:

For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with `val == 1`, the second node with `val == 2`, and so on. The graph is represented in the test case using an adjacency list.

An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with `val = 1`. You must return the copy of the given node as a reference to the cloned graph.

##### Example 1:

```
Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
Output: [[2,4],[1,3],[2,4],[1,3]]
Explanation: There are 4 nodes in the graph.
1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
```

##### Example 2:

```
Input: adjList = [[]]
Output: [[]]
Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.
```

##### Example 3:

```
Input: adjList = []
Output: []
Explanation: This an empty graph, it does not have any nodes.
```

##### Constraints:

- The number of nodes in the graph is in the range `[0, 100]`.
- `1 <= Node.val <= 100`
- `Node.val` is unique for each node.
- There are no repeated edges and no self-loops in the graph.
- The Graph is connected and all nodes can be visited starting from the given node.

## Solution

```
# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def cloneGraph(self, node: 'Node') -> 'Node':
        if not node:
            return None
        
        clones = {}
        visited = set()
        q = deque([node])
        while q:
            curr = q.popleft()
            if curr.val in visited:
                continue
                
            visited.add(curr.val)
            if curr.val not in clones:
                clones[curr.val] = Node(curr.val, [])
            clone = clones[curr.val]
            for neighbor in curr.neighbors:
                if neighbor.val not in clones:
                    clones[neighbor.val] = Node(neighbor.val, [])
                clone.neighbors.append(clones[neighbor.val])
                if neighbor.val not in visited:
                    q.append(neighbor)
                    
        return clones[node.val]
```

## Notes
- We build clones lazily in this approach; because the input is connected, we don't have to worry about missing any nodes unreachable from `node`. The `clones` hash table allows us to access clones of original based on their number values. We can't use `clones` as a lookup for whether we have completely populated its `neighbors` value though, because that only happens when we visit the original during our bfs traversal of the original graph, hence the `visited` set.