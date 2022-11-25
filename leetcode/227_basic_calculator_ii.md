# 227. Basic Calculator II - Medium

Given a string `s` which represents an expression, evaluate this expression and return its value. 

The integer division should truncate toward zero.

You may assume that the given expression is always valid. All intermediate results will be in the range of <code>[-2<sup>31</sup>, 2<sup>31</sup> - 1]</code>.

Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as `eval()`.

##### Example 1:

```

```

##### Example 2:

```

```

##### Example 3:

```

```

##### Constraints:

- <code>1 <= s.length <= 3 * 10<sup>5</sup></code>
- `s` consists of integers and operators (`'+'`, `'-'`, `'*'`, `'/'`) separated by some number of spaces.
- `s` represents a valid expression.
- All the integers in the expression are non-negative integers in the range <code>[0, 2<sup>31</sup> - 1]</code>.
- The answer is guaranteed to fit in a 32-bit integer.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def calculate(self, s: str) -> int:
        stack = []
        prec = ["*", "/"]
        i, n = 0, len(s)
        while i < n:
            c = s[i]
            if c == " ":
                i += 1
            elif c.isdigit():
                curr = 0
                while i < n and s[i].isdigit():
                    curr = curr * 10 + int(s[i])
                    i += 1
                if stack and stack[-1] in prec:
                    precop = stack.pop()
                    left = stack.pop()
                    if precop == "*":
                        stack.append(left * curr)
                    else:
                        stack.append(int(left / curr))
                else:
                    stack.append(curr)
            else:
                stack.append(c)
                i += 1
        
        result, m = stack[0], len(stack)
        for i in range(2, m, 2):
            if stack[i - 1] == "+":
                result += stack[i]
            else:
                result -= stack[i]
                
        return result
```

## Notes
- Multiplication and division take precedence over addition and subtraction, so evaluate all multiplication and division operations LTR before performing the addition and subtraction operations. Pretty typical stack question.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def calculate(self, s: str) -> int:
        prec = ["*", "/"]
        i, n = 0, len(s)
        result = prevnum = 0
        sign = 1
        prevprec = None
        while i < n:
            c = s[i]
            if c == " ":
                i += 1
            elif c.isdigit():
                curr = 0
                while i < n and s[i].isdigit():
                    curr = curr * 10 + int(s[i])
                    i += 1
                if prevprec:
                    if prevprec == "*":
                        prevnum *= curr
                    else:
                        prevnum //= curr
                else:
                    prevnum = curr
            else:
                if c in prec:
                    prevprec = c
                elif c == "+":
                    result += prevnum * sign
                    sign = 1
                    prevprec = None
                else:
                    result += prevnum * sign
                    sign = -1
                    prevprec = None
                    
                i += 1
        
        return result + prevnum * sign
```

## Notes
- This can be done in constant space by tracking previous numbers and previous operators. 
- If we are at a number and the previous operator was multiplication or division, we can lump the result of the previous number multiplied/divided by the current number into the previous number. 
- If we are at an addition or subtraction operator, we can add the previous number to the result because it is not going to be involved in a multiplcation/division expression. We need to be mindful of if the current operator in this scenario is subtraction, because if it is it will cause the sign of the next expression to be negative.