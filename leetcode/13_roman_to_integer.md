# 13. Roman To Integer - Easy

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not `IIII`. Instead, the number four is written as `IV`. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as `IX`. There are six instances where subtraction is used:

```
Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
```

- `I` can be placed before `V` (5) and `X` (10) to make `4` and `9`. 
- `X` can be placed before `L` (50) and `C` (100) to make `40` and `90`. 
- `C` can be placed before `D` (500) and `M` (1000) to make `400` and `900`.

Given a roman numeral, convert it to an integer.

##### Example 1:

```
Input: s = "III"
Output: 3
Explanation: III = 3.
```

##### Example 2:

```
Input: s = "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.
```

##### Example 3:

```
Input: s = "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
```

##### Constraints:

- `1 <= s.length <= 15`
- `s` contains only the characters `('I', 'V', 'X', 'L', 'C', 'D', 'M')`.
- It is guaranteed that `s` is a valid roman numeral in the range `[1, 3999]`.

## Solution 1
```
# Time: O(n)
# Space: O(c) (c <- possible chars in s)
class Solution:
    def romanToInt(self, s: str) -> int:
        letters = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
        special = ['I', 'X', 'C']
        result = i = 0
        while i < len(s):
            curr = s[i]
            if i < len(s) - 1 and s[i] in special:
                nxt = s[i + 1]
                if curr == 'I' and nxt in ['V', 'X']:
                    i += 2
                    result += 9 if nxt == 'X' else 4
                    continue
                elif curr == 'X' and nxt in ['L', 'C']:
                    i += 2
                    result += 90 if nxt == 'C' else 40
                    continue
                elif curr == 'C' and nxt in ['D', 'M']:
                    i += 2
                    result += 900 if nxt == 'M' else 400
                    continue
                    
            result += letters[curr]
            i += 1
        
        return result
```

## Notes
- Duplicate code in above example because we enumerate over each special case of two chars representing a number.

## Solution 2
```
# Time: O(n)
# Space: O(c) (c <- possible chars in s)
values = {
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000,
}

class Solution:
    def romanToInt(self, s: str) -> int:
        total = values[s[-1]]
        for i in reversed(range(len(s) - 1)):
            if values[s[i]] < values[s[i + 1]]:
                total -= values[s[i]]
            else:
                total += values[s[i]]
        return total
```

## Notes
- Much cleaner because we use the fact that all two character special cases disrupt the otherwise non-ascending sorted order of characters in a Roman numeral.

## Solution 3 - C++
```
// Time: O(n)
// Space: O(c)
class Solution {
public:
    int romanToInt(string s) {
        unordered_map <char, int> values {
            {'I', 1},
            {'V', 5},
            {'X', 10},
            {'L', 50},
            {'C', 100},
            {'D', 500},
            {'M', 1000}
        };

        int n = s.size();
        int result = 0;
        for (int i = 0; i < n; i++) {
            if (i < n - 1 && values[s[i]] < values[s[i + 1]]) {
                result -= values[s[i]];
            }
            else {
                result += values[s[i]];
            }
        }

        return result;
    }
};
```
