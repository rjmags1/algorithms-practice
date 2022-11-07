# 3. Longest Substring Without Repeating Characters - Medium

Given a string `s`, find the length of the longest substring without repeating characters.

##### Example 1:

```
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
```

##### Example 2:

```
Input: s = "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
```

##### Example 3:

```
Input: s = "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
```



##### Constraints:

- <code>0 <= s.length <= 5 * 10<sup>4</sup></code> 
- `s` consists of English letters, digits, symbols and spaces.


## Solution
```
Time: O(n) (one pass!)
Space: O(max(m, n)) where m is size of charset
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        idxs = {}
        result = start = 0
        for stop, c in enumerate(s):
            if c in idxs:
                result = max(result, stop - start)
                # idx of duplicate c could be before or after current start
                start = max(start, idxs[c] + 1) 
            idxs[c] = stop
        
        return max(result, len(s) - start)
```

## Notes
- This is a classic sliding window problem. A lot of people solve SW problems with `while` loops but `for` loop approach is cleaner IMO.
- We avoid a second `O(n)` pass by storing most recently seen indices of encountered characters in a hash table, as opposed to using a set.
- Be careful about reassigning `start` when a duplicate character is encountered; the current value of `start` could be greater than or less than the index of the previous instance of `c` + 1.