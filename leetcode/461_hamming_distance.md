# 461. Hamming Distance - Easy

The Hamming distance between two integers is the number of positions at which the corresponding bits are different.

Given two integers `x` and `y`, return the Hamming distance between them.

##### Example 1:

```
Input: x = 1, y = 4
Output: 2
Explanation:
1   (0 0 0 1)
4   (0 1 0 0)
       ↑   ↑
The above arrows point to positions where the corresponding bits are different.
```

##### Example 2:

```
Input: x = 3, y = 1
Output: 1
```

##### Constraints:

- <code>0 <= x, y <= 2<sup>31</sup> - 1</code>

## Solution 1

```
# Time: O(log(max(x, y)))
# Space: O(1)
class Solution:
    def hammingDistance(self, x: int, y: int) -> int:
        result = 0
        while x or y:
            result += (x & 1) ^ (y & 1)
            x >>= 1
            y >>= 1
        return result
```

## Notes
- Check all bits

## Solution 2

```
# Time: O(log(max(x, y)))
# Space: O(1)
class Solution:
    def hammingDistance(self, x: int, y: int) -> int:
        result = 0
        diff = x ^ y
        while diff:
            result += 1
            diff &= (diff - 1)
        return result
```

## Notes
- Count only different bits