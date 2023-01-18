# 522. Longest Uncommon Subsequence II - Medium

Given an array of strings `strs`, return the length of the longest uncommon subsequence between them. If the longest uncommon subsequence does not exist, return `-1`.

An uncommon subsequence between an array of strings is a string that is a subsequence of one string but not the others.

A subsequence of a string `s` is a string that can be obtained after deleting any number of characters from `s`.

- For example, `"abc"` is a subsequence of `"aebdc"` because you can delete the underlined characters in `"aebdc"` to get `"abc"`. Other subsequences of `"aebdc"` include `"aebdc"`, `"aeb"`, and `""` (empty string).


##### Example 1:

```
Input: strs = ["aba","cdc","eae"]
Output: 3
```

##### Example 2:

```
Input: strs = ["aaa","aaa","aa"]
Output: -1
```

##### Constraints:

- `2 <= strs.length <= 50`
- `1 <= strs[i].length <= 10`
- `strs[i]` consists of lowercase English letters.

## Solution

```
from collections import Counter

# Time: O(m * n^2)
# Space: O(n)
class Solution:
    def issubseq(self, seq, s, n):
        i = 0
        for c in s:
            if c == seq[i]:
                i += 1
                if i == n:
                    break
        return i == n

    def findLUSlength(self, strs: List[str]) -> int:
        maxlen = max(len(s) for s in strs)
        for l in reversed(range(1, maxlen + 1)):
            oflen = Counter([s for s in strs if len(s) == l])
            for w, freq in oflen.items():
                if freq == 1 and not any(len(s) > l and self.issubseq(w, s, l) for s in strs):
                        return l
        return -1
```

## Notes
- Greedily find the longest string that is not a subsequence of any strings longer than it; strings that are longer than other strings are the longest uncommon subsequence with the shorter string. Could optimize to constant space by checking all possible string pairs and taking the longest uncommon subsequence among all pairs, or could sort with a sorting algorithm that uses constant space (heapsort).