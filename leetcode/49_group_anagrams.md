# 49. Group Anagrams - Medium

Given an array of strings `strs`, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

##### Example 1:

```
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
```

##### Example 2:

```
Input: strs = [""]
Output: [[""]]
```

##### Example 3:

```
Input: strs = ["a"]
Output: [["a"]]
```

##### Constraints:

- <code>1 <= strs.length <= 10<sup>4</sup></code>
- `0 <= strs[i].length <= 100`
- `strs[i]` consists of lowercase English letters.

## Solution

```
# Time: O(nk)
# Space: O(n) if we ignore solution memory, O(nk) if we count soln
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        scores = defaultdict(list)
        for word in strs:
            counts = [0] * 26
            aScore = ord('a')
            for c in word:
                counts[ord(c) - aScore] += 1
            scores[tuple(counts)].append(word)
        
        return list(scores.values())
```

## Notes
- Anagrams by definition have the same frequency of each character, with no absent characters. We can hash on character frequencies quite easily with Python tuples.