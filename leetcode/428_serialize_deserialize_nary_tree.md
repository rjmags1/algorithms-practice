# 428. Serialize and Deserialize N-ary Tree - Hard

Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize an N-ary tree. An N-ary tree is a rooted tree in which each node has no more than N children. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that an N-ary tree can be serialized to a string and this string can be deserialized to the original tree structure.

##### Example 1:

```
Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
```

##### Example 2:

```
Input: root = [1,null,3,2,4,null,5,6]
Output: [1,null,3,2,4,null,5,6]
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
    # Time: O(n)
    # Space: O(n)
    def serialize(self, root: 'Node') -> str:
        """Encodes a tree to a single string.
        
        :type root: Node
        :rtype: str
        """
        result = []
        if root is None:
            return "X"
        curr = [root]
        while curr:
            nxt = []
            for node in curr:
                result.append(str(len(node.children)))
                result.append(str(node.val))
                for ch in node.children:
                    nxt.append(ch)
            curr = nxt
        return ",".join(result)
	
    def parsebytes(self, data):
        i, n, result = 0, len(data), []
        while i < n:
            cnum = 0
            while data[i] != ',':
                cnum = cnum * 10 + int(data[i])
                i += 1
            i += 1
            nodeval = 0
            while i < n and data[i] != ',':
                nodeval = nodeval * 10 + int(data[i])
                i += 1
            i += 1
            result.append((cnum, nodeval))
        return result

    # Time: O(n)
    # Space: O(n)
    def deserialize(self, data: str) -> 'Node':
        """Decodes your encoded data to tree.
        
        :type data: str
        :rtype: Node
        """
        if data[0] == "X":
            return None
        parsed = self.parsebytes(data)
        i, n = 1, len(parsed)
        root = Node(parsed[0][1])
        curr = [(parsed[0][0], root)]
        level = 1
        while curr:
            nxt = []
            for cnum, parent in curr:
                parent.children = []
                for j in range(i, i + cnum):
                    ccnum, ccval = parsed[j]
                    childnode = Node(ccval)
                    nxt.append((ccnum, childnode))
                    parent.children.append(childnode)
                i += cnum
            curr = nxt

        return root
```

## Notes
- Level order traversal, preface each node's value with the number of children it has.