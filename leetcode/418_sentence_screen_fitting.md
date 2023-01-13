# 418. Sentence Screen Fitting - Medium

Given a `rows x cols` screen and a `sentence` represented as a list of strings, return the number of times the given sentence can be fitted on the screen.

The order of words in the sentence must remain unchanged, and a word cannot be split into two lines. A single space must separate two consecutive words in a line.

##### Example 1:

```
Input: sentence = ["hello","world"], rows = 2, cols = 8
Output: 1
Explanation:
hello---
world---
The character '-' signifies an empty space on the screen.
```

##### Example 2:

```
Input: sentence = ["a", "bcd", "e"], rows = 3, cols = 6
Output: 2
Explanation:
a-bcd- 
e-a---
bcd-e-
The character '-' signifies an empty space on the screen.
```

##### Example 3:

```
Input: sentence = ["i","had","apple","pie"], rows = 4, cols = 5
Output: 1
Explanation:
i-had
apple
pie-i
had--
The character '-' signifies an empty space on the screen.
```

##### Constraints:

- `1 <= sentence.length <= 100`
- `1 <= sentence[i].length <= 10`
- <code>1 <= rows, cols <= 2 * 10<sup>4</sup></code>
- `sentence[i]` consists of lowercase English letters.

## Solution

```
# Time: O(nc + r)
# Space: O(n)
class Solution:
    def wordsTyping(self, sentence: List[str], rows: int, cols: int) -> int:
        sl, n = list(map(len, sentence)), len(sentence)
        if max(sl) > cols:
            return 0

        def fitfromhere(i):
            chars = ends = done = 0
            while not done:
                if chars == 0:
                    chars += sl[i]
                    i += 1
                elif chars + 1 + sl[i] <= cols:
                    chars += 1 + sl[i]
                    i += 1
                else:
                    done = 1
                if i == n:
                    i = 0
                    ends += 1
                
            return ends, i
        
        dp = [fitfromhere(i) for i in range(n)]
        result = i = 0
        for row in range(rows):
            ends, i = dp[i]
            result += ends
        return result
```

## Notes
- If we naively simulate fitting as many sentences as possible into the `rows`, we will end up duplicating a lot of calculations; the number of sentences we can fit in a row starting with a particular word in `sentence` will never change. So we can precompute the number of sentences and the starting point for the next row, for each word as the first in a row in `sentence`. This enables us to determine the number of sentences per row and the starting point for the next row, for each row, in constant time.