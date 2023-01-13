# 472. Concatenated Words - Hard

Given an array of strings `words` (without duplicates), return all the concatenated words in the given list of `words`.

A concatenated word is defined as a string that is comprised entirely of at least two shorter words in the given array.

##### Example 1:

```
Input: words = ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]
Output: ["catsdogcats","dogcatsdog","ratcatdogcat"]
Explanation: "catsdogcats" can be concatenated by "cats", "dog" and "cats"; 
"dogcatsdog" can be concatenated by "dog", "cats" and "dog"; 
"ratcatdogcat" can be concatenated by "rat", "cat", "dog" and "cat".
```

##### Example 2:

```
Input: words = ["cat","dog","catdog"]
Output: ["catdog"]
```

##### Constraints:

- <code>1 <= words.length <= 10<sup>4</sup></code>
- <code>1 <= sum(words[i].length) <= 10<sup>5</sup></code>
- `1 <= words[i].length <= 30`
- `words[i]` consists of only lowercase English letters.
- All the strings of `words` are unique.

## Solution

```
from functools import cache

# Time: O(n * m^3)
# Space: O(n * m^2)
class Solution:
    def findAllConcatenatedWordsInADict(self, words: List[str]) -> List[str]:
        ws = set(words)

        @cache
        def rec(w):
            if not w:
                return True
            
            for i in range(1, len(w) + 1):
                if w[:i] in ws and rec(w[i:]):
                    return True
            return False
            
        result = []
        for w in ws:
            isconcat = False
            for i in range(1, len(w)):
                if w[:i] in ws and rec(w[i:]):
                    isconcat = True
                    break
            if isconcat:
                result.append(w)

        return result
```

## Notes
- Fairly basic topdown dp, however it is easy to overlook double counting words that can be formed with multiple concatenations of smaller words in `words`. Instead of using a set of concatenation words, since all we care about is whether or not such a concatenation of words in `words` exists for a particular word, just break when we find the first concatenation for a given word.