# 65. Valid Number - Hard

A valid number can be split up into these components (in order):

1. A decimal number or an integer.
2. (Optional) An `'e'` or `'E'`, followed by an integer.

A decimal number can be split up into these components (in order):

1. (Optional) A sign character (either `'+'` or `'-'`).
2. One of the following formats:
    1. One or more digits, followed by a dot `'.'`.
    2. One or more digits, followed by a dot `'.'`, followed by one or more digits.
    3. A dot `'.'`, followed by one or more digits.

An integer can be split up into these components (in order):

1. (Optional) A sign character (either `'+'` or `'-'`).
2. One or more digits.

For example, all the following are valid numbers: `["2", "0089", "-0.1", "+3.14", "4.", "-.9", "2e10", "-90E3", "3e+7", "+6e-1", "53.5e93", "-123.456e789"]`, while the following are not valid numbers: `["abc", "1a", "1e", "e3", "99e2.5", "--6", "-+3", "95a54e53"]`.

Given a string `s`, return true if `s` is a valid number.

##### Example 1:

```
Input: s = "0"
Output: true
```

##### Example 2:

```
Input: s = "e"
Output: false
```

##### Example 3:

```
Input: s = "."
Output: false
```

##### Constraints:

- `1 <= s.length <= 20`
- `s` consists of only English letters (both uppercase and lowercase), digits (`0-9`), plus `'+'`, minus `'-'`, or dot `'.'`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def eatDecimal(self):
        if self.s[self.i] in ['+', '-']:
            self.i += 1
        seenDigit = seenDot = False
        while self.i < self.n:
            c = self.s[self.i]
            if c == '.':
                if seenDot:
                    return False
                seenDot = True
            elif c.isdigit():
                seenDigit = True
            else:
                break
            self.i += 1
        
        return seenDigit and seenDot
    
    def eatInteger(self):
        if self.s[self.i] in ['+', '-']:
            self.i += 1
        seenDigit = False
        while self.i < self.n and self.s[self.i].isdigit():
            seenDigit = True
            self.i += 1
        
        return seenDigit
    
    def isNumber(self, s: str) -> bool:
        self.i, self.s, self.n = 0, s, len(s)
        if '.' in s:
            if not self.eatDecimal():
                return False
        else:
            if not self.eatInteger():
                return False
        
        if self.i < self.n:
            if self.s[self.i] in ['e', 'E']:
                self.i += 1
                if self.i == self.n or not self.eatInteger():
                    return False
            else:
                return False
        
        return self.i == self.n
```

## Notes
- For problems like these where we need to navigate between a finite set of states to determine an answer, we want to go with a DFA approach, and it is best to use the abstractions that yield the least amount of complexity in code.
- This problem has one of the lowest acceptance rates on LC simply because of the large number of edge cases in the problem that are easy to miss.
- This solution literally translates the requirements in the prompt into code by creating functional abstractions around the provided definitions of integer and decimal. The official DFA solution on leetcode uses lower level states like dot, digit, e, etc., and has a more complex state machine diagram that translates to less code for their official DFA approach, but is less idiomatic than above IMO.