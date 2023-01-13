# 421. Maximum XOR of Two Numbers in an Array - Medium

Given an integer array `nums`, return the maximum result of `nums[i] XOR nums[j]`, where `0 <= i <= j < n`.

##### Example 1:

```
Input: nums = [3,10,5,25,2,8]
Output: 28
Explanation: The maximum result is 5 XOR 25 = 28.
```

##### Example 2:

```
Input: nums = [14,70,53,83,49,91,36,80,92,51,66,70]
Output: 127
```

##### Constraints:

- <code>1 <= nums.length <= 2 * 10<sup>5</sup></code>
- <code>0 <= nums[i] <= 2<sup>31</sup> - 1</code>

## Solution

```
class BinaryTrie:
    def __init__(self):
        self.root = {}

    def insert(self, num, lmb):
        curr = self.root
        while lmb:
            bit = int((num & lmb) > 0)
            if bit not in curr:
                curr[bit] = {}
            curr = curr[bit]
            lmb >>= 1

    def getMaxXor(self, num, lmb):
        result, curr = 0, self.root
        while lmb:
            numbit = int((num & lmb) > 0)
            notnumbit = 1 if not numbit else 0
            if notnumbit in curr:
                result += lmb
                curr = curr[notnumbit]
            else:
                curr = curr[numbit]
            lmb >>= 1
        return result

# Time: O(n)
# Space: O(2^31) -> O(1)
class Solution:
    def leftmostbit(self, num):
        result = 0
        while num:
            result = num & -num
            num = num & (num - 1)
        return result

    def findMaximumXOR(self, nums: List[int]) -> int:
        lmb = self.leftmostbit(max(nums))
        if lmb == 0:
            return 0

        trie, n, result = BinaryTrie(), len(nums), 0
        trie.insert(nums[0], lmb)
        for i in range(1, n):
            result = max(result, trie.getMaxXor(nums[i], lmb))
            trie.insert(nums[i], lmb)
        return result
```

## Notes
- Binary Trie! Insert each number into the trie after using the trie to determine the max XOR of the current number and some number before it. The height of the binary trie will be equivalent to log base 2 of `max(nums)`.