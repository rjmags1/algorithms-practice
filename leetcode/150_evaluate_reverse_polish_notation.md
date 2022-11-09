# 150. Evaluate Reverse Polish Notation - Medium

Evaluate the value of an arithmetic expression in Reverse Polish Notation.

Valid operators are `+`, `-`, `*`, and `/`. Each operand may be an integer or another expression.

Note that division between two integers should truncate toward zero.

It is guaranteed that the given RPN expression is always valid. That means the expression would always evaluate to a result, and there will not be any division by zero operation.

##### Example 1:

```
Input: tokens = ["2","1","+","3","*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9
```

##### Example 2:

```
Input: tokens = ["4","13","5","/","+"]
Output: 6
Explanation: (4 + (13 / 5)) = 6
```

##### Example 3:

```
Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
Output: 22
Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
= ((10 * (6 / (12 * -11))) + 17) + 5
= ((10 * (6 / -132)) + 17) + 5
= ((10 * 0) + 17) + 5
= (0 + 17) + 5
= 17 + 5
= 22
```

##### Constraints:

- <code>1 <= tokens.length <= 10<sup>4</sup></code>
- `tokens[i]` is either an operator: `"+"`, `"-"`, `"*"`, or `"/"`, or an integer in the range `[-200, 200]`.

## Solution

```
# Time: O(n)
# Space: O(n)
PLUS, MINUS, MUL, DIV = "+", "-", "*", "/"
class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        stack = []
        ops = {PLUS, MINUS, MUL, DIV}
        for tok in tokens:
            if tok in ops:
                r = stack.pop()
                l = stack.pop()
                if tok == PLUS:
                    stack.append(l + r)
                elif tok == MINUS:
                    stack.append(l - r)
                elif tok == MUL:
                    stack.append(l * r)
                elif tok == DIV:
                    stack.append(int(l / r))
            else:
                stack.append(int(tok))
        
        return stack[0]
```

## Notes
- Trivial stack problem, however it is annoying handling the integer division truncation to zero constraint if you haven't seen a problem requiring it before. Floor in python always floors down, i.e. `6 // -9 == 3` in python, whereas `6 // 9 == 0`. Performing float division and casting back to integer does the trick in python.