# 201. Bitwise AND of Numbers Range - Medium

Given two integers `left` and `right` that represent the range `[left, right]`, return the bitwise AND of all numbers in this range, inclusive.

##### Example 1:

```
Input: left = 5, right = 7
Output: 4
```

##### Example 2:

```
Input: left = 0, right = 0
Output: 0
```

##### Example 3:

```
Input: left = 1, right = 2147483647
Output: 0
```

##### Constraints:

- <code>0 <= left <= right <= 2<sup>31</sup> - 1</code>

## Solution 1

```
# Time: O(1)
# Space: O(1)
class Solution:
    def rangeBitwiseAnd(self, left: int, right: int) -> int:
        if right == 0:
            return 0
        
        temp = right
        leftmost = None
        while temp:
            nxt = temp & (temp - 1)
            if nxt == 0:
                leftmost = temp
            temp = nxt
            
        result = 0
        while leftmost:
            if (left & leftmost) != (right & leftmost):
                break
            result |= (left & leftmost)
            leftmost >>= 1
        return result
```

## Notes
- One can see after examining ranges of binary numbers that their common prefix is always the bitwise AND of all the numbers in a given range. 
- This solution uses hamming weight to check each one bit of the `right` to see if it is the most significant 1-bit, and if it is, it saves it. We can now continuously right shift what was the leftmost bit of `right` to check for the common prefix between `left` and `right`.

## Solution 2

```
# Time: O(1)
# Space: O(1)
class Solution:
    def rangeBitwiseAnd(self, left: int, right: int) -> int:
        shifts = 0
        while left != right:
            left >>= 1
            right >>= 1
            shifts += 1
        return left << shifts
```

## Notes:
- Alternatively, we could just right shift until `left` and `right` equal each other. If they have no common prefix, they will equal each other when `right` is shifted all the way to `0`, and we will just return `0` left shifted to the log base 2 of `right`, which is just `0`.