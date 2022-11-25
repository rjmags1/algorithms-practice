# 210. Course Schedule II - Medium

There are a total of `numCourses` courses you have to take, labeled from `0` to `numCourses - 1`. You are given an array prerequisites where `prerequisites[i] = [ai, bi]` indicates that you must take course `bi` first if you want to take course `ai`.

- For example, the pair `[0, 1]`, indicates that to take course `0` you have to first take course `1`.

Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

##### Example 1:

```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: [0,1]
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
```

##### Example 2:

```
Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
Output: [0,2,1,3]
Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
```

##### Example 3:

```
Input: numCourses = 1, prerequisites = []
Output: [0]
```

##### Constraints:

- `1 <= numCourses <= 2000`
- `0 <= prerequisites.length <= numCourses * (numCourses - 1)`
- `prerequisites[i].length == 2`
- `0 <= ai, bi < numCourses`
- `ai != bi`
- All the pairs `[ai, bi]` are distinct.

## Solution

```
# Time: O(v + e)
# Space: O(v + e)
class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        g, indegree = defaultdict(list), defaultdict(int)
        for after, before in prerequisites:
            g[before].append(after)
            indegree[after] += 1
        
        q = deque([course for course in range(numCourses) 
                   if course not in indegree])
        result = []
        while q:
            curr = q.popleft()
            result.append(curr)
            for after in g[curr]:
                indegree[after] -= 1
                if indegree[after] == 0:
                    q.append(after)
        
        return result if len(result) == numCourses else []
```

## Notes
- This is a direct application of topological sort. The algorithm will exit once there are no more nodes with `0` indegree, and there is only a topological order containing all courses if all nodes/courses in the graph have been visited during the main run of the algorithm. 
- The algorithm is essentially doing the following: visit all the nodes that have no incoming edges (AKA take all courses that have no prereqs); then visit all of the nodes that had a node with no incoming edges as its only source of incoming edges (AKA now take all courses that only have 0-prereq courses as its rereqs), and so forth, visiting layer by layer where each successive layer has all of its dependencies present in previous layers.