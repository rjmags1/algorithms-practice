# 243. Shortest Word Distance - Easy

Given an array of strings `wordsDict` and two different strings that already exist in the array `word1` and `word2`, return the shortest distance between these two words in the list.

##### Example 1:

```
Input: wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "coding", word2 = "practice"
Output: 3
```

##### Example 2:

```
Input: wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "makes", word2 = "coding"
Output: 1
```

##### Constraints:

- <code>2 <= wordsDict.length <= 3 * 10<sup>4</sup></code>
- `1 <= wordsDict[i].length <= 10`
- `wordsDict[i]` consists of lowercase English letters.
- `word1` and `word2` are in wordsDict.
- `word1 != word2`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def shortestDistance(self, wordsDict: List[str], word1: str, word2: str) -> int:
        lastseen1 = lastseen2 = -inf
        result = inf
        for i, word in enumerate(wordsDict):
            if word == word1:
                lastseen1 = i
                result = min(result, i - lastseen2)
            elif word == word2:
                lastseen2 = i
                result = min(result, i - lastseen1)
                
        return result
```

## Notes
- Just track most recently seen index of the relevant words to check each relevant word distance!