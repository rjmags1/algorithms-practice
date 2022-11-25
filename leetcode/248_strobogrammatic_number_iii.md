# 248. Strobogrammatic Number III - Hard

Given two strings low and high that represent two integers `low` and `high` where `low <= high`, return the number of strobogrammatic numbers in the range `[low, high]`.

A strobogrammatic number is a number that looks the same when rotated `180` degrees (looked at upside down).

##### Example 1:

```
Input: low = "50", high = "100"
Output: 3
```

##### Example 2:

```
Input: low = "0", high = "0"
Output: 1
```

##### Constraints:

- `1 <= low.length, high.length <= 15`
- `low` and `high` consist of only digits.
- `low <= high`
- `low` and `high` do not contain any leading zeros except for zero itself.

## Solution

```
# Time: O(5^m)
# Space: O(5^m)
class Solution:
    def strobogrammaticInRange(self, low: str, high: str) -> int:
        strobos = ["0", "1", "6", "8", "9"]
        m, n = len(high), len(low)
        if m == 1:
            return len([d for d in strobos 
                        if low <= d <= high and d not in ["6", "9"]])

        low, high = int(low), int(high)
        builder = [""] * m
        result = 0
        def rec(size, l, r):
            nonlocal result
            if n <= size <= m and low <= int("".join(builder)) <= high:
                if builder[l] not in ["0", "00"]:
                    result += 1
            if size + 2 > m:
                return
            
            l2, r2 = l - 1, r + 1
            for num in strobos:
                if num == "6":
                    builder[l2], builder[r2] = "6", "9"
                    rec(size + 2, l2, r2)
                elif num == "9":
                    builder[l2], builder[r2] = "9", "6"
                    rec(size + 2, l2, r2)
                else:
                    builder[l2] = builder[r2] = num
                    rec(size + 2, l2, r2)
                builder[l2] = builder[r2] = ""
                
        mid = m // 2
        seeds = ["0", "1", "8", "00", "11", "88", "69", "96"]
        for seed in seeds:
            builder[mid] = seed
            rec(len(seed), mid, mid)
            builder[mid] = ""
        
        return result if low > 0 else result + 1
```

## Notes
- The trickiest part of this problem is figuring out which digits are strobogrammatic and how to build larger strobogrammatic numbers from them: start building from the center of a strobogrammatic number and expand outwards, building a palindrome with other strobogrammatic digits, with special handling for the strobogrammatic digits `6` and `9`.
- Concept of seeds __greatly__ simplifies initial recursive calls! Beyond figuring out the number building paradigm, this problem is basic backtracking with a variety of annoying edge cases: leading zeroes, single digit `high`, appropriate ways to start palindrome building (seeds).