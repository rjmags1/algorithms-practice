# 17. Letter Combinations of a Phone Number - Medium

Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.

A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

<img src="../assets/keypad.png" width="300"/>

##### Example 1:

```
Input: digits = "23"
Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
```

##### Example 2:

```
Input: digits = ""
Output: []
```

##### Example 3:

```
Input: digits = "2"
Output: ["a","b","c"]
```

##### Constraints:

- `0 <= digits.length <= 4`
- `digits[i]` is a digit in the range `['2', '9']`.

## Solution

```
# Time: O(4^n * n)
# Space: O(4^n * n)
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if not digits:
            return []
        
        letters = {
            2: ['a', 'b', 'c'],
            3: ['d', 'e', 'f'],
            4: ['g', 'h', 'i'],
            5: ['j', 'k', 'l'],
            6: ['m', 'n', 'o'],
            7: ['p', 'q', 'r', 's'],
            8: ['t', 'u', 'v'],
            9: ['w', 'x', 'y', 'z']
        } 
        n = len(digits)
        builder = []
        result = []
        
        def rec(i):
            if i == n:
                result.append("".join(builder))
                return
            
            num = int(digits[i])
            for letter in letters[num]:
                builder.append(letter)
                rec(i + 1)
                builder.pop()
        
        rec(0)
        return result
```

## Notes
- Enumerative recursive problem using string building to avoid a bunch of O(n) string concats.

## Solution - C++

```
#include <vector>
#include <string>
#include <stdexcept>
#include <numeric>

class Solution {
    
public:
    Solution() {
        this->builder = {};
        this->result = {};
    }

    vector<string> letterCombinations(string digits) {
        this->builder = {};
        this->result = {};
        if (digits != "") {
            this->letterCombinations(digits, 0);
        }
        return this->result;
    }

private:
    vector<string> builder;
    vector<string> result;

    void letterCombinations(string& digits, int i) {
        if (i == digits.size()) {
            auto combo = vector<string>(this->builder.begin(), this->builder.end());
            this->result.push_back(accumulate(combo.begin(), combo.end(), string("")));
            return;
        }

        string letters = this->map(digits[i] - '0');
        for (int k = 0; k < letters.size(); k++) {
            this->builder.push_back(string(1, letters[k]));
            letterCombinations(digits, i + 1);
            this->builder.pop_back();
        }
    }

    string map(int i) {
        switch (i) {
            case 2:
                return "abc";
            case 3:
                return "def";
            case 4:
                return "ghi";
            case 5:
                return "jkl";
            case 6:
                return "mno";
            case 7:
                return "pqrs";
            case 8:
                return "tuv";
            case 9:
                return "wxyz";
            default:
                throw invalid_argument("input range out of bounds");
        }
    }
};
```

## Notes
- `accumulate` to join `vector<string>`
- `string(int, char)` for casting `char` to `string`
