# 32. Longest Valid Parentheses - Hard

Given a string containing just the characters `'('` and `')'`, find the length of the longest valid (well-formed) parentheses substring.

##### Example 1:

```
Input: s = "(()"
Output: 2
Explanation: The longest valid parentheses substring is "()".
```

##### Example 2:

```
Input: s = ")()())"
Output: 4
Explanation: The longest valid parentheses substring is "()()".
```

##### Example 3:

```
Input: s = ""
Output: 0
```

##### Constraints:

- <code>0 <= s.length <= 3 * 10<sup>4</sup></code>
- `s[i]` is `'('`, or `')'`

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def longestValidParentheses(self, s: str) -> int:
        dp = [0 for c in s]
        result = 0
        for i, c in enumerate(s):
            if c == '(' or i == 0:
                continue
                
            if s[i - 1] == '(':
                dp[i] = 2 + dp[i - 2] if i > 1 else 2
            else:
                matchingOpenIdx = i - 1 - dp[i - 1]
                if matchingOpenIdx >= 0 and s[matchingOpenIdx] == '(':
                    dp[i] = 2 + dp[i - 1]
                    if matchingOpenIdx - 1 >= 0:
                        dp[i] += dp[matchingOpenIdx - 1]
                else:
                    dp[i] = 0
            result = max(result, dp[i])
        
        return result
```

## Notes
- Pretty intuitive dp solution, usually I stray away from dp if I can but for me it is the most intuitive approach for this problem.
- Whenever we encounter a closing paren, there is a chance it is the end of a non-zero length well-formed paren substring. If the previous char was an opening paren, all we need to do is add 2 to the length of the longest well-formed paren substring before the opening paren that matches the current closing paren. If the previous char was another closing paren, the logic becomes considerably more complicated but still intuitive IMO. Essentially, we can determine the matching open paren position (if it exists) based on `dp[i - 1]`. If there is a matching open paren, we add 2 to dp[i - 1]. After that, we may need to add more to `dp[i]` if there was a well-formed paren substring before the matching opening paren of the current closing paren.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def longestValidParentheses(self, s: str) -> int:
        opening = closing = result = 0
        for c in s:
            if c == '(':
                opening += 1
            else:
                closing += 1
                
            if opening == closing:
                result = max(result, 2 * closing)
            elif closing > opening:
                opening = closing = 0
        
        opening = closing = 0
        for c in reversed(s):
            if c == '(':
                opening += 1
            else:
                closing += 1
            
            if opening == closing:
                result = max(result, 2 * opening)
            elif opening > closing:
                opening = closing = 0
            
        return result
```

## Notes
- This approach is a lot cleaner, and makes a lot of sense once you have seen the solution, but it is hard to come up with the conceptual strategy without prior exposure.
- The main idea is that, when iterating LTR, once we have seen more closing parens than opening parens, it is impossible for us to match the excess closing parens. Similarly, when iterating RTL, once we have seen more opening parens than closing parens, it will be impossible to match the excess opening ones.