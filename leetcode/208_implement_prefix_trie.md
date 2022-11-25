# 208. Implement Trie (Prefix Trie) - Medium

A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.

Implement the `Trie` class:

- `Trie()` Initializes the trie object.
- `void insert(String word)` Inserts the string `word` into the trie.
- `boolean search(String word)` Returns `true` if the string word is in the trie (i.e., was inserted before), and `false` otherwise.
- `boolean startsWith(String prefix)` Returns `true` if there is a previously inserted string `word` that has the prefix `prefix`, and `false` otherwise.


##### Example 1:

```
Input
["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
[[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
Output
[null, null, true, false, true, null, true]

Explanation
Trie trie = new Trie();
trie.insert("apple");
trie.search("apple");   // return True
trie.search("app");     // return False
trie.startsWith("app"); // return True
trie.insert("app");
trie.search("app");     // return True
```

##### Constraints:

- 1 <= word.length, prefix.length <= 2000
- word and prefix consist only of lowercase English letters.
- At most 3 * 104 calls in total will be made to insert, search, and startsWith.

## Solution

```
WORDEND = "*"
class Trie:
    def __init__(self):
        self.root = {}

    def insert(self, word: str) -> None:
        level = self.root
        for c in word:
            if c not in level:
                level[c] = {}
            level = level[c]
        level[WORDEND] = True

    def search(self, word: str) -> bool:
        level = self.root
        for c in word:
            if c not in level:
                return False
            level = level[c]
        return WORDEND in level

    def startsWith(self, prefix: str) -> bool:
        level = self.root
        for c in prefix:
            if c not in level:
                return False
            level = level[c]
        return True
```

## Notes
- Fairly straightforward, allows us to save a lot of space compared to hash table, and in cases where there a lot of words in the trie, we potentially save on runtime as well due to hash collision resolution, which can cause hash table lookup to degenerate to `O(keys)` from `O(1)`.
- Tries are also well suited for problems where we are interested in common prefixes between words stored in the data structure, as well as efficiently obtaining a lexicographically sorted order of words in the data structure on the fly.
- It would probably be more efficient to use nested arrays of length `26 + 1` (`1` for word end signaller) for the above implementation as opposed to nested dictionaries for more efficient lookup, but underlying functionality is the same.