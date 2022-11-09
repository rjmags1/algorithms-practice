# 137. Single Number II - Medium

Given an integer array `nums` where every element appears three times except for one, which appears exactly once. Find the single element and return it.

You must implement a solution with a linear runtime complexity and use only constant extra space.

##### Example 1:

```
Input: nums = [2,2,3,2]
Output: 3
```

##### Example 2:

```
Input: nums = [0,1,0,1,0,1,99]
Output: 99
```

##### Constraints:

- <code>1 <= nums.length <= 3 * 10<sup>4</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>
- Each element in nums appears exactly three times except for one element which appears once.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        bit1 = bit2 = 0
        for num in nums:
            bit1 = ~bit2 & (bit1 ^ num)
            bit2 = ~bit1 & (bit2 ^ num)
        return bit1
```

## Notes
- This is an extension of the logic in 136. Single Number. Instead of duplicate elements besides a single once-occurring element, we have triplicate elements besides a single once-occurring element. We need a mechanism similar to XOR for duplicates that doesn't involve linear space - this screams state machine/bitwise tricks.
- The idea here is that the first mask, `bit1`, will only hold XOR'd bits of numbers that have been encountered once, and `bit2` will only hold XOR'd bits of numbers that have been encountered twice. Consider a simple example, `[3, 3, 3, 1]`. The first time `3` is encountered, its bits will make it into `bit1`, but not into `bit2` because `bit2` is AND'd with negated `bit1` after `bit1` is updated. The second time `3` is occurred, the XOR from the first encounter is undone in `bit1`. Now that the XOR from the first encounter is undone in `bit1`, the XOR bits of `3` will make it into `bit2` since they are now going to be `1` in the negated `bit1` that gets AND'd with `bit2`. The third time `3` is encountered, because we AND negated `bit2` with the XOR of `3` with `bit1` before we update `bit2`, `3`s bits do not make it into `bit1`, and they get removed from `bit2` because they get XOR'd out. It is like we never saw the `3`s at all, which is what we want.
- It is tricky to wrap your head around how this works for cases where triplicate elements are not next to each other in the input, but it boils down to the fact that XOR is commutative, and the NOT `bit_` AND operation ensures XOR'd bits of the current number only make it into the relevant mask when appropriate.