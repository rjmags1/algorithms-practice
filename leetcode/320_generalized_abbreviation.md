# 320. Generalized Abbreviation - Medium

A word's generalized abbreviation can be constructed by taking any number of non-overlapping and non-adjacent substrings and replacing them with their respective lengths.

- For example, `"abcde"` can be abbreviated into:
    - `"a3e"` (`"bcd"` turned into `"3"`)
    - `"1bcd1"` (`"a"` and `"e"` both turned into `"1"`)
    - `"5"` (`"abcde"` turned into `"5"`)
    - `"abcde"` (no substrings replaced)
- However, these abbreviations are invalid:
    - `"23"` (`"ab"` turned into `"2"` and `"cde"` turned into `"3"`) is invalid as the substrings chosen are adjacent.
    - `"22de"` (`"ab"` turned into `"2"` and `"bc"` turned into `"2"`) is invalid as the substring chosen overlap.

Given a string `word`, return a list of all the possible generalized abbreviations of `word`. Return the answer in any order.

##### Example 1:

```
Input: word = "word"
Output: ["4","3d","2r1","2rd","1o2","1o1d","1or1","1ord","w3","w2d","w1r1","w1rd","wo2","wo1d","wor1","word"]
```

##### Example 2:

```
Input: word = "a"
Output: ["1","a"]
```

##### Constraints:

- `1 <= word.length <= 15`
- `word` consists of only lowercase English letters.

## Solution 1

```
# Time: O(?)
# Space: O(n * 2^n)
class Solution:
    def generateAbbreviations(self, word: str) -> List[str]:
        @cache
        def rec(w):
            if not w:
                return []
            n = len(w)
            if n == 1:
                return ["1", w]
            
            result = [str(n), w]
            for i, c in enumerate(w):
                left = rec(w[:i])
                right = rec(w[i + 1:])
                if i == 0:
                    for abb in right:
                        result.append(c + abb)
                elif i == n - 1:
                    for abb in left:
                        result.append(abb + c)
                else:
                    for abbl in left:
                        for abbr in right:
                            result.append(abbl + c + abbr)
            return list(set(result))
        
        return rec(word)
```

## Notes
- Divide and conquer approach with caching. For each letter in a given word, we can choose to not abbreviate it, and then recursively determine all the possible abbreviations for the substrings to the left of the current character and to the right of the current character. We then combine all of the left and right abbreviations.
- In terms of time complexity, there are <code>O(n<sup>2</sup>)</code> possible substrings that will get their own recursive call. Each of these substrings has <code>O(n<sup>2</sup>)</code> possible `left` and `right` substrings, and for each `left` and `right` substring we build a new string to add to the result. For space, there are <code>O(2<sup>n</sup>)</code> possibly ways to abbreviate; i.e., for each character we can choose to add it to the current abbreviation chain or not abbreviate it. 

## Solution 2

```
# Time: O(n * 2^n)
# Space: O(n * 2^n)
class Solution:
    def generateAbbreviations(self, word: str) -> List[str]:
        masks = []
        def rec(mask, n):
            if n == 0:
                masks.append(mask)
                return
            
            mask <<= 1
            rec(mask | 0, n - 1)
            rec(mask | 1, n - 1)
        
        n, result = len(word), []
        rec(0, n)
        for i in range(len(masks)):
            mask, curr, count = masks[i], [], 0
            for j in reversed(range(n)):
                if mask & 1:
                    count += 1
                else:
                    if count > 0:
                        curr.append(str(count))
                        count = 0
                    curr.append(word[j])
                mask >>= 1
            if count > 0:
                curr.append(str(count))
            curr.reverse()
            result.append("".join(curr))
        
        return result
```

## Notes
- Build abbreviations from bitmasks. This solution is better in terms of complexity and because it is truer to binary recursive backtracking nature of the problem; for each character, we can either add it to the current abbreviation chain or we can not abbreviate it. Note how building strings from bitmasks automatically satisfies the problem constraints about valid abbreviations.