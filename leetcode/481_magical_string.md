# 481. Magical String - Medium

A magical string `s` consists of only `'1'` and `'2'` and obeys the following rules:

- The string `s` is magical because concatenating the number of contiguous occurrences of characters `'1'` and `'2'` generates the string `s` itself.

The first few elements of `s` is `s = "1221121221221121122……"`. If we group the consecutive `1`'s and `2`'s in s, it will be `"1 22 11 2 1 22 1 22 11 2 11 22 ......"` and the occurrences of `1`'s or `2`'s in each group are `"1 2 2 1 1 2 1 2 2 1 2 2 ......"`. You can see that the occurrence sequence is `s` itself.

Given an integer `n`, return the number of `1`'s in the first `n` number in the magical string `s`.

##### Example 1:

```
Input: n = 6
Output: 3
Explanation: The first 6 elements of magical string s is "122112" and it contains three 1's, so return 3.
```

##### Example 2:

```
Input: n = 1
Output: 1
```

##### Constraints:

- <code>1 <= n <= 10<sup>5</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def magicalString(self, n: int) -> int:
        ms, j = [1, 2, 2], 2
        result = 1
        while len(ms) < n:
            curr = ms[-1] ^ 3
            if curr == 1:
                result += ms[j]
            ms.append(curr)
            if ms[j] == 2:
                ms.append(curr)
            j += 1
        if len(ms) > n and ms[-1] == 1:
            result -= 1
        return result
```

## Notes
- Tough question because `s` defines itself but it is difficult to nail down how algorithmically without randomly observing how to generate `s` from a seed of itself. We need to start at a particular position in `s` in order to take advantage of how `s` can defines itself, to generate magical string `s` extended to `n` characters. We keep track of the group length `ms[j]` of the current addition, and add whatever number we didn't add in the previous iteration `ms[j]` times. 