# 272. Closest Binary Search Tree Value II - Hard

Given the `root` of a binary search tree, a `target` value, and an integer `k`, return the `k` values in the BST that are closest to the `target`. You may return the answer in any order.

You are guaranteed to have only one unique set of `k` values in the BST that are closest to the `target`.

##### Example 1:

```
Input: root = [4,2,5,1,3], target = 3.714286, k = 2
Output: [4,3]
```

##### Example 2:

```
Input: root = [1], target = 0.000000, k = 1
Output: [1]
```

##### Constraints:

- The number of nodes in the tree is `n`.
- <code>1 <= k <= n <= 10<sup>4</sup></code>
- <code>0 <= Node.val <= 10<sup>9</sup></code>
- <code>-10<sup>9</sup> <= target <= 10<sup>9</sup></code>

Follow-up: Assume that the BST is balanced. Could you solve it in less than `O(n)` runtime (where `n = total nodes`)?

## Solution

```
# Time: O(k * log(n)) if tree is balanced.
# Space: O(h + k)
class Solution:
    EQ, LT, GT = 0, 1, 2
    def getClosest(self, root, val, op):
        result = inf
        def rec(node):
            if node is None:
                return

            nonlocal result
            if op == self.EQ:
                diff = abs(node.val - val)
                resdiff = abs(result - val)
                if diff < resdiff:
                    result = node.val
                    if diff == 0:
                        return
                if val < node.val:
                    rec(node.left)
                else:
                    rec(node.right)
            elif op == self.LT:
                diff = val - node.val
                resdiff = val - result if result != inf else inf
                if diff > 0 and diff < resdiff:
                    result = node.val
                if val <= node.val:
                    rec(node.left)
                else:
                    rec(node.right)
            else:
                diff = node.val - val
                resdiff = result - val
                if diff > 0 and diff < resdiff:
                    result = node.val
                if val >= node.val:
                    rec(node.right)
                else:
                    rec(node.left)
        
        rec(root)
        return result
    
    def closestKValues(self, root: Optional[TreeNode], target: float, k: int) -> List[int]:
        result = [self.getClosest(root, target, self.EQ)]
        k -= 1
        smallest = largest = result[0]
        while k:
            nextsmallest = self.getClosest(root, smallest, self.LT)
            nextlargest = self.getClosest(root, largest, self.GT)
            diffs = abs(target - nextsmallest)
            diffl = abs(nextlargest - target)
            if diffs < diffl:
                result.append(nextsmallest)
                smallest = nextsmallest
            else:
                result.append(nextlargest)
                largest = nextlargest
            k -= 1
            
        return result
```

## Notes
- If it weren't for the followup, this question would be best solved by applying quickselect to an inorder collection of the trees values. Kind of trivial to go about it this way though because the only conceptual jump to make to applying quickselect here is knowing that an inorder traversal of a BST yields a sorted array.
- This solution will perform much better than a linear time solution when the input is a big balanced BST. It will do `2 * k * log(n)` node touches, which for an input such as `k = 5, n = 10000`, we will do `~13 * 10 = 130` node touches as opposed to `10000`. 