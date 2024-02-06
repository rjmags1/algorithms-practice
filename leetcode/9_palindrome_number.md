# 9. Palindrome Number - Easy

Given an integer `x`, return `true` if `x` is palindrome integer.
An integer is a palindrome when it reads the same backward as forward.

- For example, `121` is a palindrome while `123` is not.

##### Example 1:

```
Input: x = 121
Output: true
Explanation: 121 reads as 121 from left to right and from right to left.
```

##### Example 2:

```
Input: x = -121
Output: false
Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
```

##### Constraints:

- <code>-2<sup>31</sup> <= x <= 2<sup>31</sup> - 1</code>

Follow-up: Could you solve it without converting the integer to a string?

## Solution - Python
```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x < 0:
            return False
        rev = 0
        original = x
        while x:
            rev = rev * 10 + x % 10
            x //= 10
        return rev == original
```

## Notes
- There is another solution where only half of the original number's digits get reversed, but it requires handling several other edge cases while only reducing the above solution's time complexity by a constant factor (half).

## Solution - C++

```
using namespace std;

// Time: O(log(n))
// Space: O(1)
class Solution {
public:
    bool isPalindrome(int x) {
        if (x < 0) return false;

        long original = x;
        long reversed = 0;
        while (x > 0) {
            reversed = reversed * 10 + x % 10;
            x /= 10;
        }

        return reversed == original;
    }
};
```