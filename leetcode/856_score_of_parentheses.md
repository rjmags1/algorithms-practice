# 856. Score of Parentheses - Medium

Given a balanced parentheses string `s`, return the score of the string.

The score of a balanced parentheses string is based on the following rule:

- `"()"`` has score 1.
- `AB` has score `A + B`, where `A` and `B` are balanced parentheses strings.
- `(A)` has score `2 * A`, where `A` is a balanced parentheses string.

##### Example 1:

```
Input: s = "()"
Output: 1
```

##### Example 2:

```
Input: s = "(())"
Output: 2
```

##### Example 3:

```
Input: s = "()()"
Output: 2
```

##### Constraints:

- `2 <= s.length <= 50`
- `s` consists of only `'('` and `')'`.
- `s` is a balanced parentheses string.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def scoreOfParentheses(self, s: str) -> int:
        n = len(s)
        i = 0
        def rec():
            nonlocal i
            if i == n:
                return 0

            result = 0
            while i < n and s[i] != ')':
                if s[i + 1] == ')':
                    result += 1
                    i += 2
                else:
                    i += 1
                    result += 2 * rec()
                    i += 1
            return result

        return rec()
```

## Notes
- Could also use a stack or count the number of surrounding parentheses around each `()`, which is equivalent to the number of unbalanced opening parentheses before a given `()`.