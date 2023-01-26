# 564. Find the Closest Palindrome - Hard

Given a string `n` representing an integer, return the closest integer (not including itself), which is a palindrome. If there is a tie, return the smaller one.

The closest is defined as the absolute difference minimized between two integers.

##### Example 1:

```
Input: n = "123"
Output: "121"
```

##### Example 2:

```
Input: n = "1"
Output: "0"
Explanation: 0 and 2 are the closest palindromes but we return the smallest which is 0.
```

##### Constraints:

- `1 <= n.length <= 18`
- `n` consists of only digits.
- `n` does not have leading zeros.
- `n` is representing an integer in the range <code>[1, 10<sup>18</sup> - 1]</code>.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def nearestPalindromic(self, n: str) -> str:
        l, x = len(n), int(n)
        if l == 1:
            return str(x - 1)
        spec1, spec2, spec3 = "1" + "0" * (l - 1), "1" + "0" * (l - 2) + "1", "9" * l
        if n == spec1 or n == spec2:
            return spec3[:-1]
        if n == spec3:
            return spec1 + "1"
        
        front = n[:(l // 2 if l & 1 else l // 2 - 1) + 1]
        bfront, sfront = str(int(front) + 1), str(int(front) - 1)
        a = front + front[::-1] if not l & 1 else front + front[::-1][1:]
        b = bfront + bfront[::-1] if not l & 1 else bfront + bfront[::-1][1:]
        c = sfront + sfront[::-1] if not l & 1 else sfront + sfront[::-1][1:]
        k = lambda cand: (math.inf, cand) if cand == n else (abs(int(cand) - x), cand)
        return min(a, b, c, key=k)
```

## Notes
- This question has one of the lowest acceptance rates on leetcode (22%) because of specific edge cases that need to be handled; the core of the algorithm is not too bad if you have sufficient familiarity with palindromes. Palindromes have the first half of themselves reflected in their second half. It follows that the nearest palindromic integer to some integer `n` has the same number of digits as `n` and would have the same first half as `n` or have its first half differ by `1`, because all other palindromic integers will be further from `n`. So we just check these three possibilities, taking care to correctly handle odd vs. even length palindromes.
- This works for the vast majority of cases, except for when `n` is a single digit or when `n` has the form `1000..001`, `1000..000`, or `999..99`. For the single digit case, the result will always be `n - 1`. For the `100...001` and `100..000` cases, the result will always be `9999..99` with one less digit than `n`. For the `999..999` case, the result will always be `100..001` with one more digit than `n`.