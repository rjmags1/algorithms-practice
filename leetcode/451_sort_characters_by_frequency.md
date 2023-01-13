# 451. Sort Characters by Frequency - Medium

Given a string `s`, sort it in decreasing order based on the frequency of the characters. The frequency of a character is the number of times it appears in the string.

Return the sorted string. If there are multiple answers, return any of them.

##### Example 1:

```
Input: s = "tree"
Output: "eert"
Explanation: 'e' appears twice while 'r' and 't' both appear once.
So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
```

##### Example 2:

```
Input: s = "cccaaa"
Output: "aaaccc"
Explanation: Both 'c' and 'a' appear three times, so both "cccaaa" and "aaaccc" are valid answers.
Note that "cacaca" is incorrect, as the same characters must be together.
```

##### Example 3:

```
Input: s = "Aabb"
Output: "bbAa"
Explanation: "bbaA" is also a valid answer, but "Aabb" is incorrect.
Note that 'A' and 'a' are treated as two different characters.
```

##### Constraints:

- <code>1 <= s.length <= 5 * 10<sup>5</sup></code>
- `s` consists of uppercase and lowercase English letters and digits.

## Solution

```
from collections import Counter, defaultdict

# Time: O(n)
# Space: O(n)
class Solution:
    def frequencySort(self, s: str) -> str:
        freqs = Counter(s)
        freqs2 = defaultdict(list)
        for c, f in freqs.items():
            freqs2[f].append(c)
        result = []
        for count in reversed(range(1, len(s) + 1)):
            if count in freqs2:
                for c in freqs2[count]:
                    result.append(c * count)
        return "".join(result)
```

## Notes
- We can avoid sorting the frequencies of characters by doing an `O(n)` iteration over all the possible frequencies in descending order.