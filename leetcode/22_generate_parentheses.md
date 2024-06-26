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
- This is a catalan number problem. The catalan number sequence occurs in various counting problems and is often involved in enumerating recursively defined objects. The sequence: `1, 1, 2, 5, 14, 42, 132, 429, ...`. If the number of outputs for a problem grows according to that sequence or some offset of it you are probably dealing with a catalan number spacetime complexity, which is exponential in nature. 
- In this problem, for a given `n`, there will be the `nth` catalan number of valid parentheses combinations, each of which will have length `n`. The `nth` catalan number can be calculated using the equation `(2n)! / ((n + 1)! * n!)`.

## Solution - C++

```
#include <vector>
#include <string>

class Solution {
public:
    vector<string> result;
    vector<char> builder;

    vector<string> generateParenthesis(int n) {
        result.clear();
        builder.clear();
        rec(n, n);
        return this->result;
    }

    void rec(int open, int close) {
        if (open == 0 && close == 0) {
            string combo(this->builder.begin(), this->builder.end());
            this->result.push_back(combo);
            return;
        }

        if (open > 0) {
            this->builder.push_back('(');
            rec(open - 1, close);
            this->builder.pop_back();
        }

        if (close > open) {
            this->builder.push_back(')');
            rec(open, close - 1);
            this->builder.pop_back();
        }
    }
};
```