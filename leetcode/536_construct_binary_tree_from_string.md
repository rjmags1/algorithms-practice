# 536. Construct Binary Tree from String - Medium

You need to construct a binary tree from a string consisting of parenthesis and integers.

The whole input represents a binary tree. It contains an integer followed by zero, one or two pairs of parenthesis. The integer represents the root's value and a pair of parenthesis contains a child binary tree with the same structure.

You always start to construct the left child node of the parent first if it exists.

##### Example 1:

![](../assets/536-tree.jpg)

```
Input: s = "4(2(3)(1))(6(5))"
Output: [4,2,6,3,1,5]
```

##### Example 2:

```
Input: s = "4(2(3)(1))(6(5)(7))"
Output: [4,2,6,3,1,5,7]
```

##### Example 3:

```
Input: s = "-4(2(3)(1))(6(5)(7))"
Output: [-4,2,6,3,1,5,7]
```

##### Constraints:

- <code>0 <= s.length <= 3 * 10<sup>4</sup></code>
- `s` consists of digits, `'('`, `')'`, and `'-'` only.

## Solution

```
# Time: O(n)
# Space: O(h)
class Solution:
    def parseint(self, i, s):
        neg = s[i] == "-"
        if neg:
            i += 1
        result = 0
        while i < len(s) and s[i].isdigit():
            result = result * 10 + int(s[i])
            i += 1
        if neg:
            result = -result
        return result, i
    
    def parse(self, i, s):
        n = len(s)
        val, i = self.parseint(i, s)
        root = TreeNode(val)
        if i < n and s[i] == "(":
            root.left, i = self.parse(i + 1, s)
            if i < n and s[i] == "(":
                root.right, i = self.parse(i + 1, s)
        return root, i + 1

    def str2tree(self, s: str) -> Optional[TreeNode]:
        if not s:
            return None
        root, _ = self.parse(0, s)
        return root
```

## Notes
- String parsing/preorder tree traversal.