# 483. Smallest Good Base - Hard

Given an integer `n` represented as a string, return the smallest good base of `n`.

We call `k >= 2` a good base of `n`, if all digits of `n` base `k` are `1`'s.

##### Example 1:

```
Input: n = "13"
Output: "3"
Explanation: 13 base 3 is 111.
```

##### Example 2:

```
Input: n = "4681"
Output: "8"
Explanation: 4681 base 8 is 11111.
```

##### Example 3:

```
Input: n = "1000000000000000000"
Output: "999999999999999999"
Explanation: 1000000000000000000 base 999999999999999999 is 11.
```

##### Constraints:

- `n` is an integer in the range <code>[3, 10<sup>18</sup>]</code>.
- `n` does not contain any leading zeros.

## Solution

```
# Time: O(log(n) * log(n))
# Space: O(1)
class Solution:
    def smallestGoodBase(self, n: str) -> str:
        n = int(n)
        maxbits = int(math.log2(n)) + 1
        for bits in reversed(range(2, maxbits + 1)):
            left, right = 2, n - 1
            while left <= right:
                base = (left + right) // 2
                x = (base ** (bits + 1) - 1) // (base - 1)
                if x == n:
                    return str(base)
                if x < n:
                    left = base + 1
                else:
                    right = base - 1
        return str(n - 1)
```

## Notes
- We know the smallest number of bits `n` could be represented with using just 1-bits is `2` using base `n - 1`, and the largest number of bits `n` could be represented with is `ceiling(log2(n))` using base `2`. The number of bits and the size of the base are inversely related, and so we want to greedily check the larger numbers of 1-bits first to get the 'smallest good base'. We return the base associated with the largest number of 1-bits that can represent `n`. We accomplish this by asking 'for a certain number of 1-bits `bits`, using any of the possible bases `base in [2, n - 1]`, is it possible to form `n`?'. Since `f(bits, base) = x` is monotonically increasing (geometric series) as `base` increases if we fix `bits`, we can perform binary search with `base` as the search space for a `base` that can represent `n` with `bits` 1-bits.
- The formula `x = (base ** (bits + 1) - 1) // (base - 1)` finds the number `x` that results from `bits` 1-bits using base `base`, and is derivable from the geometric series `1 * base^0 + 1 * base^1...`. Intuiting the conceptual strategy for this problem and deriving the formula needed to implement it seems a tall order for most.