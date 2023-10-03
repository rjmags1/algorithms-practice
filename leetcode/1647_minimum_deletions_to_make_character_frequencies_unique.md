# 1647. Minimum Deletions to Make Character Frequencies Unique - Medium

A string `s` is called good if there are no two different characters in `s` that have the same frequency.

Given a string `s`, return the minimum number of characters you need to delete to make `s` good.

The frequency of a character in a string is the number of times it appears in the string. For example, in the string `"aab"`, the frequency of `'a'` is `2`, while the frequency of `'b'` is `1`.

##### Example 1:

```
Input: s = "aab"
Output: 0
Explanation: s is already good.
```

##### Example 2:

```
Input: s = "aaabbbcc"
Output: 2
Explanation: You can delete two 'b's resulting in the good string "aaabcc".
Another way it to delete one 'b' and one 'c' resulting in the good string "aaabbc".
```

##### Example 3:

```
Input: s = "ceabaacb"
Output: 2
Explanation: You can delete both 'c's resulting in the good string "eabaab".
Note that we only care about characters that are still in the string at the end (i.e. frequency of 0 is ignored).
```

##### Constraints:

- <code>1 <= s.length <= 10<sup>5</sup></code>
- `s` contains only lowercase English letters.

## Solution

```
from collections import Counter

# Time: O(n)
# Space: O(1)
class Solution:
    def minDeletions(self, s: str) -> int:
        freqs = [v for v in Counter(s).values()]
        freqs.sort()
        deletes = max_available_freq = 0
        for i in range(1, len(freqs)):
            curr, prev = freqs[i], freqs[i - 1]
            if curr > prev:
                if curr > prev + 1:
                    max_available_freq = curr - 1
                continue
            
            delete_curr = curr - max_available_freq
            downshift = i
            deletes += min(delete_curr, downshift)
            if downshift < delete_curr:
                for j in range(i):
                    freqs[j] = max(0, freqs[j] - 1)
            else:
                freqs[i] = max_available_freq
                max_available_freq = 0
                sorted_prefix = sorted(freqs[:i + 1])
                for j in reversed(range(i + 1)):
                    freqs[j] = sorted_prefix[j]
                    if j > 0 and freqs[j] > freqs[j - 1] + 1 and max_available_freq == 0:
                        max_available_freq = freqs[j] - 1
        
        return deletes
```

## Notes
- For any duplicate frequencies, we can either decrement all the frequencies less than the current frequency, or we can delete some `x` characters of the current frequency such that its frequency is reduced to the next lowest available frequency. Since the LCE character set limits the number of unique frequencies to `26`, the frequency counting operation in the first line of the algorithm dominates the time complexity, and makes the space constant. 