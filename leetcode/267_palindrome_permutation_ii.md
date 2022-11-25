# 267. Palindrome Permutation II - Medium

Given a string `s`, return all the palindromic permutations (without duplicates) of it.

You may return the answer in any order. If `s` has no palindromic permutation, return an empty list.

##### Example 1:

```
Input: s = "aabb"
Output: ["abba","baab"]
```

##### Example 2:

```
Input: s = "abc"
Output: []
```

##### Constraints:

- `1 <= s.length <= 16`
- `s` consists of only lowercase English letters.

## Solution

```
# Time: O(n^26)
# Space: O(n^26)
class Solution:
    def generatePalindromes(self, s: str) -> List[str]:
        freqs = Counter(s)
        n = len(s)
        oddfreqs = [l for l, v in freqs.items() if v & 1]
        odd = n & 1
        if odd and len(oddfreqs) > 1:
            return []
        if not odd and oddfreqs:
            return []
        
        builder = [""] * n
        mid = n // 2
        i = j = None
        if odd:
            midc = oddfreqs[0]
            builder[mid] = midc
            freqs[midc] -= 1
            i = j = mid
        else:
            j, i = mid - 1, mid
        
        result = []
        def rec(size, i, j):
            if size == n:
                result.append("".join(builder))
                return
            
            for c, freq in freqs.items():
                if size > 1 and c == builder[i]:
                    continue
                for used in range(2, freq + 1, 2):
                    perside = used // 2
                    for offset in range(1, perside + 1):
                        i2, j2 = i - offset, j + offset
                        builder[i2] = builder[j2] = c
                    freqs[c] -= used
                    rec(size + used, i - perside, j + perside)
                    freqs[c] += used
        
        rec(1 if odd else 0, i, j)
        return result
```

## Notes
- At each position in the palindrome we are currently building, we could lay down one of at most `26` characters, and there are `n` positions to place characters into, where `n == len(s)`.
- Lots of edge cases to handle when building out palindromes. Need to first filter out inputs where it is impossible to make a palindrome. Then need to consider if there are an odd number of characters in the input, and use the only odd frequency character as a 'palindrome seed', and adjust the frequency tracker accordingly. From there we build each possible palindrome inside out, recursively.
- We need to take special care to avoid generating duplicate palindromes in our result however, for cases such as `s = "aaaaaa"`. We can do this by, for a particular recursive call, laying down each possibly amount of a particular character, and then being sure to not lay down the same character in a row in the next recursive call. Alternatively, one could just use a set to dedupe results, but this would result some extra recursion that can be avoided with the former strategy.