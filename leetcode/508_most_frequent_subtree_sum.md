# 508. Most Frequent Subtree Sum - Medium

Given the `root` of a binary tree, return the most frequent subtree sum. If there is a tie, return all the values with the highest frequency in any order.

The subtree sum of a node is defined as the sum of all the node values formed by the subtree rooted at that node (including the node itself).

##### Example 1:

![](../assets/508-freq1-tree.jpg)

```
Input: root = [5,2,-3]
Output: [2,-3,4]
```

##### Example 2:

![](../assets/508-freq2-tree.jpg)

```
Input: root = [5,2,-5]
Output: [2]
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>-10<sup>5</sup> <= Node.val <= 10<sup>5</sup></code>

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(n)
class Solution:
    def findFrequentTreeSum(self, root: Optional[TreeNode]) -> List[int]:
        freqs, mf = defaultdict(int), 0
        stack = [[root, 0, 0]]
        while stack:
            node, s, visited = stack.pop()
            if not visited:
                stack.append([node, s, 1])
                if node.left:
                    stack.append([node.left, 0, 0])
            elif visited == 1:
                stack.append([node, s, 2])
                if node.right:
                    stack.append([node.right, 0, 0])
            else:
                s += node.val
                if stack:
                    stack[-1][1] += s
                freqs[s] += 1
                mf = max(freqs[s], mf)

        return list(s for s, f in freqs.items() if f == mf)
```

## Notes
- Iterative postorder traversal and frequency hash table to tabulate frequencies of subtree sums.