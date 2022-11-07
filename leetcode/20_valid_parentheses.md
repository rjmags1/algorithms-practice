# 20. Valid Parentheses - Easy

Given a string `s` containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

An input string is valid if:

1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.
3. Every close bracket has a corresponding open bracket of the same type.


##### Example 1:

```
Input: s = "()"
Output: true
```

##### Example 2:

```
Input: s = "()[]{}"
Output: true
```

##### Example 3:

```
Input: s = "(]"
Output: false
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` consists of parentheses only `'()[]{}'`

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        opening = ['(', '[', '{']
        for c in s:
            if c in opening:
                stack.append(c)
            else:
                if not stack:
                    return False
                popped = stack.pop()
                if popped == '(' and c != ')':
                    return False
                elif popped == '[' and c != ']':
                    return False
                elif popped == '{' and c != '}':
                    return False
        
        return not stack
```

## Notes
- Need to be careful to check for empty stack before popping, as well as once we have iterated over the entire string.