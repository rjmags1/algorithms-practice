# 244. Shortest Word Distance II - Medium

Design a data structure that will be initialized with a string array, and then it should answer queries of the shortest distance between two different strings from the array.

Implement the `WordDistance` class:

- `WordDistance(String[] wordsDict)` initializes the object with the strings array `wordsDict`.
- `int shortest(String word1, String word2)` returns the shortest distance between `word1` and `word2` in the array `wordsDict`.


##### Example 1:

```
Input
["WordDistance", "shortest", "shortest"]
[[["practice", "makes", "perfect", "coding", "makes"]], ["coding", "practice"], ["makes", "coding"]]
Output
[null, 3, 1]

Explanation
WordDistance wordDistance = new WordDistance(["practice", "makes", "perfect", "coding", "makes"]);
wordDistance.shortest("coding", "practice"); // return 3
wordDistance.shortest("makes", "coding");    // return 1
```

##### Constraints:


- <code>1 <= wordsDict.length <= 3 * 10<sup>4</sup></code>
- `1 <= wordsDict[i].length <= 10`
- `wordsDict[i]` consists of lowercase English letters.
- `word1` and `word2` are in `wordsDict`.
- `word1 != word2`
- At most `5000` calls will be made to `shortest`.

## Solution

```
# Overall Space: O(n)
class WordDistance:
    # Time: O(n)
    def __init__(self, wordsDict: List[str]):
        self.words = defaultdict(list)
        for i, word in enumerate(wordsDict):
            self.words[word].append(i)

    # Time: O(n) but usually much lower than more naive approach
    def shortest(self, word1: str, word2: str) -> int:
        idxs1, idxs2 = self.words[word1], self.words[word2]
        m, n = len(idxs1), len(idxs2)
        i = j = 0
        result = inf
        while 1:
            idx1, idx2 = idxs1[i], idxs2[j]
            result = min(result, abs(idx1 - idx2))
            di = inf if i == m - 1 else abs(idxs1[i + 1] - idx2)
            dj = inf if j == n - 1 else abs(idxs2[j + 1] - idx1)
            if di == dj == inf:
                break
            if di < dj:
                i += 1
            else:
                j += 1
        return result
```

## Notes
- It would work in this problem to copy and paste the solution to 243 into the `shortest` method, but it is much more efficient to only scan indices of `word1` and `word2` in `wordsDict` as opposed to all indices when we call `shortest`. 
- If we go with the latter, more efficient approach, the problem boils down to implementing "shortest difference between elements of 2 sorted arrays", which can be solved in linear time with a greedy approach.