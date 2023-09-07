# 767. Reorganize String - Medium

Given a string `s`, rearrange the characters of `s` so that any two adjacent characters are not the same.

Return any possible rearrangement of `s` or return `""` if not possible.

##### Example 1:

```
Input: s = "aab"
Output: "aba"
```

##### Example 2:

```
Input: s = "aaab"
Output: ""
```

##### Constraints:

- `1 <= s.length <= 500`
- `s` consists of lowercase English letters.

## Solution

```
from collections import Counter

# Time: O(n)
# Space: O(1)
class Solution:
    def reorganizeString(self, s: str) -> str:
        n = len(s)
        freqs = Counter(s)
        maxfreq = max(f for f in freqs.values())
        result = []
        for _ in range(n):
            c = max((c for c in freqs.keys()), key=lambda c: freqs[c])
            if not result or result[-1] != c:
                result.append(c)
                freqs[c] -= 1
                if freqs[c] == 0:
                    freqs.pop(c)
                continue
                
            if len(freqs) == 1:
                return ""
            c2 = max((c2 for c2 in freqs.keys() if c2 != c), key=lambda c2: freqs[c2])
            result.append(c2)
            freqs[c2] -= 1
            if freqs[c2] == 0:
                freqs.pop(c2)

        return "".join(result)
```

## Notes
- If it is possible to reorganize the string, we can guarantee correct letter ordering by always placing the letter with the highest frequency that wasn't previous placed into the next position of the string. If we ever get to a point where this is not possible because there is only one character left, it is impossible to reorder the string in accordance with the prompt. Since there are only `26` possible characters, we have `O(n)` time complexity.