# 926. Flip String to Monotone Increasing - Medium

A binary string is monotone increasing if it consists of some number of `0`'s (possibly none), followed by some number of `1`'s (also possibly none).

You are given a binary string `s`. You can flip `s[i]` changing it from `0` to `1` or from `1` to `0`.

Return the minimum number of flips to make `s` monotone increasing.

##### Example 1:

```
Input: s = "00110"
Output: 1
Explanation: We flip the last digit to get 00111.
```

##### Example 2:

```
Input: s = "010110"
Output: 2
Explanation: We flip to get 011111, or alternatively 000111.
```

##### Example 3:

```
Input: s = "00011000"
Output: 2
Explanation: We flip to get 00000000.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s[i]` is either `'0'` or `'1'`.

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        result = flips = sum(int(c == "0") for c in s)
        for c in s:
            flips += 1 if c == "1" else - 1
            result = min(result, flips)
        return result
```

## Notes
- Treat the problem as finding the prefix-suffix combo that requires the least amount of flips, where the prefix must be all zeroes and the suffix must be all ones. Initially the prefix is empty string, so the number of flips for the initial split is the number of zeroes.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def minFlipsMonoIncr(self, s: str) -> int:
        n = len(s)
        left1 = [0] * n
        for i in range(1, n):
            left1[i] = left1[i - 1]
            if s[i - 1] == "1":
                left1[i] += 1
        right0 = [0] * n
        for i in reversed(range(n - 1)):
            right0[i] = right0[i + 1]
            if s[i + 1] == "0":
                right0[i] += 1
        return min(left1[i] + right0[i] for i in range(n))
```

## Notes
- Initial dp approach; the number of flips if we treat a particular bit as the split point is equivalent to the number of ones to the left of it plus the number of zeroes to the right of it.