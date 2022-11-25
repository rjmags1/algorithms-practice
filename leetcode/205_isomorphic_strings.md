# 205. Isomorphic Strings - Easy

Given two strings `s` and `t`, determine if they are isomorphic.

Two strings `s` and `t` are isomorphic if the characters in `s` can be replaced to get `t`.

All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.

##### Example 1:

```
Input: s = "egg", t = "add"
Output: true
```

##### Example 2:

```
Input: s = "foo", t = "bar"
Output: false
```

##### Example 3:

```
Input: s = "paper", t = "title"
Output: true
```

##### Constraints:

- <code>1 <= s.length <= 5 * 10<sup>4</sup></code>
- `t.length == s.length`
- `s` and `t` consist of any valid ascii character.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def isIsomorphic(self, s: str, t: str) -> bool:
        map1, map2 = {}, {}
        for c1, c2 in zip(s, t):
            if c1 not in map1:
                map1[c1] = c2
            if c2 not in map2:
                map2[c2] = c1
            if map1[c1] != c2 or map2[c2] != c1:
                return False
        
        return True
```

## Notes
- This problem is trivial but it is easy to prematurely submit without considering the key part of the prompt: no two characters may map to the same character. This is the reason we need `2` dictionaries - to make sure we account for both directions of a __bijection__, or 1-1 mapping.