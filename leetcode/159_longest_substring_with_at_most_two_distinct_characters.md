# 159. Longest Substring with At Most Two Distinct Characters - Medium

Given a string `s`, return the length of the longest substring that contains at most two distinct characters.

##### Example 1:

```
Input: s = "eceba"
Output: 3
Explanation: The substring is "ece" which its length is 3.
```

##### Example 2:

```
Input: s = "ccaabbb"
Output: 5
Explanation: The substring is "aabbb" which its length is 5.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s` consists of English letters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def lengthOfLongestSubstringTwoDistinct(self, s: str) -> int:
        n = len(s)
        lastfirst = first = result = 0
        lastsecond = None
        for i in range(1, n):
            if s[i] == s[lastfirst]:
                lastfirst = i
                continue
            if lastsecond is None or s[i] == s[lastsecond]:
                lastsecond = i
                continue
            
            result = max(result, i - first)
            first = min(lastfirst, lastsecond) + 1
            lastfirst, lastsecond = i - 1, i
        
        result = max(result, n - first)
        return result
```

## Notes
- This is a typical sliding window problem, but can be done in constant space because we only care about there being a constant number (`2`) of distinct characters in any given substring in `s`.
- Whenever we encounter a third distinct character, we need to see if the substring ending just before this third character is the longest with `2` distinct characters we have seen thus far. As long as we know the indices of the most recently seen of the `2` characters in the previous substring, we know where the next substring must start: after the lower of the two. We want to keep the suffix of the old substring that only has one distinct character in our new substring.