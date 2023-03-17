# 2272. Substring with Largest Variance - Hard

The variance of a string is defined as the largest difference between the number of occurrences of any `2` characters present in the string. Note the two characters may or may not be the same.

Given a string `s` consisting of lowercase English letters only, return the largest variance possible among all substrings of `s`.

A substring is a contiguous sequence of characters within a string.

##### Example 1:

```
Input: s = "aababbb"
Output: 3
Explanation:
All possible variances along with their respective substrings are listed below:
- Variance 0 for substrings "a", "aa", "ab", "abab", "aababb", "ba", "b", "bb", and "bbb".
- Variance 1 for substrings "aab", "aba", "abb", "aabab", "ababb", "aababbb", and "bab".
- Variance 2 for substrings "aaba", "ababbb", "abbb", and "babb".
- Variance 3 for substring "babbb".
Since the largest possible variance is 3, we return it.
```

##### Example 2:

```
Input: s = "abcde"
Output: 0
Explanation:
No letter occurs more than once in s, so the variance of every substring is 0.
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>4</sup></code>
- `s` consists of lowercase English letters.

## Solution

```
from string import ascii_lowercase

# Time: O(26 * 25 * n) -> O(n)
# Space: O(1)
class Solution:
    def largestVariance(self, s: str) -> int:
        result = 0
        for c1 in ascii_lowercase:
            for c2 in ascii_lowercase:
                if c1 == c2: 
                    continue
                currVar, hasC2, c2Start = 0, False, False
                for c in s:
                    if c == c1:
                        currVar += 1
                    elif c == c2:
                        hasC2 = True
                        if c2Start and currVar >= 0:
                            c2Start = False
                        else:
                            currVar -= 1
                            if currVar < 0:
                                currVar = -1
                                c2Start = True
                    if hasC2:
                        result = max(result, currVar)

        return result
```

## Notes
- This is a pretty tricky problem because it involves recognizing we are dealing with a Kadane-esque problem with several non-standard edge cases. A naive approach involves inspecting all substrings and determining the max and min character frequencies for each of them. This will TLE because of the large possible input length. To get around this, we recognize that only two characters are relevant when considering variances, so we consider all possible permutational pairs, of which there are on the order of ~10^2. For each pair, we consider the first character as a `1` in a Kadane max subarray sum problem, and the second as `-1` to find the max variance substring for the character pair. To address all possible cases, we keep in mind that variances only should be considered as potential results when its substring contains both pair characters. Similarly, whenever the current substring starts with the second character and we encounter another one, we want to greedily chop of the first character of the current substring.