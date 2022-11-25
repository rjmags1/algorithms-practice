# 245. Shortest Word Distance III - Medium

Given an array of strings `wordsDict` and two strings that already exist in the array `word1` and `word2`, return the shortest distance between these two words in the list.

Note that `word1` and `word2` may be the same. It is guaranteed that they represent two individual words in the list.

##### Example 1:

```
Input: wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "makes", word2 = "coding"
Output: 1
```

##### Example 2:

```
Input: wordsDict = ["practice", "makes", "perfect", "coding", "makes"], word1 = "makes", word2 = "makes"
Output: 3
```

##### Constraints:

- <code>1 <= wordsDict.length <= 10<sup>5</sup></code>
- `1 <= wordsDict[i].length <= 10`
- `wordsDict[i]` consists of lowercase English letters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def shortestWordDistance(self, wordsDict: List[str], word1: str, word2: str) -> int:
        result = inf
        lastseen1 = lastseen2 = -inf
        for i, word in enumerate(wordsDict):
            if word1 == word2:
                if word == word1:
                    result = min(result, i - lastseen1)
                    lastseen1 = i
                continue
            if word == word1:
                lastseen1 = i
                result = min(result, i - lastseen2)
            if word == word2:
                lastseen2 = i
                result = min(result, i - lastseen1)
        return result
```

## Notes
- Same as original shortest word distance problem (243) just need to handle case where `word1 == word2`.