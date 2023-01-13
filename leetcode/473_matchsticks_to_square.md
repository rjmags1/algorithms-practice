# 473. Matchsticks to Square - Medium

You are given an integer array `matchsticks` where `matchsticks[i]` is the length of the `ith` matchstick. You want to use all the matchsticks to make one square. You should not break any stick, but you can link them up, and each matchstick must be used exactly one time.

Return `true` if you can make this square and `false` otherwise.

##### Example 1:

```
Input: matchsticks = [1,1,2,2,2]
Output: true
Explanation: You can form a square with length 2, one side of the square came two sticks with length 1.
```

##### Example 2:

```
Input: matchsticks = [3,3,3,3,4]
Output: false
Explanation: You cannot find a way to form a square with all the matchsticks.
```

##### Constraints:

- <code>1 <= matchsticks.length <= 15</code>
- <code>1 <= matchsticks[i] <= 10<sup>8</sup></code>

## Solution

```
from collections import Counter

# Time: O(2^n * n)
# Space: O(2^n * n)
class Solution:
    def makesquare(self, matchsticks: List[int]) -> bool:
        s = sum(matchsticks)
        sidelen = s // 4
        if s % 4 != 0 or any(m > sidelen for m in matchsticks):
            return False
        
        memo, left = set(), Counter(matchsticks)
        def rec(formed, currlen):
            li = left.items()
            if tuple(li) in memo:
                return False
            if formed == 3:
                memo.add(tuple(li))
                return sum(mlen * freq for mlen, freq in li) == sidelen
            
            for mlen, freq in li:
                if freq > 0 and currlen + mlen <= sidelen:
                    left[mlen] -= 1
                    if currlen + mlen == sidelen:
                        if rec(formed + 1, 0):
                            return True
                    elif rec(formed, currlen + mlen):
                            return True
                    left[mlen] += 1
            
            memo.add(tuple(li))
            return False
        
        return rec(0, 0)
```

## Notes
- We are interested in determining if we can form `4` sides of a square with all matchsticks. The best way to go about this is to consider all possible subsets of matchsticks, starting from the largest and recursing to smaller subsets by removing a match and placing it into the current side we are building in each recursive call. 
- Looking at this solution a second time I should note for earlier versions of python (I think < 3.8) iteration order over dictionaries may be nondeterministic depending on standard, which would mess up memoization on `tuple(li)`. A workaround would be sorting matchsticks and converting to delimited string `x`, then memoizing on slices of `x`.