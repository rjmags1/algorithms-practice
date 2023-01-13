# 342. Power of Four - Easy

Given an integer `n`, return `true` if it is a power of four. Otherwise, return `false`.

An integer `n` is a power of four, if there exists an integer `x` such that <code>n == 4<sup>x</sup></code>.

##### Example 1:

```
Input: n = 16
Output: true
```

##### Example 2:

```
Input: n = 5
Output: false
```

##### Example 3:

```
Input: n = 1
Output: true
```

##### Constraints:

- <code>-2<sup>31</sup> <= n <= 2<sup>31</sup> - 1</code>

Follow-up: Could you solve it without loops/recursion? 

## Solution 1

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def isPowerOfFour(self, n: int) -> bool:
        curr = 1
        while curr < n:
            curr *= 4
        return curr == n
```

## Notes
- Log in time complexity is base 4.

## Solution 2

```
# Time: O(1)
# Space: O(1)
class Solution:
    def isPowerOfFour(self, n: int) -> bool:
        return n & (n - 1) == 0 and 0x55555555 & n > 0
```

## Notes
- We check if the rightmost bit of `n` is the only bit, and if it matches a bitmask that contains only bits of powers of `4`, namely every other bit is set to `1`. Powers of `4` are represented as the following in binary: `1`, `100`, `10000`, `1000000`, and so on. 