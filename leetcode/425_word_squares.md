# 425. Word Squares - Hard

Given an array of unique strings `words`, return all the word squares you can build from `words`. The same word from `words` can be used multiple times. You can return the answer in any order.

A sequence of strings forms a valid word square if the `kth` row and column read the same string, where `0 <= k < max(numRows, numColumns)`.

- For example, the word sequence `["ball","area","lead","lady"]` forms a word square because each word reads the same both horizontally and vertically.


##### Example 1:

```
Input: words = ["area","lead","wall","lady","ball"]
Output: [["ball","area","lead","lady"],["wall","area","lead","lady"]]
Explanation:
The output consists of two word squares. The order of output does not matter (just the order of words in each word square matters).
```

##### Example 2:

```
Input: words = ["abat","baba","atan","atal"]
Output: [["baba","abat","baba","atal"],["baba","abat","baba","atan"]]
Explanation:
The output consists of two word squares. The order of output does not matter (just the order of words in each word square matters).
```

##### Constraints:

- `1 <= words.length <= 1000`
- `1 <= words[i].length <= 4`
- All `words[i]` have the same length.
- `words[i]` consists of only lowercase English letters.
- All `words[i]` are unique.

## Solution

```
from collections import defaultdict

# Time: O(n * n^m) where n is len(words) and m is len(words[0])
# Space: O(nm)
class Solution:
    def wordSquares(self, words: List[str]) -> List[List[str]]:
        pre, n = defaultdict(list), len(words[0])
        for word in words:
            for i in range(n):
                pre[word[:i + 1]].append(word)

        result, builder = [], []
        def rec(k):
            if k == n:
                result.append(builder[:])
                return
            
            sympre = "".join(w[k] for w in builder)
            for w in pre[sympre]:
                builder.append(w)
                rec(k + 1)
                builder.pop()
        
        for word in words:
            builder.append(word)
            rec(1)
            builder.pop()
        return result
```

## Notes
- We use backtracking in this problem to enumerate all possible word squares. For each backtracking step we ask, 'are there words whose prefix is equivalent to the word formed by the column of current word square words at index `k`?' We save time by precomputing all prefixes. 
- The time complexity comes from the fact that as we backtrack we recurse forward with at most `n` words as having a correct prefix, and the recursive call tree from backtracking is `m` in depth at most. Each recursive call does an iteration of time on the order of `n`.
- The space complexity is dominated by the size of the precomputed prefix hash table; for each word there are on the order `m` prefixes, and there are `n` words.