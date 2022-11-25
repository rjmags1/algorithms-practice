# 297. Serialize and Deserialize Binary Tree - Hard

Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

Clarification: The input/output format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

##### Example 1:

```
Input: root = [1,2,3,null,null,4,5]
Output: [1,2,3,null,null,4,5]
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- `-1000 <= Node.val <= 1000`

## Solution

```
# All methods ---
# Time: O(n)
# Space: O(n)
class Codec:
    def levelorder_stringify_nodes(self, root):
        levels = []
        prev = [root]
        while prev:
            children, curr = 0, []
            levels.append([])
            for node in prev:
                s = str(node.val) if node else "None"
                levels[-1].append(s)
                if node is None:
                    continue
                curr.append(node.left)
                curr.append(node.right)
                if node.left:
                    children += 1
                if node.right:
                    children += 1
            prev = curr
            if not children:
                break
        return levels
    
    def serialize(self, root):
        """Encodes a tree to a single string.
        
        :type root: TreeNode
        :rtype: str
        """
        levels = self.levelorder_stringify_nodes(root)
        levels_str = [",".join(level) for level in levels]
        return "|".join(levels_str)
        
    def deserialize(self, data):
        """Decodes your encoded data to tree.
        
        :type data: str
        :rtype: TreeNode
        """
        levels_str = data.split("|")
        levels_str_split = [level_str.split(",") for level_str in levels_str]
        levels = [[int(level[i]) if level[i] != "None" else None 
                   for i in range(len(level))] 
                       for level in levels_str_split]
        
        rootval = levels[0][0]
        if rootval is None:
            return rootval
        root = TreeNode(rootval)
        parents = [root]
        for i in range(1, len(levels)):
            children = [TreeNode(val) if val is not None else None 
                        for val in levels[i]]
            j = 0
            for parent in parents:
                if parent is None:
                    continue
                parent.left = children[j]
                j += 1
                parent.right = children[j]
                j += 1
            parents = children
    
        return root
```

## Notes
- Seems straightforward at first glance but there are a significant number of edge cases to be mindful of to avoid errors and send minimal amount of data over the wire, mostly related to `serialize` implementation.
- For `serialize`, we could use a combination of traversals to construct a tree as in 105. Construct Binary Tree From Inorder and Preorder or 106. Construct Binary Tree from Inorder and Postorder, but that would require sending `2n` nodes over the wire, which in some cases may be more efficient than a level order approach, but overall I prefer level order as it simplifies the implementation. With the level order approach, we need to only include null children nodes that have a non-null node in the same level; this consideration of null children nodes is key because it allows us to correctly assign children nodes to parents when the children level has null nodes. We also want to avoid the case where we have a complete binary tree and we send `2^h` bottom level null nodes.
- For `deserialize`, the main concern is not accidentally avoid null reference errors when reconstructing the tree.