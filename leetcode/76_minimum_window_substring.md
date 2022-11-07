# 76. Minimum Window Substring - Hard

Given two strings `s` and `t` of lengths `m` and `n` respectively, return the minimum window substring of `s` such that every character in `t` (including duplicates) is included in the window. If there is no such substring, return the empty string `""`.

The testcases will be generated such that the answer is unique.

##### Example 1:

```
Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"
Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
```

##### Example 2:

```
Input: s = "a", t = "a"
Output: "a"
Explanation: The entire string s is the minimum window.
```

##### Example 3:

```
Input: s = "a", t = "aa"
Output: ""
Explanation: Both 'a's from t must be included in the window.
Since the largest window of s only has one 'a', return empty string.
```

##### Constraints:

- `m == s.length`
- `n == t.length`
- <code>1 <= m</code>, <code>n <= 10<sup>5</sup></code>
- `s` and `t` consist of uppercase and lowercase English letters.

Follow-up: Could you find an algorithm that runs in `O(m + n)` time?

## Solution

```
# Time: O(m + n) (one pass)
# Space: O(m + n)
class Solution:
    def minWindow(self, s: str, t: str) -> str:
        need = Counter(t)
        have = defaultdict(int)
        idxs = deque()
        correctFreqs = 0
        k = len(need)
        res = [-inf, inf]
        for r, c in enumerate(s):
            if c not in need:
                continue
                
            have[c] += 1
            idxs.append(r)
            if have[c] == need[c]:
                correctFreqs += 1
                
            while correctFreqs == k:
                l = idxs.popleft()
                if res[1] - res[0] > r - l:
                    res[0], res[1] = l, r
                removed = s[l]
                have[removed] -= 1
                if have[removed] == need[removed] - 1:
                    correctFreqs -= 1
        
        start, stop = res
        return s[start:stop + 1] if stop is not inf else ""
```

## Notes
- The trickiest part of this problem solving it the first time is remembering to check for min window substrings as we shrink the window. I.e., as we shrink the window we might remove characters that we previously had an excess of such that removing them from the window does not invalidate the window substring without that removal.
- This solution avoids a second pass resulting from shrinking the sliding window by utilizing a `deque` data structure to keep track of indices of `t`-chars present in the current window. This allows us to always know the lowest index `t`-char in the current window so we don't have to iterate to it from the previous start. Since it is a `deque`, we can pop from the start and append to the end in constant time.
- There is an optimized solution on leetcode that gets rid of non-`t` chars in `s`, which considerably speeds up runtime for `s` inputs with a lot of noise.