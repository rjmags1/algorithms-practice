# 6. Zigzag Conversion - Medium

The string `"PAYPALISHIRING"` is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)

```
P   A   H   N
A P L S I I G
Y   I   R
```

And then read line by line: `"PAHNAPLSIIGYIR"`

Write the code that will take a string and make this conversion given a number of rows:

```
string convert(string s, int numRows);
```

##### Example 1:

```
Input: s = "PAYPALISHIRING", numRows = 3
Output: "PAHNAPLSIIGYIR"
```

##### Example 2:

```
Input: s = "PAYPALISHIRING", numRows = 4
Output: "PINALSIGYAHRPI"
Explanation:
P     I    N
A   L S  I G
Y A   H R
P     I
```

##### Example 3:

```
Input: s = "A", numRows = 1
Output: "A"
```

##### Constraints:

- `1 <= s.length <= 1000`
- `s` consists of English letters (lower-case and upper-case), `','` and `'.'`.
- `1 <= numRows <= 1000`

## Solution 1 - Python
```
# Time: O(n + m)
# Space: O(n + m)
class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if numRows == 1:
            return s
        
        rows = [[] for row in range(numRows)]
        step = 1
        row = 0
        for c in s:
            rows[row].append(c)
            if row == numRows - 1:
                step = -1
            if row == 0:
                step = 1
            row += step
        
        return "".join(["".join(row) for row in rows])
```

#### Notes
- More intuitive IMO but not as efficient as below... could have more rows than characters and end up allocating more empty row arrays than necessary.

## Solution 2 - Python
```
# Time: O(n)
# Space: O(n)
class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if numRows == 1:
            return s
        
        result = []
        cycleLength = 2 * numRows - 2
        for r in range(numRows):
            i = 0
            while r + i < len(s):
                result.append(s[r + i])
                if r != 0 and r != numRows - 1 and i + cycleLength - r < len(s):
                    result.append(s[i + cycleLength - r])
                i += cycleLength
        
        return "".join(result)
```

#### Notes
- Good solution for familiarizing oneself with string/array iteration that does not proceed from one character to the next.
- For the first and last rows, their characters appear at every `k * cycleLength` and `k * cycleLength + numRows - 1` index for `k = 0; k++;`, respectively; for all of the other rows, their characters at indices `(k * cycleLength) + r` for `k = 0; k++;` as well as `(k * cycleLength) - r` for `k = 1; k++;`.

## Solution 1 - C++
```
#include <algorithm>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

// Time: O(n)
// Space: O(n)
class Solution {
public:
    string convert(string s, int numRows) {
        if (numRows == 1) return s;
        
        int n = s.size();
        numRows = min(n, numRows);
        vector<string> rows(numRows);
        int k = 0;
        bool down = true;
        for (int i = 0; i < n; i++) {
            rows[k].push_back(s[i]);
            down ? k++ : k--;
            if (down && k == numRows) {
                k -= 2;
                down = false;
            }
            else if (!down && k == -1) {
                k += 2;
                down = true;
            }
        }

        stringstream ss;
        for (string row : rows) {
            ss << row;
        }

        return ss.str();
    }
};
```