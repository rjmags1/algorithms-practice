# 258. Add Digits - Easy

Given an integer `num`, repeatedly add all its digits until the result has only one digit, and return it.

##### Example 1:

```
Input: num = 38
Output: 2
Explanation: The process is
38 --> 3 + 8 --> 11
11 --> 1 + 1 --> 2 
Since 2 has only one digit, return it.
```

##### Example 2:

```
Input: num = 0
Output: 0
```

##### Constraints:

- <code>0 <= num <= 2<sup>31</sup> - 1</code>

Follow up: Could you do it without any loop/recursion in O(1) runtime?

## Solution 1

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def addDigits(self, num: int) -> int:
        while num > 9:
            curr = 0
            while num:
                curr += num % 10
                num //= 10
            num = curr
        return num
```

## Notes
- We lose at least one digit each time we sum a numbers digit, so logarithmic time.

## Solution 2

```
# Time: O(1)
# Space: O(1)
class Solution:
    def addDigits(self, num: int) -> int:
        if num == 0:
            return 0
        return 9 if num % 9 == 0 else 1 + (num - 1) % 9
```

## Notes
- Esoteric digit root, follows from observing <code>n = d<sub>k</sub> * 10<sup>k - 1</sup> + ... + d<sub>1</sub> * 10<sup>0</sup></code>. We can isolate the sum of all of the digits <code>d<sub>k...1</sub></code> by factoring out `9`s from the powers of ten.
- To derive in an interview would be difficult but with enough experience solving leetcode problems interviewees should have an idea to mess with the geometric sequence that yields a number `n` through constitutive powers of ten.