# 424. Longest Repeating Character Replacement - Medium

You are given a string `s` and an integer `k`. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most `k` times.

Return the length of the longest substring containing the same letter you can get after performing the above operations.

##### Example 1:

```
Input: s = "ABAB", k = 2
Output: 4
Explanation: Replace the two 'A's with two 'B's or vice versa.
```

##### Example 2:

```
Input: s = "AABABBA", k = 1
Output: 4
Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
The substring "BBBB" has the longest repeating letters, which is 4.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `0 <= k <= s.length`
- `s` consists of only uppercase English letters.

## Solution

```
from collections import deque

# Time: O(n)
# Space: O(k)
class Solution:
    def longestkdiff(self, s, letter, k):
        spent = result = l = 0
        q = deque()
        for r, c in enumerate(s):
            if c != letter:
                spent += 1
                q.append(r)
                if spent <= k:
                    continue
                l = q.popleft() + 1
                spent -= 1
            result = max(result, r - l + 1)
                
        return max(result, len(s) - l)

    def characterReplacement(self, s: str, k: int) -> int:
        letters = set(s)
        result = 0
        for letter in letters:
            result = max(result, self.longestkdiff(s, letter, k))
        return result
```

## Notes
- For each unique character in the input, use sliding window technique to determine the longest substring containing no more than `k` other characters. Since the prompt tells us there will only be at most `26` unique characters in the input, this is reasonable, but if we had a larger or unbounded charset this wouldn't work.
- This solution could be optimized to a single pass if we recognize we can expand the sliding window when the most frequent character in the current window has a frequency greater than the the frequencies of all the other characters in the window by no more than `k`. As long as we keep track of the most frequent window character, we can always know whether to expand or shrink the window as we move through the string in one pass.