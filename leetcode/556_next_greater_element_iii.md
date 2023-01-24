# 556. Next Greater Element III - Medium

Given a positive integer `n`, find the smallest integer which has exactly the same digits existing in the integer `n` and is greater in value than `n`. If no such positive integer exists, return `-1`.

Note that the returned integer should fit in 32-bit integer, if there is a valid answer but it does not fit in 32-bit integer, return `-1`.

##### Example 1:

```
Input: n = 12
Output: 21
```

##### Example 2:

```
Input: n = 21
Output: -1
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def nextGreaterElement(self, n: int) -> int:
        s, k = list(str(n)), None
        m = len(s)
        for i in reversed(range(m - 1)):
            if s[i + 1] > s[i]:
                k = i
                break
        if k is None:
            return -1
        j = None
        for i in reversed(range(k + 1, m)):
            if s[k] < s[i] and (j is None or s[i] < s[j]):
                j = i
        s[k], s[j] = s[j], s[k]
        result = int("".join(s[:k + 1] + s[k + 1:][::-1]))
        return result if result < 2 ** 31 else -1
```

## Notes
- This is a restatement of the next greatest permutation problem. Swap the first decreasing digit `x` at `i` with the smallest number to the right of `x` greater than `x`, then reverse `n[i + 1:]` into a non-descending sequence of digits.