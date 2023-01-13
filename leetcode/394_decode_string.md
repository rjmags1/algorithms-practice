# 394. Decode String - Medium

Given an encoded string, return its decoded string.

The encoding rule is: `k[encoded_string]`, where the `encoded_string` inside the square brackets is being repeated exactly `k` times. Note that `k` is guaranteed to be a positive integer.

You may assume that the input string is always valid; there are no extra white spaces, square brackets are well-formed, etc. Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, `k`. For example, there will not be input like `3a` or `2[4]`.

The test cases are generated so that the length of the output will never exceed <code>10<sup>5</sup></code>.

##### Example 1:

```
Input: s = "3[a]2[bc]"
Output: "aaabcbc"
```

##### Example 2:

```
Input: s = "3[a2[c]]"
Output: "accaccacc"
```

##### Example 3:

```
Input: s = "2[abc]3[cd]ef"
Output: "abcabccdcdcdef"
```

##### Constraints:

- `1 <= s.length <= 30`
- `s` consists of lowercase English letters, digits, and square brackets `'[]'`.
- `s` is guaranteed to be a valid input.
- All the integers in `s` are in the range `[1, 300]`.

## Solution

```
# Time: O(m^d * n)
# Space: O(sum(m^d * n))
class Solution:
    def decodeString(self, s: str) -> str:
        n = len(s)
        def rec(i):
            k, result = i, []
            while k < n:
                if s[k] == "]":
                    k += 1
                    break
                if s[k].isdigit():
                    curr = 0
                    while k < n and s[k].isdigit():
                        curr = curr * 10 + int(s[k])
                        k += 1
                    ss, k = rec(k + 1)
                    for _ in range(curr):
                        result.append(ss)
                else:
                    result.append(s[k])
                    k += 1

            return "".join(result), k

        return rec(0)[0]
```

## Notes
- The time and space complexity come from the fact we could have `d` levels of nesting with at most `m` repeats of encoded substrings at each level, where each substring is of max length `n`. Official complexity on leetcode appears incorrect (`O(mn)`); if it was really this low the input constraints would have larger upper bound.
- DFS and string parsing. Each encoded string may contain multiple levels of nesting, so in order to efficiently decode `s` we need to handle the deepest encoded substrings first and duplicate them the specified number of times into the containing substring. 