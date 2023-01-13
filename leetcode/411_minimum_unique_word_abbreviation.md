# 411. Minimum Unique Word Abbreviation - Hard

A string can be abbreviated by replacing any number of non-adjacent substrings with their lengths. For example, a string such as `"substitution"` could be abbreviated as (but not limited to):

    "s10n" ("s ubstitutio n")
    "sub4u4" ("sub stit u tion")
    "12" ("substitution")
    "su3i1u2on" ("su bst i t u ti on")
    "substitution" (no substrings replaced)

Note that `"s55n"` (`"s ubsti tutio n"`) is not a valid abbreviation of `"substitution"` because the replaced substrings are adjacent.

The length of an abbreviation is the number of letters that were not replaced plus the number of substrings that were replaced. For example, the abbreviation `"s10n"` has a length of `3` (`2` letters + `1` substring) and `"su3i1u2on"` has a length of `9` (`6` letters + `3` substrings).

Given a target string `target` and an array of strings `dictionary`, return an abbreviation of `target` with the shortest possible length such that it is not an abbreviation of any string in `dictionary`. If there are multiple shortest abbreviations, return any of them.

##### Example 1:

```
Input: target = "apple", dictionary = ["blade"]
Output: "a4"
Explanation: The shortest abbreviation of "apple" is "5", but this is also an abbreviation of "blade".
The next shortest abbreviations are "a4" and "4e". "4e" is an abbreviation of blade while "a4" is not.
Hence, return "a4".
```

##### Example 2:

```
Input: target = "apple", dictionary = ["blade","plain","amber"]
Output: "1p3"
Explanation: "5" is an abbreviation of both "apple" but also every word in the dictionary.
"a4" is an abbreviation of "apple" but also "amber".
"4e" is an abbreviation of "apple" but also "blade".
"1p3", "2p2", and "3l1" are the next shortest abbreviations of "apple".
Since none of them are abbreviations of words in the dictionary, returning any of them is correct.
```

##### Constraints:

- `m == target.length`
- `n == dictionary.length`
- `1 <= m <= 21`
- `0 <= n <= 1000`
- `1 <= dictionary[i].length <= 100`
- `log2(n) + m <= 21 if n > 0`
- `target` and `dictionary[i]` consist of lowercase English letters.
- `dictionary` does not contain target.

## Solution

```
# Time: O(n * 2^m)
# Space: O(n)
class Solution:
    def minAbbreviation(self, target: str, dictionary: List[str]) -> str:
        n = len(target)
        def makemask(w):
            shift = 1 << (n - 1)
            mask = 0
            for i in range(n):
                if target[i] != w[i]:
                    mask |= shift
                shift >>= 1
            return mask
        
        def abblen(mask):
            shift = 1 << (n - 1)
            result = 0
            while shift:
                result += 1
                if shift & mask:
                    shift >>= 1
                else:
                    while shift and not shift & mask:
                        shift >>= 1
            return result

        def frommask(mask):
            shift, i = 1 << (n - 1), 0
            result = []
            while shift:
                if shift & mask:
                    result.append(target[i])
                    shift >>= 1
                    i += 1
                else:
                    k = i
                    while shift and not shift & mask:
                        i += 1
                        shift >>= 1
                    result.append(str(i - k))
            return "".join(result)
            
        masks = [makemask(w) for w in dictionary if len(w) == n]
        diffbits = 0
        for m in masks:
            diffbits |= m
        
        minlen, minlenmask = math.inf, 0
        def dfs(mask, bit):
            nonlocal minlen, minlenmask
            l = abblen(mask)
            if l >= minlen:
                return

            distinguishesall = True
            for m in masks:
                if not m & mask:
                    distinguishesall = False
                    break
            if distinguishesall and l < minlen:
                minlen, minlenmask = l, mask

            nxtbit = 1 if not bit else bit << 1
            while nxtbit <= diffbits:
                if nxtbit & diffbits:
                    dfs(mask | nxtbit, nxtbit)
                nxtbit <<= 1

        dfs(0, 0)
        return frommask(minlenmask)
```

## Notes
- We need to realize that our final answer must contain the minimum number of non-abbreviated characters such that the abbreviation is distinct from the any abbreviation of all the words of the same length as `target` in `dictionary`. To obtain such a result, we can enumerate all of the characters in `target` that distinguish it from at least one word in `dictionary`, and then perform dfs on all possible ways to abbreviate with or without each distinguishing letter (resulting in a binary dfs call tree) to find the minimum length abbreviation that distinguishes `target` from all words in `dictionary`. The problem becomes much simpler if we represent the words in `dictionary` as bitmasks, with set bits indicating a diff and zero bits indicating the same letter as `target` at that position.