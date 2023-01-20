# 541. Reverse String II - Easy

Given a string `s` and an integer `k`, reverse the first `k` characters for every `2k` characters counting from the start of the string.

If there are fewer than `k` characters left, reverse all of them. If there are less than `2k` but greater than or equal to `k` characters, then reverse the first `k` characters and leave the other as original.

##### Example 1:

```
Input: s = "abcdefg", k = 2
Output: "bacdfeg"
```

##### Example 2:

```
Input: s = "abcd", k = 2
Output: "bacd"
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- <code>1 <= k <= 10<sup>4</sup></code>
- `s` consists of only lowercase English letters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def reverseStr(self, s: str, k: int) -> str:
        result, n = [], len(s)
        for i in range(0, n, 2 * k):
            for j in reversed(range(i, min(n, i + k))):
                result.append(s[j])
            for j in range(i + k, min(n, 2 * k + i)):
                result.append(s[j])
        return "".join(result)
```

## Notes
- Iterate and collect letters of `s` according to the problem constraints.