# 68. Text Justification - Hard

Given an array of strings `words` and a width `maxWidth`, format the text such that each line has exactly `maxWidth` characters and is fully (left and right) justified.

You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces `' '` when necessary so that each line has exactly `maxWidth` characters.

Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

For the last line of text, it should be left-justified, and no extra space is inserted between words.

Note:

- A word is defined as a character sequence consisting of non-space characters only.
- Each word's length is guaranteed to be greater than `0` and not exceed `maxWidth`.
- The input array `words` contains at least one word.


##### Example 1:

```
Input: words = ["This", "is", "an", "example", "of", "text", "justification."], maxWidth = 16
Output:
[
   "This    is    an",
   "example  of text",
   "justification.  "
]
```

##### Example 2:

```
Input: words = ["What","must","be","acknowledgment","shall","be"], maxWidth = 16
Output:
[
  "What   must   be",
  "acknowledgment  ",
  "shall be        "
]
Explanation: Note that the last line is "shall be    " instead of "shall     be", because the last line must be left-justified instead of fully-justified.
Note that the second line is also left-justified because it contains only one word.
```

##### Example 3:

```
Input: words = ["Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"], maxWidth = 20
Output:
[
  "Science  is  what we",
  "understand      well",
  "enough to explain to",
  "a  computer.  Art is",
  "everything  else  we",
  "do                  "
]
```

##### Constraints:


- `1 <= words.length <= 300`
- `1 <= words[i].length <= 20`
- `words[i]` consists of only English letters and symbols.
- `1 <= maxWidth <= 100`
- `words[i].length <= maxWidth`


## Solution

```
# Time: O(nm)
# Space: O(nm)
class Solution:
    def fullJustify(self, words: List[str], maxWidth: int) -> List[str]:
        result, line = [], []
        spaces = letters = wordsInLine = 0
        for word in words:
            if letters > 0:
                spaces += 1
            letters += len(word)
            wordsInLine += 1
            if letters + spaces <= maxWidth:
                line.append(word)
                continue
            
            letters -= len(word)
            wordsInLine -= 1
            jSpaces = maxWidth - letters
            spaceSize = jSpaces // (wordsInLine - 1) if wordsInLine > 1 else jSpaces
            largeSpaces = jSpaces % (wordsInLine - 1) if wordsInLine > 1 else 0
            justified = []
            regSpace = " " * spaceSize
            largeSpace = regSpace + " "
            for w in line:
                justified.append(w)
                if largeSpaces > 0:
                    justified.append(largeSpace)
                    largeSpaces -= 1
                else:
                    justified.append(regSpace)
            if wordsInLine > 1:
                justified.pop()
            result.append("".join(justified))
            
            letters, spaces, wordsInLine = len(word), 0, 1
            line = [word]
        
        lastLine = " ".join(line)
        lastLine += " " * (maxWidth - len(lastLine))
        result.append(lastLine)
        return result
```

## Notes
- This problem isn't that bad, guessing the only reason it is hard is because of the various edge cases that need to be addressed: can fit a sequence of words in a `line` of length `maxWidth` with single spaces, spaces larger than single of uniform size, spaces larger than single space with some `1` space character bigger than others. Also need to be careful about adding a space to the end of a `line` - the only time when there should be any space characters at the end of a `line` is when the `line` contains `1` `word` and that `word` is less than `maxWidth` chars.