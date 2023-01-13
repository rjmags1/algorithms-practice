# 431. Encode N-ary Tree to Binary Tree - Hard

Design an algorithm to encode an N-ary tree into a binary tree and decode the binary tree to get the original N-ary tree. An N-ary tree is a rooted tree in which each node has no more than N children. Similarly, a binary tree is a rooted tree in which each node has no more than 2 children. There is no restriction on how your encode/decode algorithm should work. You just need to ensure that an N-ary tree can be encoded to a binary tree and this binary tree can be decoded to the original N-nary tree structure.

Nary-Tree input serialization is represented in their level order traversal, each group of children is separated by the null value (See following example).

##### Example 1:

```
Input: root = [1,null,3,2,4,null,5,6]
Output: [1,null,3,2,4,null,5,6]
```

##### Example 2:

```
Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
```

##### Example 3:

```
Input: root = []
Output: []
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>4</sup></code>
- The height of the n-ary tree is less than or equal to `1000`
- Do not use class member/global/static variables to store states. Your encode and decode algorithms should be stateless.

## Solution

```
class Codec:
    # Encodes an n-ary tree to a binary tree.
    def encode(self, root: 'Optional[Node]') -> Optional[TreeNode]:
        if root is None:
            return root

        fromnn = lambda nn: TreeNode(nn.val)
        result = fromnn(root)
        curr = [(root, result)]
        while curr:
            nxt = []
            for nn, bn in curr:
                children = []
                for ch in nn.children:
                    children.append(fromnn(ch))
                    if len(children) > 1:
                        children[-2].right = children[-1]
                    nxt.append((ch, children[-1]))
                bn.left = children[0] if children else None
            curr = nxt

        return result
	
    # Decodes your binary tree to an n-ary tree.
    def decode(self, data: Optional[TreeNode]) -> 'Optional[Node]':
        if data is None:
            return None

        frombn = lambda bn: Node(bn.val, [])
        result = frombn(data)
        curr = [(data, result)]
        while curr:
            nxt = []
            for bn, nn in curr:
                sib = bn.left
                while sib:
                    nn.children.append(frombn(sib))
                    nxt.append((sib, nn.children[-1]))
                    sib = sib.right
            curr = nxt
        
        return result
```

## Notes
- Picture worth a thousand words. Sibling nodes becomes right children, first child becomes left child of parent.
![](../assets/431_nary_tree.png)
![](../assets/431_binary_tree.png)