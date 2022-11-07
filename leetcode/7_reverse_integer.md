# 7. Reverse Integer - Medium

Given a signed 32-bit integer `x`, return `x` with its digits reversed. If reversing `x` causes the value to go outside the signed 32-bit integer range <code>[-2<sup>31</sup>, 2<sup>31</sup> - 1]</code>, then return `0`.

Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

##### Example 1:

```
Input: x = 123
Output: 321
```

##### Example 2:

```
Input: x = -123
Output: -321
```

##### Example 3:

```
Input: x = 120
Output: 21
```



##### Constraints:

- <code>-2<sup>31</sup> <= x <= 2<sup>31</sup> - 1</code>

## Solution
```
class Solution:
    def reverse(self, x: int) -> int:
        MAX_INT = 2 ** 31 - 1
        ABS_MIN_INT = 2 ** 31
        floored = MAX_INT // 10
        maxMod = MAX_INT % 10
        minMod = ABS_MIN_INT % 10
        
        result = 0
        neg = x < 0
        x = abs(x)
        while x:
            # these conditions check for overflow but respect the 
            # 32-bit integer range constraint
            if not neg and (result > floored or (result == floored and x % 10 > maxMod)):
                return 0
            if neg and (result > floored or (result == floored and x % 10 > minMod)):
                return 0
            
            result = result * 10 + x % 10
            x //= 10
        
        return -result if neg else result
```

## Notes
- This question gets a lot of hate on LC but is good for learning about 32-bit vs. 64-bit integer environments, as well as how mod and floor can be used manipulate integers as though they were a stack.