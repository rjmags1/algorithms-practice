# 555. Split Concatenated Strings - Medium

You are given an array of strings `strs`. You could concatenate these strings together into a loop, where for each string, you could choose to reverse it or not. Among all the possible loops

Return the lexicographically largest string after cutting the loop, which will make the looped string into a regular one.

Specifically, to find the lexicographically largest string, you need to experience two phases:

- Concatenate all the strings into a loop, where you can reverse some strings or not and connect them in the same order as given.
- Cut and make one breakpoint in any place of the loop, which will make the looped string into a regular one starting from the character at the cutpoint.

And your job is to find the lexicographically largest one among all the possible regular strings.

##### Example 1:

```
Input: strs = ["abc","xyz"]
Output: "zyxcba"
Explanation: You can get the looped string "-abcxyz-", "-abczyx-", "-cbaxyz-", "-cbazyx-", where '-' represents the looped status. 
The answer string came from the fourth looped one, where you could cut from the middle character 'a' and get "zyxcba".
```

##### Example 2:

```
Input: strs = ["abc"]
Output: "cba"
```

##### Constraints:

- `1 <= strs.length <= 1000`
- `1 <= strs[i].length <= 1000`
- `1 <= sum(strs[i].length) <= 1000`
- `strs[i]` consists of lowercase English letters.

## Solution

```
# Time: O(c^2)
# Space: O(c)
class Solution:
    def splitLoopedString(self, strs: List[str]) -> str:
        result, n = "", len(strs)
        for i, s in enumerate(strs):
            rest = "".join(max(strs[k % n], strs[k % n][::-1]) for k in range(i + 1, i + n))
            for j in range(1, len(s) + 1):
                rev = s[::-1]
                end, start = s[:j], s[j:]
                revend, revstart = rev[:j], rev[j:]
                curr = start + rest + end if start > revstart else revstart + rest + revend
                result = max(result, curr) if result else curr
        return result
```

## Notes
- Just check all the split points, where each split point can be at a particular index in `[0, c - 1]` if `c` is the total number of characters, and split the forward or reversed string containing the particular character index. To only check each split point once, we optimally reverse or leave the other strings besides the one containing the current split point, since it is pointless to consider any other strings for a particular split point based on the kind of answer we are looking for.