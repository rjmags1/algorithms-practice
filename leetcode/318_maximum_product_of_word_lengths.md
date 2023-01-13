# 318. Maximum Product of Word Lengths - Medium

Given a string array `words`, return the maximum value of `length(word[i]) * length(word[j])` where the two words do not share common letters. If no such two words exist, return `0`.

##### Example 1:

```
Input: words = ["abcw","baz","foo","bar","xtfn","abcdef"]
Output: 16
Explanation: The two words can be "abcw", "xtfn".
```

##### Example 2:

```
Input: words = ["a","ab","abc","d","cd","bcd","abcd"]
Output: 4
Explanation: The two words can be "ab", "cd".
```

##### Example 3:

```
Input: words = ["a","aa","aaa","aaaa"]
Output: 0
Explanation: No such pair of words.
```

##### Constraints:

- `2 <= words.length <= 1000`
- `1 <= words[i].length <= 1000`
- `words[i]` consists only of lowercase English letters.

## Solution

```
# Time: O(mn)
# Space: O(n)
class Solution:
    def maxProduct(self, words: List[str]) -> int:
        offset = ord('a')
        freqs = defaultdict(int)
        for w in words:
            freq = 0
            for c in w:
                freq |= (1 << (ord(c) - offset))
            freqs[freq] = max(freqs[freq], len(w))
        
        result = 0
        for freq1, len1 in freqs.items():
            for freq2, len2 in freqs.items():
                if freq1 & freq2 == 0:
                    result = max(result, len1 * len2)
        return result
```

## Notes
- Use bitmask to store the presence of a character in a string. We can hash on the character presence bitmasks with minimal memory to distinguish between words that have distinct letters and those that share letters. Also note how we only care about the longest word with a particular character presence bitmask.