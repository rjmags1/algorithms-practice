# 633. Sum of Square Numbers - Medium

Given a non-negative integer `c`, decide whether there're two integers `a` and `b` such that <code>a<sup>2</sup> + b<sup>2</sup> = c</code>.

##### Example 1:

```
Input: c = 5
Output: true
Explanation: 1 * 1 + 2 * 2 = 5
```

##### Example 2:

```
Input: c = 3
Output: false
```

##### Constraints:

- <code>0 <= c <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(sqrt(c) * log(c))
# Space: O(1)
class Solution:
    def judgeSquareSum(self, c: int) -> bool:
        a = 0
        while a * a <= c:
            b = sqrt(c - a * a)
            if b == int(b):
                return True
            a += 1
        
        return False
```

## Notes
- `sqrt` function takes logarithmic time
- It seems like you could use 2 pointer approach, but cases like `c = 2` where `a == b` doesn't pass.