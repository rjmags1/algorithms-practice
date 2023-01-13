# 405. Convert a Number to Hexadecimal - Easy

Given an integer `num`, return a string representing its hexadecimal representation. For negative integers, two’s complement method is used.

All the letters in the answer string should be lowercase characters, and there should not be any leading zeros in the answer except for the zero itself.

Note: You are not allowed to use any built-in library method to directly solve this problem.

##### Example 1:

```
Input: num = 26
Output: "1a"
```

##### Example 2:

```
Input: num = -1
Output: "ffffffff"
```

##### Constraints:

- <code>-2<sup>31</sup> <= num <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def toHex(self, num: int) -> str:
        hexchars = [str(i) for i in range(10)] + [c for c in "abcdef"]
        result, mask = [], 15
        for i in range(8):
            result.append(hexchars[num & mask])
            num >>= 4
        while len(result) > 1 and result[-1] == "0":
            result.pop()
        return "".join(reversed(result))
```

## Notes
- Extract nibbles with `15` hex mask and map to appropriate character. Be sure to get rid of leading zeroes.