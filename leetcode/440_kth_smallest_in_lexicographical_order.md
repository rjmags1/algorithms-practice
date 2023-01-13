# 440. Kth Smallest in Lexicographical Order - Hard

Given two integers `n` and `k`, return the `kth` lexicographically smallest integer in the range `[1, n]`.

##### Example 1:

```
Input: n = 13, k = 2
Output: 10
Explanation: The lexicographical order is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9], so the second smallest number is 10.
```

##### Example 2:

```
Input: n = 1, k = 1
Output: 1
```

##### Constraints:

- <code>1 <= k <= n <= 10<sup>9</sup></code>

## Solution

```
# Time: O(log(k) * log(n))
# Space: O(log(k))
class Solution:
    def findKthNumber(self, n: int, k: int) -> int:
        x, npowten = n, -1
        while x:
            npowten += 1
            x //= 10

        def subtreesize(root, powten):
            result = 1
            for p in range(powten + 1, npowten + 1):
                exp = p - powten
                firstinrange = root * 10 ** exp
                if firstinrange > n:
                    break
                lastinrange = min(n, firstinrange + 10 ** exp - 1)
                result += lastinrange - firstinrange + 1
            return result
        
        def rec(root, k, powten):
            firstchild = 1 if root == 0 else root * 10
            for child in range(firstchild, firstchild + 10):
                childtreesize = subtreesize(child, powten + 1)
                if k == 1:
                    return child
                if k > childtreesize:
                    k -= childtreesize
                else:
                    return rec(child, k - 1, powten + 1)
        
        return rec(0, k, -1)
```

## Notes
- To find the kth lexicographically smallest integer in `[1, n]`, we need to recursively consider the denary tree of integers in `[1, n]` in a preorder fashion. We will TLE if we visit each node, so we need to avoid exploring subtrees that will not contain the `kth` smallest lexicographical integer. Since we are given `n`, we can calculate the size of a subtree in logarithmic time because the number of nodes in each level of a subtree increases by a factor of 10 - we are dealing with a denary tree (except for the subtree rooted at `0` and the subtree containing `n` if `n` is not the tenth child of its parent).
- The time complexity results from the fact that each node that we visit in the subtree will result in a logarithmic amount of nodes eliminated from consideration (we eliminate some power of 10 of nodes for each node that we visit in the denary tree), unless the node that we are currently visiting contains the `kth` lexicographically smallest value, in which case we descend to that node in constant time. It takes `O(log(n))` time to determine the size of the subtree rooted at the node we are visiting AKA the number of nodes we can eliminate from consideration when we visit a node (each call to `subtreesize` is logarithmic in time).