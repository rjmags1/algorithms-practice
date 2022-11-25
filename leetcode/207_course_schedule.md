# 207. Course Schedule - Medium

There are a total of `numCourses` courses you have to take, labeled from `0` to `numCourses - 1`. You are given an array prerequisites where `prerequisites[i] = [ai, bi]` indicates that you must take course `bi` first if you want to take course `ai`.

- For example, the pair `[0, 1]`, indicates that to take course `0` you have to first take course `1`.

Return `true` if you can finish all courses. Otherwise, return `false`.

##### Example 1:

```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0. So it is possible.
```

##### Example 2:

```
Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take. 
To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
```

##### Constraints:

- `1 <= numCourses <= 2000`
- `0 <= prerequisites.length <= 5000`
- `prerequisites[i].length == 2`
- `0 <= ai, bi < numCourses`
- All the pairs `prerequisites[i]` are unique.

## Solution 1

```
# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        g = {course: [] for course in range(numCourses)}
        for after, before in prerequisites:
            g[before].append(after)
        
        seen = [False] * numCourses
        inpath = seen[:]
        
        def detectcycle(course):
            if seen[course]: # do not redundantly explore sub-components
                return False
            if inpath[course]:
                return True
            
            inpath[course] = True
            for after in g[course]:
                if detectcycle(after):
                    return True
            inpath[course] = False
            seen[course] = True
        
        for course in g.keys():
            if course in seen:
                continue
            if detectcycle(course):
                return False
        
        return True
```

## Notes
- With a bit of thought it becomes clear that this is a graph problem involving directed edges. We are essentially being asked to determine whether the graph resulting from course prerequisites has any cycles or not. If there are cycles, it is implied that there is no way for us to take all courses, because a cycle would imply that in order to take a course `b` involved in a cycle, you would need to take a course `a` that it is a prerequisite of `b` but also in the cycle, but `a` is either a direct or indirect prerequisite of `b` by definition of cycle.
- Explore all components of a graph, making sure none of them contain cycles. We want to avoid redundant component exploration; in a case such as `5 -> 4 -> 3 -> 2 -> 1`, if we do not avoid redundant component exploration runtime could degenerate to <code>O(v<sup>2</sup> + e<sup>2</sup>)</code>. In other words, if we have already checked that some portion of our graph rooted from a particular node `x` does not have a cycle, there is no sense checking that portion again if we arrive at the `x` again in a later call to dfs.

## Solution 2

```
# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        g = defaultdict(list)
        indegree = defaultdict(int)
        for after, before in prerequisites:
            g[before].append(after)
            indegree[after] += 1
        q = deque([course for course in range(numCourses) 
                   if indegree[course] == 0])
        
        zeroindegree = 0
        while q:
            curr = q.popleft()
            zeroindegree += 1
            for after in g[curr]:
                indegree[after] -= 1
                if indegree[after] == 0:
                    q.append(after)
        
        return zeroindegree == numCourses
```

## Notes
- This is modified topological sort. Topological sort allows us to iterate through nodes in a graph in order of their dependencies, such that the nodes with the fewest dependencies come before nodes with more dependencies. Dependencies are directed edges such that a node with a dependency is reachable from another node, i.e., it depends on another node to get to it when traversing the graph. 
- Instead of actually generating a topologically sorted list of nodes, this modified version of top sort counts the number of nodes in the input that can have all of their incoming edges eliminated by processing nodes with less dependencies before it. If there is ever a node that cannot have all of its incoming edges removed in this fashion, that implies there is an incoming edge to it from a node with more dependencies (to the right in topologically sorted order), which means there is a cycle. Consider the following example:
    ```
    1 -> 2 -> 3
        ^     |
        |     v
        5 <- 4
    ```