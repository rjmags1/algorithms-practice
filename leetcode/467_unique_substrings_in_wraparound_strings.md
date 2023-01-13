# 467. Unique Substrings in Wraparound String - Medium

We define the string `base` to be the infinite wraparound string of `"abcdefghijklmnopqrstuvwxyz"`, so `base` will look like this:

- `"...zabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcd...."`.

Given a string `s`, return the number of unique non-empty substrings of `s` are present in `base`.

##### Example 1:

```
Input: s = "a"
Output: 1
Explanation: Only the substring "a" of s is in base.
```

##### Example 2:

```
Input: s = "cac"
Output: 2
Explanation: There are two substrings ("a", "c") of s in base.
```

##### Example 3:

```
Input: s = "zab"
Output: 6
Explanation: There are six substrings ("z", "a", "b", "za", "ab", and "zab") of s in base.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s` consists of lowercase English letters.

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(1)
class Solution:
    def findSubstringInWraproundString(self, s: str) -> int:
        l, n, dists = 0, len(s), defaultdict(int)
        onediff = lambda r: ord(s[r]) - ord(s[r - 1]) == 1 or (s[r] == 'a' and s[r - 1] == 'z')
        for r in range(n):
            dists[s[r]] = max(dists[s[r]], 1)
            if r == l or onediff(r):
                dists[s[r]] = max(dists[s[r]], r - l + 1)
            else:
                l = r
        return sum(v for v in dists.values())
```

## Notes
- For starters, note that substrings of `s` in `base` must have left to right increasing difference of `1` in their ascii values/unicode code points between characters, except the case where the left character is `z` and the right character is `a`, since `base` infinitely wraps around. 
- To solve this one with constant space we need to be careful about considering unique substrings with a sliding window approach. The sliding window finds streaks of `1` increasing LTR character relationships described above. Each time we expand the window, we have a new valid substring ending with the letter at `s[r]`. We don't need to keep a set of all valid substrings because all valid substrings ending with `s[r]` will have the same form, and the number of valid substrings ending with `s[r]` is the length of the longest valid substring ending with `s[r]` in `s`.