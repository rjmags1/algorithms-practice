# 211. Design Add and Search Words Data Structure - Medium

Design a data structure that supports adding new words and finding if a string matches any previously added string.

Implement the WordDictionary class:

- `WordDictionary()` Initializes the object.
- `void addWord(word)` Adds `word` to the data structure, it can be matched later.
- `bool search(word)` Returns `true` if there is any string in the data structure that matches `word` or `false` otherwise. `word` may contain dots `'.'` where dots can be matched with any letter.

##### Example 1:

```
Input
["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
[[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
Output
[null,null,null,null,false,true,true,true]

Explanation
WordDictionary wordDictionary = new WordDictionary();
wordDictionary.addWord("bad");
wordDictionary.addWord("dad");
wordDictionary.addWord("mad");
wordDictionary.search("pad"); // return False
wordDictionary.search("bad"); // return True
wordDictionary.search(".ad"); // return True
wordDictionary.search("b.."); // return True
```

##### Constraints:

- `1 <= word.length <= 25`
- `word` in `addWord` consists of lowercase English letters.
- `word` in `search` consist of `'.'` or lowercase English letters.
- There will be at most `3` dots in `word` for search queries.
- At most <code>10<sup>4</sup></code> calls will be made to `addWord` and `search`.

## Solution

```
class WordDictionary:
    def __init__(self):
        self.root = {}
        
    # Time: O(c) where c is number of characters at all levels in trie
    # Space: O(c)
    def addWord(self, word: str) -> None:
        level = self.root
        for c in word:
            if c not in level:
                level[c] = {}
            level = level[c]
        level["*"] = True

    # Time: O(c) where c is number of characters in trie
    # Space: O(c)
    def search(self, word: str) -> bool:
        return self._rec_search(word, 0, self.root)
    
    def _rec_search(self, word, i, level):
        if i == len(word):
            return '*' in level
        
        c = word[i]
        if c != '.':
            return c in level and self._rec_search(word, i + 1, level[c])
        offset = ord('a')
        for k in range(26):
            c = chr(offset + k)
            if c in level and self._rec_search(word, i + 1, level[c]):
                return True
        return False
```

## Notes
- Leetcode judge could be a little more lenient because conceptually correct solutions such as above do not pass sometimes because of large inputs and inability to memoize.