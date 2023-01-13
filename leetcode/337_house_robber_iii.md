# 337. House Robber III - Medium

The thief has found himself a new place for his thievery again. There is only one entrance to this area, called `root`.

Besides the `root`, each house has one and only one parent house. After a tour, the smart thief realized that all houses in this place form a binary tree. It will automatically contact the police if two directly-linked houses were broken into on the same night.

Given the `root` of the binary tree, return the maximum amount of money the thief can rob without alerting the police.

##### Example 1:

```
Input: root = [3,2,3,null,3,null,1]
Output: 7
Explanation: Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
```

##### Example 2:

```
Input: root = [3,4,5,1,3,null,1]
Output: 9
Explanation: Maximum amount of money the thief can rob = 4 + 5 = 9.
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>4</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>4</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def rob(self, root: Optional[TreeNode]) -> int:
        @cache
        def rec(node, canrob):
            if node is None:
                return 0
            
            dontrob = rec(node.left, True) + rec(node.right, True)
            if not canrob:
                return  dontrob
            rob = node.val + rec(node.left, False) + rec(node.right, False)
            return max(dontrob, rob)
        
        return max(rec(root, False), rec(root, True))
```

## Notes
- Memo cache takes up `2n` space because there are `2` non-memoized visits to each node. Cache is useful here because we would end up making redundant calls without it.

## Solution 2

```
# Time: O(n)
# Space: O(h)
class Solution:
    def rob(self, root: Optional[TreeNode]) -> int:
        def rec(node):
            if node is None:
                return 0, 0
            
            leftr, leftnr = rec(node.left)
            rightr, rightnr = rec(node.right)
            rob = node.val + leftnr + rightnr
            dontrob = max(leftr, leftnr) + max(rightr, rightnr)
            
            return rob, dontrob
            
        return max(rec(root))
```

## Notes
- We don't need a cache if we compute the max for robbing and not robbing for a particular node in the same recursive call. We will only visit each node once. It is the same idea as the array version of house robber, which is essentially max subsequence sum no adjacent.