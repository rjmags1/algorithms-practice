# 457. Circular Array Loop - Medium

You are playing a game involving a circular array of non-zero integers `nums`. Each `nums[i]` denotes the number of indices forward/backward you must move if you are located at index `i`:

- If `nums[i]` is positive, move `nums[i]` steps forward, and
- If `nums[i]` is negative, move `nums[i]` steps backward.

Since the array is circular, you may assume that moving forward from the last element puts you on the first element, and moving backwards from the first element puts you on the last element.

A cycle in the array consists of a sequence of indices `seq` of length `k` where:

- Following the movement rules above results in the repeating index sequence `seq[0] -> seq[1] -> ... -> seq[k - 1] -> seq[0] -> ...`
- Every `nums[seq[j]]` is either all positive or all negative.
- `k > 1`

Return `true` if there is a cycle in nums, or false otherwise.

##### Example 1:

```
Input: nums = [2,-1,1,2,2]
Output: true
Explanation: The graph shows how the indices are connected. White nodes are jumping forward, while red is jumping backward.
We can see the cycle 0 --> 2 --> 3 --> 0 --> ..., and all of its nodes are white (jumping in the same direction).
```

##### Example 2:

```
Input: nums = [-1,-2,-3,-4,-5,6]
Output: false
Explanation: The graph shows how the indices are connected. White nodes are jumping forward, while red is jumping backward.
The only cycle is of size 1, so we return false.
```

##### Example 3:

```
Input: nums = [1,-1,5,1,4]
Output: true
Explanation: The graph shows how the indices are connected. White nodes are jumping forward, while red is jumping backward.
We can see the cycle 0 --> 1 --> 0 --> ..., and while it is of size > 1, it has a node jumping forward and a node jumping backward, so it is not a cycle.
We can see the cycle 3 --> 4 --> 3 --> ..., and all of its nodes are white (jumping in the same direction).
```

##### Constraints:

- `1 <= nums.length <= 5000`
- `-1000 <= nums[i] <= 1000`
- `nums[i] != 0`

Follow-up: Could you solve it in `O(n)` time complexity and `O(1)` extra space complexity?

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def circularArrayLoop(self, nums: List[int]) -> bool:
        n = len(nums)
        explored = set()
        def cycle(i, sign):
            if nums[i] == 0:
                return True
            if nums[i] > 0 and sign == "-":
                return False
            if nums[i] < 0 and sign == "+":
                return False

            nexti = (n + i + nums[i]) % n
            if nexti == i:
                explored.add(i)
                return False
            val = nums[i]
            nums[i] = 0
            if cycle(nexti, sign):
                return True

            nums[i] = val
            explored.add(i)
            return False
        
        for i, num in enumerate(nums):
            if i in explored:
                continue
            sign = "+" if num > 0 else "-"
            if cycle(i, sign):
                return True
        return False
```

## Notes
- This problem can be treated as a graph where elements in the input array are nodes with at most one child. Nodes have no children if they lead to an index with an opposite signed element, and one child otherwise. We can simply dfs on all nodes to search for a cycle. Instead of using a set to track if an element is in the current dfs path, we just mark such elements as `0`. Note the way we perform circular array traversal in both directions with modulo and check for single node cycles.
- Since nodes have at most one child, similar to linked list, we could reduce the space complexity to constant at the cost of doubling runtime by using the idea of Tortoise and Hare. This involves searching for a cycle via fast and slow pointers typical of the Tortoise and Hare pattern, with a second iteration of just the slow pointer after determining a particular path is not a cycle to mark all nodes in the path as seen by replacing with `0`.