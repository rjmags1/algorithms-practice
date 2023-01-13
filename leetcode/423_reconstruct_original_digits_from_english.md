# 423. Reconstruct Original Digits from English - Medium

Given a string `s` containing an out-of-order English representation of digits `0-9`, return the digits in ascending order.

##### Example 1:

```
Input: s = "owoztneoer"
Output: "012"
```

##### Example 2:

```
Input: s = "fviefuro"
Output: "45"
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s[i]` is one of the characters `["e","g","f","i","h","o","n","s","r","u","t","w","v","x","z"]`.
- `s` is guaranteed to be valid.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def originalDigits(self, s: str) -> str:
        freqs = [0] * 26
        off = ord('a')
        for c in s:
            freqs[ord(c) - off] += 1
        dl = ['z', 'g', 'x', 'w', 's', 'h', 'u', 'v', 'o', 'i']
        dw = ['zero', 'eight', 'six', 'two', 'seven', 'three', 'four', 'five', 'one', 'nine']
        dd = ['0', '8', '6', '2', '7', '3', '4', '5', '1', '9']
        distinct = zip(dl, dw, dd)
        result = [0 for _ in range(10)]
        for letter, word, digit in distinct:
            while freqs[ord(letter) - off] > 0:
                result[int(digit)] += 1
                for l in word:
                    freqs[ord(l) - off] -= 1

        return "".join(str(i) * result[i] for i in range(10))
```

## Notes
- Take advantage of letter in each digit word that distinguish it from the rest of the digits we have yet to consider.