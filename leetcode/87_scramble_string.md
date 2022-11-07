# 87. Scramble String - Hard

We can scramble a string `s` to get a string `t` using the following algorithm:

1. If the length of the string is 1, stop.
2. If the length of the string is > 1, do the following:
- Split the string into two non-empty substrings at a random index, i.e., if the string is s, divide it to x and y where s = x + y.
- Randomly decide to swap the two substrings or to keep them in the same order. i.e., after this step, s may become s = x + y or s = y + x.
- Apply step 1 recursively on each of the two substrings x and y.

Given two strings `s1` and `s2` of the same length, return `true` if `s2` is a scrambled string of `s1`, otherwise, return `false`.

##### Example 1:

```
Input: s1 = "great", s2 = "rgeat"
Output: true
Explanation: One possible scenario applied on s1 is:
"great" --> "gr/eat" // divide at random index.
"gr/eat" --> "gr/eat" // random decision is not to swap the two substrings and keep them in order.
"gr/eat" --> "g/r / e/at" // apply the same algorithm recursively on both substrings. divide at random index each of them.
"g/r / e/at" --> "r/g / e/at" // random decision was to swap the first substring and to keep the second substring in the same order.
"r/g / e/at" --> "r/g / e/ a/t" // again apply the algorithm recursively, divide "at" to "a/t".
"r/g / e/ a/t" --> "r/g / e/ a/t" // random decision is to keep both substrings in the same order.
The algorithm stops now, and the result string is "rgeat" which is s2.
As one possible scenario led s1 to be scrambled to s2, we return true.
```

##### Example 2:

```
Input: s1 = "abcde", s2 = "caebd"
Output: false
```

##### Example 3:

```
Input: s1 = "a", s2 = "a"
Output: true
```

##### Constraints:

- `s1.length == s2.length`
- `1 <= s1.length <= 30`
- `s1` and `s2` consist of lowercase English letters.

## Solution

```
# Time: O(n^4)
# Space: O(n)
class Solution:
    def isScramble(self, s1: str, s2: str) -> bool:
        @cache
        def rec(a, b):
            if sorted(a) != sorted(b):
                return False
            if a == b:
                return True
            
            n = len(a)
            for sp in range(1, n):
                noswap = rec(a[:sp], b[:sp]) and rec(a[sp:], b[sp:])
                if noswap:
                    return True
                swap = rec(a[:sp], b[n - sp:]) and rec(a[sp:], b[:n - sp])
                if swap:
                    return True
                
            return False
        
        return rec(s1, s2)
```

## Notes:

- I think this is a very hard problem. It seems like one could follow the directions in the prompt, altering `s1` accordingly. Besides the inefficiency associated with that, I could not implement a solution with that approach that passes certain short input test cases, so it might not even be a valid approach at all. 
- To understand this solution it helps to draw out a recursive call tree for each split point in the original string `s1` and consider which characters of `s1` are compared with those of `s2` in the case where we don't swap about the split point, and in the case where we do swap about the split point.
- In terms of understanding the time complexity, there are <code>O(n<sup>2</sup>)</code> possible substrings in `s1`. Each of those substrings can have <code>O(n<sup>2</sup>)</code> swaps and subswaps.