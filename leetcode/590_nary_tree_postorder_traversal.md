# 590. N-ary Tree Postorder Traversal - Easy

Given the `root` of an n-ary tree, return the postorder traversal of its nodes' values.

Nary-Tree input serialization is represented in their level order traversal. Each group of children is separated by the null value.

##### Example 1:

![](../assets/589-tree-1.png)

```
Input: root = [1,null,3,2,4,null,5,6]
Output: [5,6,3,2,4,1]
```

##### Example 2:

![](../assets/589-tree-2.png)

```
Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: [2,6,14,11,7,3,12,8,4,13,9,10,5,1]
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>4</sup></code>
- The height of the n-ary tree is less than or equal to `1000`.

Follow-up: Recursive solution is trivial, could you do it iteratively?

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def postorder(self, root: 'Node') -> List[int]:
        stack, result = [(root, False)], []
        while stack:
            curr, visited = stack.pop()
            if not curr:
                continue
            if visited:
                result.append(curr.val)
            else:
                stack.append((curr, True))
                for child in reversed(curr.children):
                    stack.append((child, False))
                
        return result
```

## Notes
- Iterative postorder traversal with stack. Note how for postorder we need to keep track of visited information.