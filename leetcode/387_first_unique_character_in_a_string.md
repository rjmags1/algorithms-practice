# 387. First Unique Character in a String - Easy

Given a string `s`, find the first non-repeating character in it and return its index. If it does not exist, return `-1`.

##### Example 1:

```
Input: s = "leetcode"
Output: 0
```

##### Example 2:

```
Input: s = "loveleetcode"
Output: 2
```

##### Example 3:

```
Input: s = "aabb"
Output: -1
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s` consists of only lowercase English letters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def firstUniqChar(self, s: str) -> int:
        chars, offset = [-1] * 26, ord('a')
        for i, c in enumerate(s):
            k = ord(c) - offset
            if chars[k] == -1:
                chars[k] = i
            else:
                chars[k] = -2

        result = math.inf
        for k in chars:
            if k >= 0:
                result = min(result, k)
        return result if result != math.inf else -1
```

## Notes
- Find the lowest index of a nonrepeating character with an index map that gets marked with special values for not having been seen and for having been seen more than once. 