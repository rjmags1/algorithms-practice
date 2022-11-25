# 222. Count Complete Tree Nodes - Medium

Given the `root` of a complete binary tree, return the number of the nodes in the tree.

According to Wikipedia, every level, except possibly the last, is completely filled in a complete binary tree, and all nodes in the last level are as far left as possible. It can have between `1` and <code>2<sup>h</sup></code> nodes inclusive at the last level `h`.

Design an algorithm that runs in less than `O(n)` time complexity.

##### Example 1:

```
Input: root = [1,2,3,4,5,6]
Output: 6
```

##### Example 2:

```
Input: root = []
Output: 0
```

##### Example 3:

```
Input: root = [1]
Output: 1
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[0, 5 * 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 5 * 10<sup>4</sup></code>
- The tree is guaranteed to be complete.

## Solution

```
# Time: O(log(n) * log(n))
# Space: O(h) but could easily optimize to O(1)
class Solution:
    def countNodes(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        
        h, left, right = -1, root, root
        complete = False
        while left:
            h += 1
            if left.left is None and right and right.right is None:
                complete = True
                break
            left = left.left
            right = right.right if right else None
        if complete:
            return sum([2 ** h for h in range(h + 1)])
                
        l, r = 1, 2 ** h
        while l < r:
            mid = (l + r) // 2
            rng = [1, 2 ** h]
            currh = -1
            curr = root
            while curr:
                currh += 1
                lstop = (rng[1] + rng[0]) // 2
                if mid > lstop:
                    curr = curr.right
                    rng[0] = lstop + 1
                else:
                    curr = curr.left
                    rng[1] = lstop
            if currh < h:
                r = mid
            else:
                l = mid + 1
        
        bottomnodes = r - 1
        return sum([2 ** level for level in range(h)]) + bottomnodes
```

## Notes
- Pretty tricky for a medium. The idea of this problem is to use binary search to efficiently check for the rightmost complete leaf node. Not only is this an unusual combination (searching a binary tree with binary search), but getting the binary search correct is tricky. It is actually simpler to search for the leftmost non-complete leaf node because searching for the rightmost of something with binary search can be tricky because we tend to floor to get `mid`. 
- We also need to look out for the edge case where the tree is actually complete.