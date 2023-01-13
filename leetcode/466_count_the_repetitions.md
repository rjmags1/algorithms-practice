# 466. Count the Repetitions - Hard

We define `str = [s, n]` as the string str which consists of the string `s` concatenated `n` times.

- For example, `str == ["abc", 3] =="abcabcabc"`.

We define that string `s1` can be obtained from string `s2` if we can remove some characters from `s2` such that it becomes `s1`.

- For example, `s1 = "abc"` can be obtained from `s2 = "abdbec"` based on our definition by removing the bolded underlined characters.

You are given two strings `s1` and `s2` and two integers `n1` and `n2`. You have the two strings `str1 = [s1, n1]` and `str2 = [s2, n2]`.

Return the maximum integer `m` such that `str = [str2, m]` can be obtained from `str1`.

##### Example 1:

```
Input: s1 = "acb", n1 = 4, s2 = "ab", n2 = 2
Output: 2
```

##### Example 2:

```
Input: s1 = "acb", n1 = 1, s2 = "acb", n2 = 1
Output: 1
```

##### Constraints:

- `s1` and `s2` consist of lowercase English letters.
- <code>1 <= s1.length, s2.length <= 100</code>
- <code>1 <= n1, n2 <= 10<sup>6</sup></code>

## Solution

```
# Time: O(n1 * len(s1))
# Space: O(len(s2))
class Solution:
    def getMaxRepetitions(self, s1: str, n1: int, s2: str, n2: int) -> int:
        if len(set(s2) - set(s1)) > 0:
            return 0
        
        repeats = {0: (0, 0)}
        k1 = k2 = i = j = 0
        while k1 < n1:
            if s1[i] == s2[j]:
                j += 1
            i += 1

            if j == len(s2):
                j = 0
                k2 += 1
            if i == len(s1):
                i = 0
                k1 += 1
                if j in repeats:
                    break
                repeats[j] = (k1, k2)
        
        if k1 < n1:
            rep1, rep2 = repeats[j]
            loop1, loop2 = k1 - rep1, k2 - rep2
            loops = (n1 - rep1) // loop1
            k1 = rep1 + loops * loop1
            k2 = rep2 + loops * loop2
    
            while k1 < n1:
                if s1[i] == s2[j]:
                    j += 1
                i += 1
    
                if i == len(s1):
                    i = 0
                    k1 += 1
                if j == len(s2):
                    j = 0
                    k2 += 1
        
        return k2 // n2
```

## Notes
- Another (demoralizingly) tricky one. In this question we are trying to determine how many `k2` times `s2` fits in `s1 * n1`, so we can return `k2 // n2`. A naive approach of iterating over all of `s1 * n1` will TLE due to large upper bound on `n1`. We can avoid unnecessary iterations over `s1 * n1` by looking for repeating cycles of `s2` in `s1 * n1`; in other words, for some number `loop1` of `s1`s concatenated together, once we find a `loop1 * s1` where the last matching `s2` index in it has been seen before at the end of at prior `s1`, we can effectively skip the rest of the `loop` `loop1 * s1`s in `s1 * n1` because there will always be `loop2` repeats of `s2` in each `loop1 * s1`. Note this optimization will not reduce time complexity because it is possible there exists no such `loop1 * s1` in `s1 * n1`, however this optimization is the difference between passing and TLE leetcode's test cases.