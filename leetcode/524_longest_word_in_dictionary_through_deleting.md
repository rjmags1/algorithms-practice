# 524. Longest Word in Dictionary through Deleting - Medium

Given a string `s` and a string array `dictionary`, return the longest string in the dictionary that can be formed by deleting some of the given string characters. If there is more than one possible result, return the longest word with the smallest lexicographical order. If there is no possible result, return the empty string.

##### Example 1:

```
Input: s = "abpcplea", dictionary = ["ale","apple","monkey","plea"]
Output: "apple"
```

##### Example 2:

```
Input: s = "abpcplea", dictionary = ["a","b","c"]
Output: "a"
```

##### Constraints:

- `1 <= s.length <= 1000`
- `1 <= dictionary.length <= 1000`
- `1 <= dictionary[i].length <= 1000`
- `s` and `dictionary[i]` consist of lowercase English letters.

## Solution

```
# Time: O(mn)
# Space: O(1)
class Solution:
    def issubseq(self, seq, w):
        i, n = 0, len(seq)
        for c in w:
            if c == seq[i]:
                i += 1
                if i == n:
                    return True
        return False
        
    def findLongestWord(self, s: str, dictionary: List[str]) -> str:
        result, n = "", len(s)
        for w in dictionary:
            if len(w) > n:
                continue
            if self.issubseq(w, s):
                if len(w) >= len(result):
                    result = w if len(w) > len(result) or w < result else result
        return result
```

## Notes
- Get the longest word in `dictionary` that is a subsequence of `s`, and be sure to handle ties with lexicographical order.