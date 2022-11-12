# 171. Excel Sheet Column Number - Easy

Given a string `columnTitle` that represents the column title as appears in an Excel sheet, return its corresponding column number.

For example:

```
A -> 1
B -> 2
C -> 3
...
Z -> 26
AA -> 27
AB -> 28 
...
```

##### Example 1:

```
Input: columnTitle = "A"
Output: 1
```

##### Example 2:

```
Input: columnTitle = "AB"
Output: 28
```

##### Example 3:

```
Input: columnTitle = "ZY"
Output: 701
```

##### Constraints:

- `1 <= columnTitle.length <= 7`
- `columnTitle` consists only of uppercase English letters.
- `columnTitle` is in the range `["A", "FXSHRXW"]`.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def titleToNumber(self, columnTitle: str) -> int:
        offset = ord("A") - 1
        exp, radix = 0, 26
        result = 0
        for i in reversed(range(len(columnTitle))):
            k = ord(columnTitle[i]) - offset
            result += k * (radix ** exp)
            exp += 1
        return result
```

## Notes
- Excel column titles are base-26. See 168. Excel Sheet Column Title for a more in depth explanation.