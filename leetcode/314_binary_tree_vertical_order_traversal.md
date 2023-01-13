# 314. Binary Tree Vertical Order Traversal - Medium

Given the `root` of a binary tree, return the vertical order traversal of its nodes' values. (i.e., from top to bottom, column by column).

If two nodes are in the same row and column, the order should be from left to right.

##### Example 1:

```
Input: root = [3,9,20,null,null,15,7]
Output: [[9],[3,15],[20],[7]]
```

##### Example 2:

```
Input: root = [3,9,8,4,0,1,7]
Output: [[4],[9],[3,0,1],[8],[7]]
```

##### Example 3:

```
Input: root = [3,9,8,4,0,1,7,null,null,null,2,5]
Output: [[4],[9,5],[3,0,1],[8,2],[7]]
```

##### Constraints:

- The number of nodes in the tree is in the range `[0, 100]`.
- `-100 <= Node.val <= 100`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def verticalOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root:
            return []
        
        cols = defaultdict(list)
        q = deque([(root, 0)])
        minbal, maxbal = inf, -inf
        while q:
            curr, bal = q.popleft()
            minbal = min(minbal, bal)
            maxbal = max(maxbal, bal)
            cols[bal].append(curr.val)
            if curr.left:
                q.append((curr.left, bal  - 1))
            if curr.right:
                q.append((curr.right, bal + 1))
        
        return [cols[b] for b in range(minbal, maxbal + 1)]
```

## Notes
- Note how tracking `minbal` and `maxbal` while doing bfs prevents us from needing to sort our columns lists (AKA `cols.values()`) by their key in `cols` (balance/column number). BFS simplifies the process of collecting nodes in the desired order by automatically visiting nodes level by level. If we were to naively do DFS and track only balance, cases like below would cause problems (`2` is a right child and `5` is a left child). 
- If we really wanted to use DFS, we could track balance (AKA the column), as well as the row. With this strategy, some nodes would have the same row-col indexes, so we would need to use preorder DFS and a stable sorting algorithm to sort nodes by their row-col indices.
![](../assets/vtree2.jpg)