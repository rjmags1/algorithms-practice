# 471. Encode String with Shortest Length - Hard

Given a string `s`, encode the string such that its encoded length is the shortest.

The encoding rule is: `k[encoded_string]`, where the `encoded_string` inside the square brackets is being repeated exactly `k` times. `k` should be a positive integer.

If an encoding process does not make the string shorter, then do not encode it. If there are several solutions, return any of them.

##### Example 1:

```
Input: s = "aaa"
Output: "aaa"
Explanation: There is no way to encode it such that it is shorter than the input string, so we do not encode it.
```

##### Example 2:

```
Input: s = "aaaaa"
Output: "5[a]"
Explanation: "5[a]" is shorter than "aaaaa" by 1 character.
```

##### Example 3:

```
Input: s = "aaaaaaaaaa"
Output: "10[a]"
Explanation: "a9[a]" or "9[a]a" are also valid solutions, both of them have the same length = 5, which is the same as "10[a]".
```

##### Constraints:

- `1 <= s.length <= 150`
- `s` consists of only lowercase English letters.

## Solution

```
from functools import cache

# Time: O(n^4)
# Space: O(n^4)
class Solution:
    @cache
    def encode(self, s: str) -> str:
        n = len(s)
        if n < 5:
            return s
        for k in range(n, 1, -1): # greedily find repeats
            # if found one, try to encode within the 
            # repeat to improve final encoded length
            if n % k == 0 and s == s[:n // k] * k: 
                return str(k) + '[' + self.encode(s[:n // k]) + ']'

        # if no repeats in the current substring explore
        # all left and right intervals
        result = s
        for i in range(1, n):
            result = min(result, self.encode(s[:i]) + self.encode(s[i:]), key=len)
        return result
```

## Notes
- This problem tripped me up the first time I did it because I failed to recursively encode top level repeats, i.e. `"aaaaabcaaaaabcaaaaabc" -> "3[5[a]bc]", not "3[aaaaabc]"`. In short, to solve this problem we need to realize it is nonoptimal to attempt to encode strings of length `<= 4`, and find the partition of `s` into substrings such that the optimally encoded substrings result in a final encoded initial string of minimal length. 
- To accomplish this, we recurse and greedily consider repeats that span the entire substring `s` that would result in the best reduction of characters in the final string (1 letter repeats are the best). We then recursively encode the optimal repeat for the current recursive call. If there are no such repeats spanning the entirety of `s`, it is possible that there are repeats that span part of `s`, ie `"aaaaab"`, and so we recursively consider all possible ways to halve `s` such that any partially spanning `s` repeats are taken into account.