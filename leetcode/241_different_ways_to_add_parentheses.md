# 241. Different Ways to Add Parentheses - Medium

Given a string `expression` of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. You may return the answer in any order.

The test cases are generated such that the output values fit in a 32-bit integer and the number of different results does not exceed <code>10<sup>4</sup></code>.

##### Example 1:

```
Input: expression = "2-1-1"
Output: [0,2]
Explanation:
((2-1)-1) = 0 
(2-(1-1)) = 2
```

##### Example 2:

```
Input: expression = "2*3-4*5"
Output: [-34,-14,-10,-10,10]
Explanation:
(2*(3-(4*5))) = -34 
((2*3)-(4*5)) = -14 
((2*(3-4))*5) = -10 
(2*((3-4)*5)) = -10 
(((2*3)-4)*5) = 10
```

##### Constraints:

- `1 <= expression.length <= 20`
- `expression` consists of digits and the operator `'+'`, `'-'`, and `'*'`.
- All the integer values in the input expression are in the range `[0, 99]`.

## Solution

```
class Solution:
    def diffWaysToCompute(self, expression: str) -> List[int]:
        ops = ["+", "-", "*"]
        @cache
        def rec(s):
            if all([c.isdigit() for c in s]):
                return [int(s)]
            
            ways = []
            for i, c in enumerate(s):
                if c not in ops:
                    continue
                leftways = rec(s[:i])
                rightways = rec(s[i + 1:])
                for l in leftways:
                    for r in rightways:
                        if c == "*":
                            ways.append(l * r)
                        elif c == '+':
                            ways.append(l + r)
                        else:
                            ways.append(l - r)
            return ways
        
        return rec(expression)
```

## Notes
- This is another Catalan number question. Notice how the answers for different possible number of operators stagger with the catalan number sequence, which is `(1, 1, 2, 5, 14, 42, 132, ...)`. Similar to the unique bst's question, the number of ways to group parentheses in a given expression is equal to the number of ways to group parentheses in its subexpressions. If you picture a operators as non-leaf nodes in a tree that gets evaluated in an inorder fashion (which is how programming languages model and evaluate mathematical expressions) we are solving the same essential problem as we were in unique bsts.