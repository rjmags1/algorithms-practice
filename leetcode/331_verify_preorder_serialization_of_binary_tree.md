# 331. Verify Preorder Serialization of a Binary Tree - Medium

One way to serialize a binary tree is to use preorder traversal. When we encounter a non-null node, we record the node's value. If it is a null node, we record using a sentinel value such as `'#'`.

![](../assets/331-tree.jpg)

For example, the above binary tree can be serialized to the string `"9,3,4,#,#,1,#,#,2,#,6,#,#"`, where `'#'` represents a null node.

Given a string of comma-separated values `preorder`, return `true` if it is a correct preorder traversal serialization of a binary tree.

It is guaranteed that each comma-separated value in the string must be either an integer or a character `'#'` representing null pointer.

You may assume that the input format is always valid.

For example, it could never contain two consecutive commas, such as `"1,,3"`.

Note: You are not allowed to reconstruct the tree.

##### Example 1:

```
Input: preorder = "9,3,4,#,#,1,#,#,2,#,6,#,#"
Output: true
```

##### Example 2:

```
Input: preorder = "1,#"
Output: false
```

##### Example 3:

```
Input: preorder = "9,#,#,1"
Output: false
```

##### Constraints:

- <code>1 <= preorder.length <= 10<sup>4</sup></code>
- `preorder` consist of integers in the range `[0, 100]` and `'#'` separated by commas `','`.

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def isValidSerialization(self, preorder: str) -> bool:
        spl = preorder.split(",")
        if spl[0] == "#":
            return len(spl) == 1
        
        n, stack = len(spl), []
        for i, node in enumerate(spl):
            if node != "#":
                stack.append(0)
            else:
                if not stack:
                    return False
                stack[-1] += 1
                while stack and stack[-1] == 2:
                    stack.pop()
                    if stack:
                        stack[-1] += 1
                    elif i < n - 1:
                        return False
        return not stack
```

## Notes
- We use a stack to simulate preorder traversal of the serialized tree. The integers that get placed onto the stack represent the number of times a node has been returned to after descending to one of its children; so, every time we pop off the stack there should be another node (popped's parent) on the stack to return to, unless we are at the last node in the traversal, then we should end up popping all nodes off the stack. At the end of the iteration, if there are still nodes on the stack we should `return False` because this would mean there were not enough null characters included in the serialization.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isValidSerialization(self, preorder: str) -> bool:
        i, n, nodes = 0, len(preorder), 1
        while i < n:
            nodes -= 1
            if preorder[i] != "#":
                nodes += 2
            while i < n and preorder[i] != ',':
                i += 1
            i += 1
            if nodes < 1 and i < n:
                return False
        return nodes == 0
```

## Notes
- Here we consider binary tree as having a certain number of nodes, where each node may lead to `0` or `2` more non-null nodes. Null nodes always lead to `0` more nodes, where as non-null nodes may lead to `2` nodes. To avoid linear memory usage due to stack, we can check the amount of nodes after every node value in the serialization. If we ever run out of nodes despite the fact that we still have more of the serialization to process, we know there are too many null characters at some point in the serialization. If there is a nonzero amount of nodes after the serialization we know there were not enough null characters in the serialization.