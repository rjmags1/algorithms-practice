# 482. License Key Formatting - Easy

You are given a license key represented as a string `s` that consists of only alphanumeric characters and dashes. The string is separated into `n + 1` groups by `n` dashes. You are also given an integer `k`.

We want to reformat the string `s` such that each group contains exactly `k` characters, except for the first group, which could be shorter than `k` but still must contain at least one character. Furthermore, there must be a dash inserted between two groups, and you should convert all lowercase letters to uppercase.

Return the reformatted license key.

##### Example 1:

```
Input: s = "5F3Z-2e-9-w", k = 4
Output: "5F3Z-2E9W"
Explanation: The string s has been split into two parts, each part has 4 characters.
Note that the two extra dashes are not needed and can be removed.
```

##### Example 2:

```
Input: s = "2-5g-3-J", k = 2
Output: "2-5G-3J"
Explanation: The string s has been split into three parts, each part has 2 characters except the first part as it could be shorter as mentioned above.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- <code>1 <= k <= 10<sup>4</sup></code>
- `s` consists of English letters, digits, and dashes `'-'`.

## Solution

```
from collections import deque

# Time: O(n)
# Space: O(1) if we dont count result space
class Solution:
    def licenseKeyFormatting(self, s: str, k: int) -> str:
        result, glen = deque(), 0
        for i, c in enumerate(reversed(s)):
            if c != "-":
                result.appendleft(c.upper() if not c.isdigit() else c)
                glen += 1
                if glen == k:
                    result.appendleft("-")
                    glen = 0

        if result and result[0] == "-":
            result.popleft()
        return "".join(result)
```

## Notes
- Group characters RTL using a queue. Could also use a list and reverse.