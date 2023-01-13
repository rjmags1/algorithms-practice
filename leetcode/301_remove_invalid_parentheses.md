# 301. Remove Invalid Parentheses - Hard

Given a string `s` that contains parentheses and letters, remove the minimum number of invalid parentheses to make the input string valid.

Return all the possible results. You may return the answer in any order.

##### Example 1:

```
Input: s = "()())()"
Output: ["(())()","()()()"]
```

##### Example 2:

```
Input: s = "(a)())()"
Output: ["(a())()","(a)()()"]
```

##### Example 3:

```
Input: s = ")("
Output: [""]
```

##### Constraints:

- `1 <= s.length <= 25`
- `s` consists of lowercase English letters and parentheses `'('` and `')'`.
- There will be at most `20` parentheses in `s`.

## Solution

```
# Time: O(n * 2^n)
# Space: O(n * 2^n)
class Solution:
    def removeInvalidParentheses(self, s: str) -> List[str]:
        def getunbal(s):
            l = ubr = 0
            for c in s:
                if c == "(":
                    l += 1
                elif c == ")":
                    if l == 0:
                        ubr += 1
                    else:
                        l -= 1
            ubl = l
            return ubl, ubr
        
        ubl, ubr = getunbal(s)
        n = len(s)
        vlen = n - (ubl + ubr)
        builder, result = [], set()
        def rec(i, o, c, skipo, skipc):
            if len(builder) == vlen:
                if o == c:
                    result.add("".join(builder))
                return
            
            ch = s[i]
            if ch == "(":
                builder.append(ch)
                rec(i + 1, o + 1, c, skipo, skipc)
                builder.pop()
                if skipo > 0:
                    rec(i + 1, o, c, skipo - 1, skipc)
            elif ch == ")":
                if o > c:
                    builder.append(ch)
                    rec(i + 1, o, c + 1, skipo, skipc)
                    builder.pop()
                if skipc > 0:
                    rec(i + 1, o, c, skipo, skipc - 1)
            else:
                builder.append(ch)
                rec(i + 1, o, c, skipo, skipc)
                builder.pop()
        
        rec(0, 0, 0, ubl, ubr)
        return list(result)
```

## Notes
- We are being asked to enumerate all possible valid strings with minimal removals, and naively to do so we could recurse on all characters. If the character is a paren, we could recurse forward with the paren char included in the next possibility as well as with the paren char not in the next possibility. Also naively, if we reach the max valid length, we check if the current possibility is valid, and if it is we add it to the result. 
- Finding the max valid length/min removals is not terribly hard if you have dealt with parentheses problems before and have internalized the concepts. Just find the unbalanced opening and unbalanced closing parens.
- In these kinds of enumeration problems, to avoid TLE we usually want to prune the search space to prematurely stop searching on a search space tree node that is not going to lead to a valid answer. For this problem, to do so we only want to recurse forward after skipping an opening paren if we haven't already skipped the max number of skippable opening parens. If we skip too many opening parens it will be impossible for us to build a valid possiblity. Similarly, we only want to add closing parens to the current possibility when there is an opening paren in the current possibility to match it, and we only want to skip closing parens if we haven't already skipped the max number of skippable closing parens.
- If we prune the search space like so, the only invalid possibilities that we will end up building are ones with more opening parens than closing parens, and so as long as we check for excessive openings and that we haven't already encountered the current possibility, we will be able to efficiently enumerate all max length valid possibilities.