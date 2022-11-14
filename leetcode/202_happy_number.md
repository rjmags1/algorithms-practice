# 202. Happy Number - Easy

Write an algorithm to determine if a number `n` is happy.

A happy number is a number defined by the following process:

- Starting with any positive integer, replace the number by the sum of the squares of its digits.
- Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
- Those numbers for which this process ends in 1 are happy.

Return `true` if `n` is a happy number, and `false` if not.

##### Example 1:

```
Input: n = 19
Output: true
Explanation:
1^2 + 9^2 = 82
8^2 + 2^2 = 68
6^2 + 8^2 = 100
1^2 + 0^2 + 0^2 = 1
```

##### Example 2:

```
Input: n = 2
Output: false
```

##### Constraints:

- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(log(n))
# Space: O(log(n))
class Solution:
    def isHappy(self, n: int) -> bool:
        seen = set()
        while n != 1:
            if n in seen:
                break
            seen.add(n)
            nxt = 0
            while n:
                nxt += (n % 10) ** 2
                n //= 10
            n = nxt
        
        return n == 1
```

## Notes
- The time complexity for this question is annoying, but basically with enough examples, particularly where initial `n` is large, we can see that once we get down to `3` digits from a larger number, we will either hit a cycle or arrive at `1`. This is because once we get down to three digits `n` will never transform to a number more than `243`. And since we iterate over digits to get the next number, the transition function is logarithmic in time. We essentially perform a constant number of transitions since we are guaranteed to hit a cycle or arrive at `1`, hence the final time and space complexity above.
- Since there is a cycle involved in this question, and we proceed from one number to the next in a sequential fashion, we could use the tortoise and the hare algorithm to detect a cycle and avoid the extra memory associated with keeping a set of seen numbers. The hare in this problem would get the transition applied to it twice per main iteration, and the tortoise would get the transition applied to it once per main iteration.