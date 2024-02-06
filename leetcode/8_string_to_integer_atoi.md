# 8. String to Integer (atoi) - Medium

Implement the `myAtoi(string s)` function, which converts a string to a 32-bit signed integer (similar to C/C++'s `atoi` function).

The algorithm for `myAtoi(string s)` is as follows:

1. Read in and ignore any leading whitespace.
2. Check if the next character (if not already at the end of the string) is `'-'` or `'+'`. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.
3. Read in next the characters until the next non-digit character or the end of the input is reached. The rest of the string is ignored.
4. Convert these digits into an integer (i.e. `"123" -> 123`, `"0032" -> 32`). If no digits were read, then the integer is `0`. Change the sign as necessary (from step 2).
5. If the integer is out of the 32-bit signed integer range <code>[-2<sup>31</sup>, 2<sup>31</sup> - 1]</code>, then clamp the integer so that it remains in the range. Specifically, integers less than <code>-2<sup>31</sup></code> should be clamped to <code>-2<sup>31</sup></code>, and integers greater than <code>2<sup>31</sup> - 1</code> should be clamped to <code>2<sup>31</sup> - 1</code>.
6. Return the integer as the final result.

###### Note:

Only the space character `' '` is considered a whitespace character.
Do not ignore any characters other than the leading whitespace or the rest of the string after the digits.

##### Example 1:

```
Input: s = "42"
Output: 42
Explanation: The underlined characters are what is read in, the caret is the current reader position.
Step 1: "42" (no characters read because there is no leading whitespace)
         ^
Step 2: "42" (no characters read because there is neither a '-' nor '+')
         ^
Step 3: "42" ("42" is read in)
           ^
The parsed integer is 42.
Since 42 is in the range [-231, 231 - 1], the final result is 42.
```

##### Example 2:

```
Input: s = "   -42"
Output: -42
Explanation:
Step 1: "   -42" (leading whitespace is read and ignored)
            ^
Step 2: "   -42" ('-' is read, so the result should be negative)
             ^
Step 3: "   -42" ("42" is read in)
               ^
The parsed integer is -42.
Since -42 is in the range [-231, 231 - 1], the final result is -42.
```

##### Example 3:

```
Input: s = "4193 with words"
Output: 4193
Explanation:
Step 1: "4193 with words" (no characters read because there is no leading whitespace)
         ^
Step 2: "4193 with words" (no characters read because there is neither a '-' nor '+')
         ^
Step 3: "4193 with words" ("4193" is read in; reading stops because the next character is a non-digit)
             ^
The parsed integer is 4193.
Since 4193 is in the range [-231, 231 - 1], the final result is 4193.
```

##### Constraints:

- `0 <= s.length <= 200`
- `s` consists of English letters (lower-case and upper-case), digits (`0-9`), `' '`, `'+'`, `'-'`, and `'.'`. 

## Solution - Python
```
MAX_INT = 2 ** 31 - 1
ABS_MIN_INT = 2 ** 31
MAX_FLOORED = MAX_INT // 10
class Parser:
    def __init__(self, s):
        # possible parser states
        self.START = 'start'
        self.SIGN = 'sign'
        self.DIGIT = 'digit'
        self.STOP = 'stop'
        self.OVERFLOW = 'overflow'
        
        # other stuff
        self.s = s
        self.n = len(s)
        self.i = 0
        self.neg = False
        self.result = 0
        self.state = self.START if s else self.STOP
        
    def parse(self):
        while self.state != self.STOP:
            if self.n == self.i:
                self.state = self.STOP
                break
                
            if self.state == self.START:
                self.handleStart()
            elif self.state == self.SIGN:
                self.handleSign()
            elif self.state == self.DIGIT:
                self.handleDigit()
            elif self.state == self.OVERFLOW:
                self.result = ABS_MIN_INT if self.neg else MAX_INT
                self.state = self.STOP
                
        return -self.result if self.neg else self.result
    
    def handleDigit(self):
        d = int(self.s[self.i])
        if self.neg and (self.result > MAX_FLOORED or (self.result == MAX_FLOORED and d > ABS_MIN_INT % 10)):
            self.state = self.OVERFLOW
            return
        if not self.neg and (self.result > MAX_FLOORED or (self.result == MAX_FLOORED and d > MAX_INT % 10)):
            self.state = self.OVERFLOW
            return
        
        self.result = self.result * 10 + d
        self.i += 1
        if self.i == self.n:
            self.state = self.STOP
            return
        if not self.s[self.i].isdigit():
            self.state = self.STOP
            
    def handleSign(self):
        if self.s[self.i] == '-':
            self.neg = True
            
        self.i += 1
        if self.i == self.n or not self.s[self.i].isdigit():
            self.state = self.STOP
            return
        
        self.state = self.DIGIT
    
    def handleStart(self):
        c = self.s[self.i]
        while self.i < self.n and c == ' ':
            self.i += 1
            c = self.s[self.i] if self.i < self.n else None
        if self.i == self.n:
            self.state = self.STOP
            return
            
        if c == '+' or c == '-':
            self.state = self.SIGN
        elif c.isdigit():
            self.state = self.DIGIT
        else:
            self.state = self.STOP
            
# Time: O(n)
# Space: O(1)
class Solution:
    def myAtoi(self, s: str) -> int:
        parser = Parser(s)
        parsed = parser.parse()
        return parsed
```

## Notes
- Could naively try and solve this with complicated series of nested if-else statements according to the prompt, but it is much cleaner to go with an OOP approach, implementing a DFA (deterministic finite automaton AKA state machine). 
- I named the state machine above a Parser but it does what a DFA does: navigate between a set of predefined states based on some input, altering data/variables along the way.

## Solution - C++
```
#include <limits.h>

using namespace std;

class Solution {
public:
    int myAtoi(string s) {
        int result = 0;
        int sign = 1;
        States state = Start;
        int i = 0;
        int n = s.size();
        int intLimitsFloored = INT_MAX / 10;
        while (i < n && state != End) {
            char c = s[i++];
            switch (state) {
                case Start:
                    if (c == ' ') {
                        state = Whitespace;
                    }
                    else if (c >= '0' && c <= '9') {
                        result = c - '0';
                        state = Digit;
                    }
                    else if (c == '+' || c == '-') {
                        sign = c == '+' ? 1 : -1;
                        state = Sign;
                    }
                    else {
                        state = End;
                    }
                    break;
                case Sign:
                    if (c >= '0' && c <= '9') {
                        result = result * 10 + (c - '0');
                        state = Digit;
                    }
                    else {
                        state = End;
                    }
                    break;
                case Whitespace:
                    if (c >= '0' && c <= '9') {
                        result = result * 10 + (c - '0');
                        state = Digit;
                    }
                    else if (c == '+' || c == '-') {
                        sign = c == '+' ? 1 : -1;
                        state = Sign;
                    }
                    else if (c != ' ') {
                        state = End;
                    }
                    break;
                case Digit:
                    if (c >= '0' && c <= '9') {
                        result = result * 10 + (c - '0');
                        state = Digit;
                    }
                    else {
                        state = End;
                    }
                    break;
            }

            if (result >= intLimitsFloored && i < n) {
                char nextc = s[i++];
                if (nextc < '0' || nextc > '9') {
                    break;
                }
                if (result > intLimitsFloored || (sign == -1 ? nextc >= '8' : nextc >= '7')) {
                    return sign == -1 ? INT_MIN : INT_MAX;
                }
                result = result * 10 + (nextc - '0');
                if (i < n and s[i] >= '0' && s[i] <= '9') {
                    return sign == -1 ? INT_MIN : INT_MAX;
                }
            }
        }

        return result * sign;
    }

private:
    enum States {
        Start,
        Sign,
        Whitespace,
        Digit,
        End
    };
};
```