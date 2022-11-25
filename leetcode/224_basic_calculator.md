# 224. Basic Calculator - Hard

Given a string `s` representing a valid expression, implement a basic calculator to evaluate it, and return the result of the evaluation.

Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as `eval()`.

##### Example 1:

```
Input: s = "1 + 1"
Output: 2
```

##### Example 2:

```
Input: s = " 2-1 + 2 "
Output: 3
```

##### Example 3:

```
Input: s = "(1+(4+5+2)-3)+(6+8)"
Output: 23
```

##### Constraints:

- <code>1 <= s.length <= 3 * 10<sup>5</sup></code>
- `s` consists of digits, `'+'`, `'-'`, `'('`, `')'`, and `' '`.
- `s` represents a valid expression.
- `'+'` is not used as a unary operation (i.e., `"+1"` and `"+(2 + 3)"` is invalid).
- `'-'` could be used as a unary operation (i.e., `"-1"` and `"-(2 + 3)"` is valid).
- There will be no two consecutive operators in the input.
- Every number and running calculation will fit in a signed 32-bit integer.

## Solution

```
# Time: O(n) (2-pass)
# Space: O(n)
class Solution:
    def calculate(self, s: str) -> int:
        transf = []
        curr = i = 0
        n = len(s)
        while i < n:
            c = s[i]
            if c == " ":
                i += 1
                continue
            if c.isdigit():
                neg = transf and transf[-1] == "-"
                curr = 0
                while i < n and s[i].isdigit():
                    curr = curr * 10 + int(s[i])
                    i += 1
                if neg:
                    transf[-1] = "+"
                    curr = -curr
                transf.append(curr)
            else:
                transf.append(c)
                i += 1
        
        stack = []
        for i, elem in enumerate(transf):
            if elem in ["(", "-", "+"] or type(elem) is int:
                if elem != "+":
                    stack.append(elem)
                continue
                
            curr = 0
            while stack[-1] != "(":
                curr += stack.pop()
            stack.pop()
            if stack and stack[-1] == "-":
                stack.pop()
                curr = -curr
            stack.append(curr)
        
        return sum(stack)
```

## Notes
- The core challenge of this problem is figuring out how to handle non-associativity and non-commutativity of subtraction. This approach transforms the input in a first pass such that string numbers are transformed to integers and subtraction signs in front of numbers are transformed to addition signs and the subsequent number has its sign flipped to negative. This greatly simplifies the process of evaluating the expression, since the only subtraction signs in the transformed input will be in front of opening parens. As a result, we can apply a basic stack approach to the transformed input in a second pass with one modification: if we calculate a subexpression during the second pass and there is a subtraction sign at the top of the stack after doing so, this means the subexpression was negated in the original input, and we before adding the result of the subexpression to the top of the stack we invert its sign and pop the subtraction sign of the stack.