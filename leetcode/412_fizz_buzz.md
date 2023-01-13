# 412. Fizz Buzz - Easy

Given an integer `n`, return a string array `answer` (1-indexed) where:

- `answer[i] == "FizzBuzz"` if `i` is divisible by `3` and `5`.
- `answer[i] == "Fizz"` if `i` is divisible by `3`.
- `answer[i] == "Buzz"` if `i` is divisible by `5`.
- `answer[i] == i` (as a string) if none of the above conditions are true.

##### Example 1:

```
Input: n = 3
Output: ["1","2","Fizz"]
```

##### Example 2:

```
Input: n = 5
Output: ["1","2","Fizz","4","Buzz"]
```

##### Example 3:

```
Input: n = 15
Output: ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]
```

##### Constraints:

- <code>1 <= n <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def fizzBuzz(self, n: int) -> List[str]:
        result = []
        f, b, fb = "Fizz", "Buzz", "FizzBuzz"
        for i in range(1, n + 1):
            if i % 15 == 0:
                result.append(fb)
            elif i % 5 == 0:
                result.append(b)
            elif i % 3 == 0:
                result.append(f)
            else:
                result.append(str(i))
                
        return result
```

## Notes
- Classic