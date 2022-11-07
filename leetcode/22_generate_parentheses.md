# 22. Generate Parentheses - Medium

Given `n` pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

##### Example 1:

```
Input: n = 3
Output: ["((()))","(()())","(())()","()(())","()()()"]
```

##### Example 2:

```
Input: n = 1
Output: ["()"]
```

##### Constraints:

- `1 <= n <= 8`

## Solution

```
# Time: O((4^n) / sqrt(n))
# Space: O((4^n) / sqrt(n))
class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        result, builder = [], []
        def build(left, right):
            if left == right == 0:
                result.append("".join(builder))
                return
            
            if left > 0:
                builder.append('(')
                build(left - 1, right)
                builder.pop()
            
            if right > left:
                builder.append(')')
                build(left, right - 1)
                builder.pop()
        
        build(n, n)
        return result
```

## Notes
- This is a catalan number problem. The catalan number sequence occurs in various counting problems and is often involved in recursively defined objects. 1, 1, 2, 5, 14, 42, 132, 429.