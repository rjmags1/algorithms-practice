# 264. Ugly Number II - Medium

An ugly number is a positive integer whose prime factors are limited to `2`, `3`, and `5`.

Given an integer `n`, return the `nth` ugly number.

##### Example 1:

```
Input: n = 10
Output: 12
Explanation: [1, 2, 3, 4, 5, 6, 8, 9, 10, 12] is the sequence of the first 10 ugly numbers.
```

##### Example 2:

```
Input: n = 1
Output: 1
Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
```

##### Constraints:

- `1 <= n <= 1690`

## Solution 1

```
class Solution:
    def nthUglyNumber(self, n: int) -> int:
        baseuglies = [2, 3, 5]
        h = [1]
        seen = set()
        for i in range(2, n + 1):
            currugly = heapq.heappop(h)
            for u in baseuglies:
                p = u * currugly
                if p not in seen:
                    seen.add(p)
                    heapq.heappush(h, u * currugly)
                    
        return h[0]
```

## Notes
- Generate at least `n` ugly numbers from smaller ugly numbers, and use heap characteristics to get the `nth` smallest one after having generated at least `n` ugly numbers. Need to be careful about redundantly adding numbers to the heap, i.e. consider `2 * 3` and `3 * 2`. There is no way to programmatically avoid this due to the nature of the ugly number sequence in heap approach, so we just maintain a set to avoid redundant adds.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def nthUglyNumber(self, n: int) -> int:
        i2 = i3 = i5 = 0
        dp = [1]
        while len(dp) < n:
            next2 = 2 * dp[i2]
            next3 = 3 * dp[i3]
            next5 = 5 * dp[i5]
            nextugly = min(next2, next3, next5)
            dp.append(nextugly)
            if next2 == nextugly:
                i2 += 1
            if next3 == nextugly:
                i3 += 1
            if next5 == nextugly:
                i5 += 1
        
        return dp[-1]
```

## Notes
- Unusual dp paradigm but still, one may ask if it is possible to always know what the next smallest ugly number is without a heap. Well, for each base ugly `2, 3, 5`, we can ask which previously determined ugly number has not been multiplied by the given base yet. The smallest of these will be the next ugly number. 