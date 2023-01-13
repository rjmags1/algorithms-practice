# 439. Ternary Expression Parser - Medium

Given a string `expression` representing arbitrarily nested ternary expressions, evaluate the expression, and return the result of it.

You can always assume that the given expression is valid and only contains digits, `'?'`, `':'`, `'T'`, and `'F'` where `'T'` is `true` and `'F'` is `false`. All the numbers in the expression are one-digit numbers (i.e., in the range `[0, 9]`).

The conditional expressions group right-to-left (as usual in most languages), and the result of the expression will always evaluate to either a digit, `'T'` or `'F'`.

##### Example 1:

```
Input: expression = "T?2:3"
Output: "2"
Explanation: If true, then result is 2; otherwise result is 3.
```

##### Example 2:

```
Input: expression = "F?1:T?4:5"
Output: "4"
Explanation: The conditional expressions group right-to-left. Using parenthesis, it is read/evaluated as:
"(F ? 1 : (T ? 4 : 5))" --> "(F ? 1 : 4)" --> "4"
or "(F ? 1 : (T ? 4 : 5))" --> "(T ? 4 : 5)" --> "4"
```

##### Example 3:

```
Input: expression = "T?T?F:5:3"
Output: "F"
Explanation: The conditional expressions group right-to-left. Using parenthesis, it is read/evaluated as:
"(T ? (T ? F : 5) : 3)" --> "(T ? F : 3)" --> "F"
"(T ? (T ? F : 5) : 3)" --> "(T ? F : 5)" --> "F"
```

##### Constraints:

- <code>5 <= expression.length <= 10<sup>4</sup></code>
- `expression` consists of digits, `'T'`, `'F'`, `'?'`, and `':'`.
- It is guaranteed that `expression` is a valid ternary expression and that each number is a one-digit number.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def parseTernary(self, expression: str) -> str:
        stack, n = [], len(expression)
        i = n - 1
        special = [":", "?"]
        while i >= 0:
            c = expression[i]
            if c not in special:
                stack.append(c)
            elif c == "?":
                i -= 1
                c = expression[i]
                if c == "T":
                    temp = stack.pop()
                    stack.pop()
                    stack.append(temp)
                else:
                    stack.pop()
            i -= 1
            
        return stack[0]
```

## Notes
- Notice how the innermost ternary expression in a nested ternary expression evaluates to one of the two values closest to its question mark. This is a perfect use case for a stack if we iterate over the input RTL.