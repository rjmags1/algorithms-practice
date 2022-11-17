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
# Time: O(((2n)! / ((n + 1)! * n!)) * n)
# Space: O(((2n)! / ((n + 1)! * n!)) * n)
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
- This is a catalan number problem. The catalan number sequence occurs in various counting problems and is often involved in enumerating the number of recursively defined objects. The sequence: 1, 1, 2, 5, 14, 42, 132, 429. If the number of outputs for a problem grows according to that sequence or some offset of it you are probably dealing with a catalan number spacetime complexity, which is factorial in nature. 
- In this problem, for a given `n`, there will be the `nth` catalan number of valid parentheses combinations, each of which will have length `n`. The `nth` catalan number can be calculated using the equation (2n)! / ((n + 1)! * n!).