# 93. Restore IP Addresses - Medium

A valid IP address consists of exactly four integers separated by single dots. Each integer is between `0` and `255` (inclusive) and cannot have leading zeros.

- For example, `"0.1.2.201"` and `"192.168.1.1"` are valid IP addresses, but `"0.011.255.245"`, `"192.168.1.312"` and `"192.168@1.1"` are invalid IP addresses.

Given a string `s` containing only digits, return all possible valid IP addresses that can be formed by inserting dots into s. You are not allowed to reorder or remove any digits in `s`. You may return the valid IP addresses in any order.

##### Example 1:

```
Input: s = "25525511135"
Output: ["255.255.11.135","255.255.111.35"]
```

##### Example 2:

```
Input: s = "0000"
Output: ["0.0.0.0"]
```

##### Example 3:

```
Input: s = "101023"
Output: ["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]
```

##### Constraints:

- `1 <= s.length <= 20`
- `s` consists of digits only.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        builder, result = [], []
        n = len(s)
        def rec(i):
            if i == n:
                return
            
            if len(builder) == 3:
                if i != n - 1 and s[i] == "0":
                    return
                rest = int(s[i:])
                if 0 <= rest <= 255:
                    builder.append(rest)
                    result.append(".".join([str(num) for num in builder]))
                    builder.pop()
                return
            
            if s[i] == "0":
                builder.append(s[i])
                rec(i + 1)
                builder.pop()
                return
            
            for j in range(i + 1, min(n, i + 4)):
                num = int(s[i:j])
                if 0 <= num <= 255:
                    builder.append(num)
                    rec(j)
                    builder.pop()
        
        rec(0)
        return result
```

## Notes
- The complexity here is constant because valid IP addresses have at least 4 non-dot characters and at most 12 non-dot characters, which results in a constant upper bound on the number of possible IP addresses that can be built from a particular input.
- There are several edge cases in this problem that are easy to miss. We need to watch out for when `i` points to a zero, as this would result in an invalid leading zero if we allow a multi-digit number to be appended to `builder` in such a recursive call. Additionally, if `i` is ever `== n`, we know that there are not enough characters in `s` for us to build a valid IP address with the substrings in `builder`.