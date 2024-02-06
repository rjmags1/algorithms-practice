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

## Solution - Python
```
# Time: O(log(n))
# Space: O(1)
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
- This question gets a lot of hate on LC but is good for learning about 32-bit vs. 64-bit environments, as well as how mod and floor can be used to manipulate integers as though they were a stack. Take special note of how we avoid overflow in a 32-bit environment, as well as reducing edge cases with a `neg` flag and conversion to absolute value.

## Solution - C++

```
#include <limits.h>

using namespace std;

// Time: O(n)
// Space: O(n)
class Solution {
public:
    int reverse(int x) {
        int maxIntLastDigit = INT_MAX % 10;
        int minIntLastDigit = maxIntLastDigit + 1;
        int intLimitsFloored = INT_MAX / 10;

        if (x == INT_MIN || x == INT_MAX || x == 0) return 0;

        bool neg = x < 0;
        if (x < 0) x = -x;
        int result = 0;
        while (x > 0) {
            int digit = x % 10;
            if (result >= intLimitsFloored) {
                if (result > intLimitsFloored || 
                    (neg ? digit > minIntLastDigit : digit > maxIntLastDigit)
                ) {
                    return 0;
                }
            }
            result = result * 10 + digit;
            x /= 10;
        }

        return neg ? -result : result;
    }
};
```
