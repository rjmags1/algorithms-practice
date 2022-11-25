# 273. Integer to English Words - Hard

Convert a non-negative integer `num` to its English words representation.

##### Example 1:

```
Input: num = 123
Output: "One Hundred Twenty Three"
```

##### Example 2:

```
Input: num = 12345
Output: "Twelve Thousand Three Hundred Forty Five"
```

##### Example 3:

```
Input: num = 1234567
Output: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
```

##### Constraints:

- <code>0 <= num <= 2<sup>31</sup> - 1 </code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def numberToWords(self, num: int) -> str:
        ones = [
            "Zero", "One", "Two", "Three", "Four",
            "Five", "Six", "Seven", "Eight", "Nine"
        ]
        teens = [
            "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen",
            "Sixteen", "Seventeen", "Eighteen", "Nineteen"
        ]
        tens = [
            "Ten", "Twenty", "Thirty", "Forty", 
            "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
        ]
        hundred, thousand = "Hundred", "Thousand"
        million, billion = "Million", "Billion"
        
        if num == 0:
            return ones[0]
        
        def parsethree(part):
            curr = []
            if part[0] != "0":
                curr.append(ones[int(part[0])])
                curr.append(hundred)
            if part[1] == "1":
                curr.append(tens[0] if part[2] == "0" else teens[int(part[2]) - 1])
            else:
                if part[1] != "0":
                    curr.append(tens[int(part[1]) - 1])
                if part[2] != "0":
                    curr.append(ones[int(part[2])])
            return curr
        
        num = str(num)
        n, spl = len(num), []
        for i in range(n - 1, -1, -3):
            end = i + 1
            start = max(0, end - 3)
            part = num[start:end]
            part = "0" * (3 - len(part)) + part
            spl.append(part)
            
        result, curr = [], None
        for i, part in enumerate(spl):
            if part == "000":
                continue
                
            if i == 0: # hundreds
                curr = parsethree(part)
            elif i == 1: # thousands
                curr = parsethree(part)
                curr.append(thousand)
            elif i == 2: # millions
                curr = parsethree(part)
                curr.append(million)
            else: # billions
                curr = parsethree(part)
                curr.append(billion)
            result.append(" ".join(curr))
            
        result.reverse()
        return " ".join(result)
```

## Notes
- Not terribly difficult just a lot of edge cases to handle and a lot of boilerplate to write. Note how input is parsed into substrings of length three, AKA powers of `1000` or <code>10<sup>3</sup></code> and zero padded if necessary... consider `12` becomes `012` when `12,877` is parsed. The zero padding removes a lot of extra case handling related to parsing powers of `1000`, when the current power of `1000` has multiple `< 100`.