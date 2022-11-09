# 138. Copy List with Random Pointer - Medium

A linked list of length `n` is given such that each node contains an additional random pointer, which could point to any node in the list, or `null`.

Construct a deep copy of the list. The deep copy should consist of exactly `n` brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the `next` and `random` pointer of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. None of the pointers in the new list should point to nodes in the original list.

For example, if there are two nodes `X` and `Y` in the original list, where `X.random --> Y`, then for the corresponding two nodes `x` and `y` in the copied list, `x.random --> y`.

Return the head of the copied linked list.

The linked list is represented in the input/output as a list of n nodes. Each node is represented as a pair of `[val, random_index]` where:

- `val`: an integer representing `Node.val`
- `random_index`: the index of the node (range from `0` to `n-1`) that the random pointer points to, or `null` if it does not point to any node.

Your code will only be given the `head` of the original linked list.

##### Example 1:

```
Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
```

##### Example 2:

```
Input: head = [[1,1],[2,1]]
Output: [[1,1],[2,1]]
```

##### Example 3:

```
Input: head = [[3,null],[3,0],[3,null]]
Output: [[3,null],[3,0],[3,null]]
```

##### Constraints:

- `0 <= n <= 1000`
- <code>-10<sup>4</sup> <= Node.val <= 10<sup>4</sup></code>
- `Node.random` is `null` or is pointing to some node in the linked list.

## Solution 1

```
# Time: O(n) (one pass)
# Space: O(n)
class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        clones = {}
        curr = head
        while curr:
            if curr not in clones:
                clones[curr] = Node(curr.val)
            if curr.next and curr.next not in clones:
                clones[curr.next] = Node(curr.next.val)
            if curr.random and curr.random not in clones:
                clones[curr.random] = Node(curr.random.val)
            
            clone = clones[curr]
            clonenxt = clones[curr.next] if curr.next else None
            clonerandom = clones[curr.random] if curr.random else None
            clone.next, clone.random = clonenxt, clonerandom
            
            curr = curr.next
        return clones[head] if head else None
```

## Notes
- This solution arguable preferable to the second despite non-constant space due to single pass. Memory (usually) not expensive nowadays compared to recent past.
- Also want to draw attention to how this solution uses mutable objects as dictionary (hash table) keys. This works (I am assuming) because the hash lookup uses the memory address of the object as opposed to the contents of the object, but in general should be hesitant about using mutable objects as keys because you are essentially leaving the hash lookup up to the underlying implementation of the object you are using as a key.

## Solution 2

```
# Time: O(n) (three passes)
# Space: O(1)
class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        if not head:
            return head
        
        curr = head
        while curr:
            clone = Node(curr.val, curr.next)
            temp = curr.next
            curr.next = clone
            curr = temp
            
        curr = head
        while curr:
            curr.next.random = curr.random.next if curr.random else None
            curr = curr.next.next
            
        result = head.next
        curr = head
        while curr:
            orig, clone = curr, curr.next
            orig.next = clone.next
            clone.next = clone.next.next if clone.next else None
            curr = orig.next
            
        return result
```

## Notes
- This solution works by interweaving the cloned list and the original list, such that clones are always `next` after their original counterparts. This allows easy access to the correct `random` clone for cloned nodes - however, the linking of clones to their `random`s must be done on the second pass because all clones need to be interweaved into the original list first. It also makes it easy to unweave the cloned and original list after we have correctly assigned the `random` values of the cloned list, but this must be done on a third pass because if we do it during the second pass any clones that have `random` values before them in the list will not be able to access them via their original counterpart's `random` value.