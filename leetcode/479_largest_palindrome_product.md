# 479. Largest Palindrome Product - Hard

Given an integer `n`, return the largest palindromic integer that can be represented as the product of two `n`-digits integers. Since the answer can be very large, return it modulo `1337`.

##### Example 1:

```
Input: n = 2
Output: 987
Explanation: 99 x 91 = 9009, 9009 % 1337 = 987
```

##### Example 2:

```
Input: n = 1
Output: 9
```

##### Constraints:

- `1 <= n <= 8`

## Solution

```
# Time: O(10^n)
# Space: O(n)
class Solution:
    def largestPalindrome(self, n: int) -> int:
        if n == 1:
            return 9

        maxndig, minndig = 10 ** n - 1, 10 ** (n - 1)
        for ndignum in reversed(range(minndig, maxndig + 1)):
            s = str(ndignum)
            pal = int(s + s[::-1])
            for bigndigfactor in reversed(range(minndig, maxndig + 1)):
                smallfactor = pal // bigndigfactor
                if smallfactor > bigndigfactor:
                    break
                if pal % bigndigfactor != 0:
                    continue
                if len(str(smallfactor)) == n:
                    return pal % 1337
```

## Notes
- The product of `2` integers of `n` digits will have `2n - 1` or `2n` digits. Since we are only interested in the largest palindromic product, we only consider `2n` digits case for this problem, because it turns out that for `n in [1, 8]` all largest palindromic products have `2n` digits.
- The largest possible palindrome of `2n` digits will be the largest `n` digits number concatenated to the reverse of itself and converted to an integer. We can check all the palindromic products from largest to small and return the first one that is the product of `2` `n` digit integers.