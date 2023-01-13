# 468. Validate IP Address - Medium

Given a string `queryIP`, return `"IPv4"` if IP is a valid IPv4 address, `"IPv6"` if IP is a valid IPv6 address or `"Neither"` if IP is not a correct IP of any type.

A valid IPv4 address is an IP in the form `"x1.x2.x3.x4"` where `0 <= xi <= 255` and `xi` cannot contain leading zeros. For example, `"192.168.1.1"` and `"192.168.1.0"` are valid IPv4 addresses while `"192.168.01.1", "192.168.1.00", and "192.168@1.1"` are invalid IPv4 addresses.

A valid IPv6 address is an IP in the form `"x1:x2:x3:x4:x5:x6:x7:x8"` where:

- `1 <= xi.length <= 4`
- `xi` is a hexadecimal string which may contain digits, lowercase English letter (`'a'` to `'f'`) and upper-case English letters (`'A'` to `'F'`).
- Leading zeros are allowed in `xi`.

For example, `"2001:0db8:85a3:0000:0000:8a2e:0370:7334"` and `"2001:db8:85a3:0:0:8A2E:0370:7334"` are valid IPv6 addresses, while `"2001:0db8:85a3::8A2E:037j:7334"` and `"02001:0db8:85a3:0000:0000:8a2e:0370:7334"` are invalid IPv6 addresses.

##### Example 1:

```
Input: queryIP = "172.16.254.1"
Output: "IPv4"
Explanation: This is a valid IPv4 address, return "IPv4".
```

##### Example 2:

```
Input: queryIP = "2001:0db8:85a3:0:0:8A2E:0370:7334"
Output: "IPv6"
Explanation: This is a valid IPv6 address, return "IPv6".
```

##### Example 3:

```
Input: queryIP = "256.256.256.256"
Output: "Neither"
Explanation: This is neither a IPv4 address nor a IPv6 address.
```

##### Constraints:

- `queryIP` consists only of English letters, digits and the characters `'.'` and `':'`.

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    v6chars = "ABCDEFabcdef"
    def val6(self, s):
        if len(s) > 7 + 4 * 8:
            return False
        xs = s.split(":")
        if len(xs) != 8:
            return False
        for x in xs:
            if not 1 <= len(x) <= 4:
                return False
            for c in x:
                if not (c.isdigit() or c in self.v6chars):
                    return False
        return True
    
    def val4(self, s):
        if len(s) > 3 + 4 * 3:
            return False
        xs = s.split('.')
        if len(xs) != 4:
            return False
        for x in xs:
            if not 1 <= len(x) <= 3 or not all(c.isdigit() for c in x):
                return False
            if (len(x) > 1 and x[0] == "0") or not 0 <= int(x) <= 255:
                return False
        return True

    def validIPAddress(self, queryIP: str) -> str:
        if len(queryIP) > 7 + 4 * 8:
            return "Neither"

        v6 = ':' in queryIP
        if v6 and self.val6(queryIP):
            return "IPv6"
        return "Neither" if not self.val4(queryIP) else "IPv4"
```

## Notes
- String parsing, make time and space constant be early elimination of excessive length inputs.