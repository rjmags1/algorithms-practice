# 520. Detect Capital - Easy

We define the usage of capitals in a word to be right when one of the following cases holds:

- All letters in this word are capitals, like `"USA"`.
- All letters in this word are not capitals, like `"leetcode"`.
- Only the first letter in this word is capital, like `"Google"`.

Given a string `word`, return `true` if the usage of capitals in it is right.

##### Example 1:

```
Input: word = "USA"
Output: true
```

##### Example 2:

```
Input: word = "FlaG"
Output: false
```

##### Constraints:

- `1 <= word.length <= 100`
- `word` consists of lowercase and uppercase English letters.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def detectCapitalUse(self, word: str) -> bool:
        caps = sum(int(c.isupper()) for c in word)
        return caps == len(word) or caps == 0 or (caps == 1 and word[0].isupper())
```

## Notes
- String parsing. Could be a little more efficient by prematurely returning on cases where we have found multiple capitals or multiple lowercases iterating LTR but encounter a lowercase or an uppercase respectively, but this is succinct and idiomatic.