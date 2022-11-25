# 255. Verify Preorder Sequence in Binary Search Tree - Medium

Given an array of unique integers `preorder`, return `true` if it is the correct preorder traversal sequence of a binary search tree.

##### Example 1:

```
Input: preorder = [5,2,1,3,6]
Output: true
```

##### Example 2:

```
Input: preorder = [5,2,6,1,3]
Output: false
```

##### Constraints:

- <code>1 <= preorder.length <= 10<sup>4</sup></code>
- <code>1 <= preorder[i] <= 10<sup>4</sup></code>
- All the elements of `preorder` are unique.

Follow-up: Could you do it using only constant space complexity?

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def verifyPreorder(self, preorder: List[int]) -> bool:
        stack, lower = [], -inf
        for num in preorder:
            if num < lower:
                return False
            while stack and stack[-1] < num:
                lower = stack.pop()
            stack.append(num)
            
        return True
```

## Notes
- This solution follows from the idea of preorder traversal: visit a node, go to left subtree, go to right subtree. It follows from this idea that in `preorder`, as numbers decrease we are visiting left children. Once the numbers start to increase, it means we are encountering a right child of a previously encountered number. The number whose right child this is will be the largest number smaller than it that was previously encountered. This parent number constitutes the lower bound for the tree rooted at the current right child. We keep updating the lower bound in this way as we iterate through `preorder`, and if we ever encounter a number less than the lower bound, we know the sequence is invalid. 
- The followup involves mutating the input and this is a low frequency question anyway so not going to bother with it.