# 395. Longest Substring with At Least K Repeating Characters - Medium

Given a string `s` and an integer `k`, return the length of the longest substring of `s` such that the frequency of each character in this substring is greater than or equal to `k`.

##### Example 1:

```
Input: s = "aaabb", k = 3
Output: 3
Explanation: The longest substring is "aaa", as 'a' is repeated 3 times.
```

##### Example 2:

```
Input: s = "ababbc", k = 2
Output: 5
Explanation: The longest substring is "ababb", as 'a' is repeated 2 times and 'b' is repeated 3 times.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` consists of only lowercase English letters.
- <code>1 <= k <= 10<sup>5</sup></code>

## Solution

```
from collections import defaultdict

# Time: O(nm) where m is charset size
# Space: O(m)
class Solution:
    def longestSubstring(self, s: str, k: int) -> int:
        n = len(s)
        if k == 1:
            return n

        unique = len(set(s))
        result = 0
        for numunique in range(1, unique + 1):
            freqs, need = defaultdict(int), 1
            freqs[s[0]] += 1
            l = 0
            for i in range(1, n):
                freqs[s[i]] += 1
                if freqs[s[i]] == k:
                    need -= 1
                if freqs[s[i]] == 1:
                    need += 1
                while len(freqs) > numunique:
                    if freqs[s[l]] == k:
                        need += 1
                    freqs[s[l]] -= 1
                    if freqs[s[l]] == 0:
                        freqs.pop(s[l])
                        need -= 1
                    l += 1
                if need == 0:
                    result = max(result, i - l + 1)

        return result
```

## Notes
- To solve this in linear time, we need a way to consider all substrings such that all substring characters are repeated at least `k` times. This is impossible to do with the naive sliding window idea, however we can apply sliding window by considering valid substrings with a fixed number of unique characters in them; there can only be `26` possible unique characters in the input based on prompt constraints. So for each possible amount of unique substring characters, we do a sliding window run, shrinking the window whenever there are an excessive number of characters in the substring and performing a `max` on the result whenever we have a valid `k` repeats substring.