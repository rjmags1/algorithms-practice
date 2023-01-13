# 484. Find Permutation - Medium

A permutation perm of `n` integers of all the integers in the range `[1, n]` can be represented as a string `s` of length `n - 1` where:

- `s[i] == 'I'` if `perm[i] < perm[i + 1]`, and
- `s[i] == 'D'` if `perm[i] > perm[i + 1]`.

Given a string `s`, reconstruct the lexicographically smallest permutation `perm` and return it.

##### Example 1:

```
Input: s = "I"
Output: [1,2]
Explanation: [1,2] is the only legal permutation that can represented by s, where the number 1 and 2 construct an increasing relationship.
```

##### Example 2:

```
Input: s = "DI"
Output: [2,1,3]
Explanation: Both [2,1,3] and [3,1,2] can be represented as "DI", but since we want to find the smallest lexicographical permutation, you should return [2,1,3]
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s[i]` is either `'I'` or `'D'`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def findPermutation(self, s: str) -> List[int]:
        n = len(s) + 1
        result = list(range(1, n + 1))
        def revrange(l, r):
            while l < r:
                result[l], result[r] = result[r], result[l]
                l += 1
                r -= 1
                
        l = None
        for i, c in enumerate(s, start=1):
            if c == "D":
                if l is None:
                    l = i - 1
            elif l is not None:
                revrange(l, i - 1)
                l = None
        if l is not None:
            revrange(l, n - 1)

        return result
```

## Notes
- Prompt is misleading, the test cases do not pass for the lexicographically smallest permutation. I.e., for `n = 10` and `s = "DIIIIIIII"`, the lexicographically smallest permuation would be `[10, 1, 2, 3, 4, 5, 6, 7, 8, 9]`, but the test case behavior rejects this for a solution such as `[2, 1, 3, 4, 5, 6, 7, 8, 9, 10]`. 
- Test cases pass for the smallest permutation of numbers in `[1, n]` that handles `"D"` in `s` by shifting the smallest numbers possible left in the permutation. We can use a stack or reverse ranges of `list(range(1, n + 1))` to handle `"D"` streaks trivially.