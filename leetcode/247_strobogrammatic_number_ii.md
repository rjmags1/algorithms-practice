# 247. Strobogrammatic Number - Medium

Given an integer `n`, return all the strobogrammatic numbers that are of length `n`. You may return the answer in any order.

A strobogrammatic number is a number that looks the same when rotated `180` degrees (looked at upside down).

##### Example 1:

```
Input: n = 2
Output: ["11","69","88","96"]
```

##### Example 2:

```
Input: n = 1
Output: ["0","1","8"]
```

##### Constraints:

- `1 <= n <= 14`

## Solution

```
# Time: O(5^n * n)
# Space: O(5^n * n)
class Solution:
    def findStrobogrammatic(self, n: int) -> List[str]:
        seeds1 = ["0", "1", "8"]
        seeds2 = ["00", "11", "88", "69", "96"]
        if n < 3:
            return seeds1 if n == 1 else seeds2[1:]
        
        odd = n & 1
        builder = [""] * n
        result = []
        strobos = {s[0]:s[1] for s in seeds2}
        def rec(size, i, j):
            if size == n:
                if builder[0] != "0":
                    result.append("".join(builder))
                return
            
            i2, j2 = i - 1, j + 1
            for left, right in strobos.items():
                builder[i2], builder[j2] = left, right
                rec(size + 2, i2, j2)
                builder[i2] = builder[j2] = ""
        
        seeds = seeds1 if odd else seeds2
        mid = n // 2 if odd else n // 2 - 1
        for seed in seeds:
            if odd:
                builder[mid] = seed
                rec(1, mid, mid)
                builder[mid] = ""
            else:
                builder[mid], builder[mid + 1] = seed[0], seed[1]
                rec(2, mid, mid + 1)
                builder[mid] = builder[mid + 1] = ""
            
        return result
```

## Notes
- Seeds, edge cases, backtracking. The complexity is what it is because the recursive call tree goes `(n // 2) + 1` calls deep, and each call branches `5` times, one for each possible strobo number pair that can be added to the outside of the current strobo number we are building.