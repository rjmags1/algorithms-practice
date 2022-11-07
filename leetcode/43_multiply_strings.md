# 43. Multiply String - Medium

Given two non-negative integers `num1` and `num2` represented as strings, return the product of `num1` and `num2`, also represented as a string.

Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.

##### Example 1:

```
Input: num1 = "2", num2 = "3"
Output: "6"
```

##### Example 2:

```
Input: num1 = "123", num2 = "456"
Output: "56088"
```

##### Constraints:

- `1 <= num1.length, num2.length <= 200`
- `num1` and `num2` consist of digits only. 
- Both `num1` and `num2` do not contain any leading zero, except the number `0` itself.

## Solution

```
# Time: O(n * m)
# Space: O(m + n)
class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if num1 == "0" or num2 == "0":
            return "0"
        
        m, n = len(num1), len(num2)
        amounts = [0] * (m + n)
        for i in range(m):
            digit1 = int(num1[i])
            for j in range(n):
                digit2 = int(num2[j])
                k = i + j + 1
                amounts[k] += digit1 * digit2
                
        result = []
        for i in range(len(amounts) - 1, 0, -1):
            amount = amounts[i]
            result.append(str(amount % 10))
            amounts[i - 1] += amount // 10
        if amounts[0] > 0:
            result.append(str(amounts[0]))
            
        result.reverse()
        return "".join(result)
```

## Notes
- Main thing here is noticing that we can be efficient with time and space if we store sums of all digit products whose digits have the same summed power of `10`. I.e., if we multiply `a = "999"` by `b = "999"`, we can save space by adding `a[0] * b[2]` with `a[2] * b[0]` and `a[1] * b[1]`, and storing the sum in `amounts[3]`.
- `amounts` is the length it is because for any two numbers, their product will have length equal to the sum of the lengths of the two numbers, or their length sum minus `1`. This is verifiable with a bit of experimentation, i.e., `999 * 999 == 998001`.
- Once we have finished multiplying all digit pairs of `num1` and `num2`, all that's left is to build our answer, carrying as needed to `amounts[i - 1]` as we iterate RTL through `amounts`. Again, with a bit of experimentation, it becomes apparent that even if we end up carrying multi-digit numbers, we will never carry so much that we overflow `amounts`.