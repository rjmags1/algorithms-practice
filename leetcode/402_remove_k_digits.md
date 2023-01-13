# 402. Remove K Digits - Medium

Given string `num` representing a non-negative integer `num`, and an integer `k`, return the smallest possible integer after removing `k` digits from `num`.

##### Example 1:

```
Input: num = "1432219", k = 3
Output: "1219"
Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
```

##### Example 2:

```
Input: num = "10200", k = 1
Output: "200"
Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
```

##### Example 3:

```
Input: num = "10", k = 2
Output: "0"
Explanation: Remove all the digits from the number and it is left with nothing which is 0.
```

##### Constraints:

- <code>1 <= k <= num.length <= 10<sup>5</sup></code>
- `num` consists of only digits.
- `num` does not have any leading zeros except for the zero itself.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def removeKdigits(self, num: str, k: int) -> str:
        stack = []
        for i, digit in enumerate(num):
            while k and stack and stack[-1] > digit:
                stack.pop()
                k -= 1
            if k == 0:
                result = "".join(stack) + num[i:]
                return str(int(result)) if result else "0"
            stack.append(digit)
        result = "".join(stack[:-k])
        return str(int(result)) if result else "0"
```

## Notes
- Greedy with monotonic increasing stack. The smallest number after removing `k` digits will always have the first `k` peak digits removed, where peak digits are greater than the digits after them. We need to handle the cases where there are leading zeroes in the final answer, as well as when there are less than `k` peak digits in the input string.