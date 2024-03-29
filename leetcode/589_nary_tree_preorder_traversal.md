# 589. N-ary Tree Preorder Traversal - Easy

Given the `root` of an n-ary tree, return the preorder traversal of its nodes' values.

Nary-Tree input serialization is represented in their level order traversal. Each group of children is separated by the null value.

##### Example 1:

![](../assets/589-tree-1.png)

```
Input: root = [1,null,3,2,4,null,5,6]
Output: [1,3,5,6,2,4]
```

##### Example 2:

![](../assets/589-tree-2.png)

```
Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: [1,2,3,6,7,11,14,4,8,12,5,9,13,10]
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
    def preorder(self, root: 'Node') -> List[int]:
        result, stack = [], [root]
        while stack:
            curr = stack.pop()
            if curr:
                result.append(curr.val)
                for child in reversed(curr.children):
                    stack.append(child)
        return result
```

## Notes
- Iterative preorder traversal with stack; note how we do not need to keep track of whether stack nodes have been previously visited or not with preorder traversal. Also note the reverse iteration over children for correct order of stack appends.