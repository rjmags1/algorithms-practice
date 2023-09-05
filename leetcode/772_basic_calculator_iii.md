# 772. Basic Calculator III - Hard

Implement a basic calculator to evaluate a simple expression string.

The expression string contains only non-negative integers, `'+'`, `'-'`, `'*'`, `'/'` operators, and open `'('` and closing parentheses `')'`. The integer division should truncate toward zero.

You may assume that the given expression is always valid. All intermediate results will be in the range of <code>[-2<sup>31</sup>, 2<sup>31</sup> - 1]</code>.

Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as `eval()`.

##### Example 1:

```
Input: s = "1+1"
Output: 2
```

##### Example 2:

```
Input: s = "6-4/2"
Output: 4
```

##### Example 3:

```
Input: s = "2*(5+5*2)/3+(6/2+8)"
Output: 21
```

##### Constraints:

- <code>1 <= s <= 10<sup>4</sup></code>
- `s` consists of digits, `'+'`, `'-'`, `'*'`, `'/'`, `'('`, and `')'`.
- `s` is a valid expression.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def calculate(self, s: str) -> int:
        i, n = 0, len(s)
        def eval_stack(stack):
            stack2 = []
            for token in stack:
                if type(token) == int:
                    if stack2 and stack2[-1] == '*':
                        stack2.pop()
                        stack2.append(stack2.pop() * token)
                    elif stack2 and stack2[-1] == '/':
                        stack2.pop()
                        stack2.append(int(stack2.pop() / token))
                    else:
                        stack2.append(token)
                else:
                    stack2.append(token)
            return sum(stack2)

        def rec():
            nonlocal i
            stack = []
            while i < n:
                if s[i].isdigit():
                    num = 0
                    while i < n and s[i].isdigit():
                        num = num * 10 + int(s[i])
                        i += 1
                    if stack and stack[-1] == '-':
                        stack.pop()
                        num *= -1
                    stack.append(num)
                elif s[i] in ['-', '*', '/', '+']:
                    if s[i] != '+':
                        stack.append(s[i])
                    i += 1
                elif s[i] == '(':
                    i += 1
                    expr_result = rec()
                    if stack and stack[-1] == '-':
                        stack.pop()
                        expr_result *= -1
                    stack.append(expr_result)
                elif s[i] == ')':
                    i += 1
                    break

            return eval_stack(stack)
        
        return rec()
```

## Notes
- Use a stack to evaluate individual parenthesized expressions, recursing on parenthesized subexpressions. The stack is useful for handling subtraction signs as well as evaluating precedence of multiplication and division.