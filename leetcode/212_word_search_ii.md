# 212. Word Search II - Hard

Given an `m x n` board of characters and a list of strings `words`, return all words on the board.

Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

##### Example 1:

```
Input: board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], words = ["oath","pea","eat","rain"]
Output: ["eat","oath"]
```

##### Example 2:

```
Input: board = [["a","b"],["c","d"]], words = ["abcb"]
Output: []
```

##### Constraints:

- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 12`
- `board[i][j]` is a lowercase English letter.
- <code>1 <= words.length <= 3 * 10<sup>4</sup></code>
- <code>1 <= words[i].length <= 10</code>
- `words[i]` consists of lowercase English letters.
- All the strings of `words` are unique.

## Solution

```
class Trie:
    def __init__(self, words):
        self.root = {}
        for word in words:
            self.insert(word)
        
    def insert(self, word):
        curr = self.root
        for c in word:
            if c not in curr:
                curr[c] = {}
            curr = curr[c]
        curr['*'] = True
    
    def remove(self, word, i=0, level=None):
        if level is None:
            level = self.root
        if i == len(word):
            level.pop('*')
            return len(level) == 0
        
        cansplice = self.remove(word, i + 1, level[word[i]])
        if cansplice:
            level.pop(word[i])
        return cansplice and len(level) == 0
    
# Time: O(mn * 4^k) where m and n are board dimensions, k is max word length, 
#           and c is number of characters in the trie
# Space: O(c)
class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        m, n = len(board), len(board[0])
        trie = Trie(words)
        seen = set()
        result, builder = [], []
        added = set()
        diff = ((1, 0), (-1, 0), (0, 1), (0, -1))
        def dfs(i, j, builder, trieroot):
            currletter = board[i][j]
            builder.append(currletter)
            seen.add((i, j))
            nextlevel = trieroot[currletter]
            if '*' in nextlevel:
                word = "".join(builder)
                if word not in added:
                    added.add(word)
                    result.append("".join(builder))
            for di, dj in diff:
                i2, j2 = i + di, j + dj
                if not 0 <= i2 < m or not 0 <= j2 < n:
                    continue
                if (i2, j2) in seen:
                    continue
                if board[i2][j2] not in nextlevel:
                    continue
                dfs(i2, j2, builder, nextlevel)
            seen.remove((i, j))
            builder.pop()
        
        for i in range(m):
            for j in range(n):
                if board[i][j] in trie.root:
                    prev = len(result)
                    dfs(i, j, builder, trie.root)
                    post = len(result)
                    for newWordIdx in range(prev, post):
                        trie.remove(result[newWordIdx])
        return result
```

## Notes
- Lots going on in this problem. The essence of the problem is to use a trie to store words in `words` so that we can efficiently track consecutive letters in `words` as we `dfs` through the board for matches. So the problem involves combining several different cp paradigms, but there are also some edge cases to look out for: what if some words in `words` are prefixes of other words? What if there are multiple instances of a word in `words` present in the board?
- If we just backtrack on the board with a trie with no consideration for the latter edge case, we will likely be much less efficient than we could be because we may explore trie paths redundantly. The way to handle this is to remove trie nodes when there are no longer part of a trie path that could lead to a yet undiscovered word in `board`.
- The way I have implemented this optimization could be a little cleaner, because I added the remove trie node functionality as a method of the `Trie` class, when it would be easier to just have that functionality as part of the `dfs` function - before returning, one could check if there are no children in the current `trieroot`, and if there are none, we pop the current `trieroot` from the parent's children. The way I implemented this optimization causes us to need an extra set, `added`, to ensure we don't double add words to `result` in cases where there are multiple ways to form a single word by branching off a nonzero length path in board.