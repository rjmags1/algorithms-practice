# 500. Keyboard Row - Easy

Given an array of strings `words`, return the `words` that can be typed using letters of the alphabet on only one row of American keyboard like the image below.

In the American keyboard:

- the first row consists of the characters `"qwertyuiop"`,
- the second row consists of the characters `"asdfghjkl"`, and
- the third row consists of the characters `"zxcvbnm"`.


##### Example 1:

```
Input: words = ["Hello","Alaska","Dad","Peace"]
Output: ["Alaska","Dad"]
```

##### Example 2:

```
Input: words = ["omk"]
Output: []
```

##### Example 3:

```
Input: words = ["adsdf","sfd"]
Output: ["adsdf","sfd"]
```

##### Constraints:

- `1 <= words.length <= 20`
- `1 <= words[i].length <= 100`
- `words[i]` consists of English letters (both lowercase and uppercase). 

## Solution

```
# Time: O(mn) where m = max(len(words[i])) and n = len(words)
# Space: O(1)
class Solution:
    def findWords(self, words: List[str]) -> List[str]:
        row1, row2, row3 = "qwertyuiop", "asdfghjkl", "zxcvbnm"
        rows = (set(row1 + row1.upper()), set(row2 + row2.upper()), set(row3 + row3.upper()))
        result = []
        for w in words:
            ws = set(w)
            if any(len(ws | r) == len(r) for r in rows):
                result.append(w)
        return result
```

## Notes
- We touch each letter of each string in `words` a constant number of times, and we have a constant number of possible characters to encounter.