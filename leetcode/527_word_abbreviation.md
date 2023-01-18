# 527. Word Abbreviation - Hard

Given an array of distinct strings `words`, return the minimal possible abbreviations for every word.

The following are the rules for a string abbreviation:

The initial abbreviation for each word is: the first character, then the number of characters in between, followed by the last character.
If more than one word shares the same abbreviation, then perform the following operation:
- Increase the prefix (characters in the first part) of each of their abbreviations by `1`.
    - For example, say you start with the words `["abcdef","abndef"]` both initially abbreviated as `"a4f"`. Then, a sequence of operations would be `["a4f","a4f"] -> ["ab3f","ab3f"] -> ["abc2f","abn2f"]`.
- This operation is repeated until every abbreviation is unique.

At the end, if an abbreviation did not make a word shorter, then keep it as the original word.


##### Example 1:

```
Input: words = ["like","god","internal","me","internet","interval","intension","face","intrusion"]
Output: ["l2e","god","internal","me","i6t","interval","inte4n","f2e","intr4n"]
```

##### Example 2:

```
Input: words = ["aa","aaa"]
Output: ["aa","aaa"]
```

##### Constraints:

- `1 <= words.length <= 400`
- `2 <= words[i].length <= 400`
- `words[i]` consists of lowercase English letters.
- All the strings of `words` are unique.

## Solution

```
from collections import defaultdict

# Time: O(n * m^2) where n is len(words) and m is avg word length
# Space: O(nm)
class Solution:
    def wordsAbbreviation(self, words: List[str]) -> List[str]:
        n = len(words)
        abbr = lambda w, prelen: w[:prelen] + str(len(w) - prelen - 1) + w[-1]
        result, abbrs = [""] * n, defaultdict(list)
        for i, w in enumerate(words):
            if len(w) < 4:
                result[i] = w
            else:
                abbrs[abbr(w, 1)].append(i)

        for abbrev, idxs in abbrs.items():
            k, unique, m = len(idxs), 0, len(words[idxs[0]])
            for prelen in range(1, m - 2):
                pres = defaultdict(list)
                for i in idxs:
                    if not result[i]:
                        pres[words[i][:prelen]].append(i)
                for pre, l in pres.items():
                    if len(l) == 1:
                        result[l[0]] = abbr(words[l[0]], prelen)
                        unique += 1
                if unique == k:
                    break
            if unique < k:
                for i in idxs:
                    if not result[i]:
                        result[i] = words[i]
        
        return result
```

## Notes
- Greedy. Group all strings by their initial abbreviation, then consider each group at a time, finding the smallest prefix for each word in group that makes it distinct from all the other words in the group. Despite the bad time complexity (~`O(10^7)` in worst case) the greedy nature of the algorithm makes the actual runtime fairly quick (~90th percentile for LC test cases). Still, trie solution described below is what you would want for an interview.
- We could get the time complexity down to `O(mn)` if we used tries of words with the same initial abbreviation. Tries would need to store the indices of words that share the node's character, for each node in the trie. This would allow for determination of whether the node character distinguishes a word from all the other words in the group, and so we would consider each group-trie in a level order fashion.