# 173. Binary Search Tree Iterator - Medium

Implement the `BSTIterator` class that represents an iterator over the in-order traversal of a binary search tree (BST):

- `BSTIterator(TreeNode root)` Initializes an object of the `BSTIterator` class. The `root` of the BST is given as part of the constructor. The pointer should be initialized to a non-existent number smaller than any element in the BST.
- `boolean hasNext()` Returns `true` if there exists a number in the traversal to the right of the pointer, otherwise returns `false`.
- `int next()` Moves the pointer to the right, then returns the number at the pointer.

Notice that by initializing the pointer to a non-existent smallest number, the first call to `next()` will return the smallest element in the BST.

You may assume that `next()` calls will always be valid. That is, there will be at least a next number in the in-order traversal when `next()` is called.

##### Example 1:

```
Input
["BSTIterator", "next", "next", "hasNext", "next", "hasNext", "next", "hasNext", "next", "hasNext"]
[[[7, 3, 15, null, null, 9, 20]], [], [], [], [], [], [], [], [], []]
Output
[null, 3, 7, true, 9, true, 15, true, 20, false]

Explanation
BSTIterator bSTIterator = new BSTIterator([7, 3, 15, null, null, 9, 20]);
bSTIterator.next();    // return 3
bSTIterator.next();    // return 7
bSTIterator.hasNext(); // return True
bSTIterator.next();    // return 9
bSTIterator.hasNext(); // return True
bSTIterator.next();    // return 15
bSTIterator.hasNext(); // return True
bSTIterator.next();    // return 20
bSTIterator.hasNext(); // return False
```

##### Constraints:

- The number of nodes in the tree is in the range <code>[1, 10<sup>5</sup>]</code>.
- <code>0 <= Node.val <= 10<sup>6</sup></code>
- At most <code>10<sup>5</sup></code> calls will be made to `hasNext`, and `next`.

Follow-up: Could you implement `next()` and `hasNext()` to run in average `O(1)` time and use `O(h)` memory, where `h` is the height of the tree?

## Solution

```
# Time: O(1) hasNext and amortized O(1) for hasNext
# Space: O(h) (this is O(n) is worst case and O(log(n)) in best)
class BSTIterator:
    def __init__(self, root: Optional[TreeNode]):
        self.stack =[(root, False)]

    def next(self) -> int:
        while self.stack:
            curr, visited = self.stack.pop()
            if not visited:
                self.stack.append((curr, True))
                if curr.left:
                    self.stack.append((curr.left, False))
            else:
                if curr.right:
                    self.stack.append((curr.right, False))
                return curr.val

    def hasNext(self) -> bool:
        return len(self.stack) > 0
```

## Notes
- This is a very interesting problem that really gets at the heart of inorder binary tree traversal. What do we do when we traverse a binary tree inorder? At any given node, we go as far down and left as possible. Then as we come back up via the call stack (or native stack if implemented iteratively), we process nodes we visited before but didn't process the first time we visited them because they had left children -- additionally as we come back up, if one of these nodes has a right child, we go there and then continue the cycle again, going as far down and left as possible and so forth.
- It is trivial to implement inorder traversal recursively and collect all nodes on `__init__`, but much harder to figure out how to jump from node to node in the correct inorder traversal order with each call to `next`. How to do this? Well we maintain an instance-scoped variable `self.stack` and perform inorder traversal iteratively as described above until we get to the next node to be processed (AKA next node in inorder traversal order), and return that node's value after adding its right child to the stack if it has one. 
- It is trivial to determine if at any point `hasNext` should return `True` because if there is another value in the inorder traversal order the stack will have at least one value on top of it, because the stack always contains the next nodes to be processed. So its complexity is trivially constant. 
- The time complexity for `next` is more interesting because it involves amortization. We can say `next` has a time complexity of `O(1)` amortized because any single call will perform at most `h` iterations, but for every `O(h)` call there will be `h` `O(1)` calls from popping off the stack and returning a previously `visited` node.