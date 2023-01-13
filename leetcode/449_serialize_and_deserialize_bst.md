# 449. Serialize and Deserialize BST - Medium

Serialization is converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary search tree. There is no restriction on how your serialization/deserialization algorithm should work. You need to ensure that a binary search tree can be serialized to a string, and this string can be deserialized to the original tree structure.

The encoded string should be as compact as possible.

##### Example 1:

```
Input: root = [2,1,3]
Output: [2,1,3]
```

##### Example 2:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>4</sup></code>
- The input tree is guaranteed to be a binary search tree.

## Solution

```
class Codec:

    # Time: O(n)
    # Space: O(n)
    def serialize(self, root: Optional[TreeNode]) -> str:
        """Encodes a tree to a single string.
        """
        if root is None:
            return ""

        levels, curr = [], [root]
        while curr:
            nxt = []
            levels.append([])
            for node in curr:
                levels[-1].append(str(node.val))
                if node.left:
                    nxt.append(node.left)
                if node.right:
                    nxt.append(node.right)
            curr = nxt
            levels[-1] = ",".join(levels[-1])
        return "|".join(levels)
        
    # Time: O(n)
    # Space: O(n)
    def deserialize(self, data: str) -> Optional[TreeNode]:
        """Decodes your encoded data to tree.
        """
        if data == "":
            return None

        levels = [[int(v) for v in l.split(",")] for l in data.split("|")]
        n = len(levels)
        result = TreeNode(levels[0][0])
        parents = [(result, -math.inf, math.inf)]
        isdesc = lambda parent, val: parent[1] < val < parent[2]
        for i in range(1, n):
            nxtpar, levelnodes, j = [], levels[i], 0
            for val in levelnodes:
                while not isdesc(parents[j], val):
                    j += 1
                parent, child = parents[j][0], TreeNode(val)
                childmin, childmax = parents[j][1], parents[j][2]
                if val < parent.val:
                    parent.left = child
                    childmax = parent.val
                else:
                    parent.right = child
                    childmin = parent.val
                nxtpar.append((child, childmin, childmax))
            parents = nxtpar

        return result
```

## Notes
- This BFS solution works but is rather naive in terms of getting the encoding string to be as compact as possible. Because we are dealing with a BST, it is possible to construct the BST from its preorder traversal with recursion or a stack based approach that takes advantage of the fact that the root of the BST is the first node in the preorder traversal of its nodes (and recursively so if we iterate LTR through the preorder traversal and backtrack up the tree when we encounter a value in the preorder traversal that is not in the range of the subtree rooted at the current node). Furthermore, instead of serializing integers as strings, which gets inefficient for multi digit integers, we can serialize integers using `4` bytes each. This will end up saving a lot of space, and also allows us to forego the use of delimiters if we parse the bytes back into an array of integers.