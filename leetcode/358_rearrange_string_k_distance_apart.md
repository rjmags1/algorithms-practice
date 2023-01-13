# 358. Rearrange String K Distance Apart - Hard

Given a string `s` and an integer `k`, rearrange `s` such that the same characters are at least distance `k` from each other. If it is not possible to rearrange the string, return an empty string `""`.

##### Example 1:

```
Input: s = "aabbcc", k = 3
Output: "abcabc"
Explanation: The same letters are at least a distance of 3 from each other.
```

##### Example 2:

```
Input: s = "aaabc", k = 3
Output: ""
Explanation: It is not possible to rearrange the string.
```

##### Example 3:

```
Input: s = "aaadbbcc", k = 2
Output: "abacabcd"
Explanation: The same letters are at least a distance of 2 from each other.
```

##### Constraints:

- <code>1 <= s.length <= 3 * 10<sup>5</sup></code>
- `s` consists of only lowercase English letters.
- `0 <= k <= s.length`

## Solution

```
from collections import Counter, deque
from heapq import heapify, heappush, heappop
from math import inf

# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def check(self, s, k):
        positions, offset = [-inf] * 26, ord('a')
        for i, c in enumerate(s):
            j = ord(c) - offset
            previdx = positions[j]
            if i - previdx < k:
                return False
            positions[j] = i
        return True

    def rearrangeString(self, s: str, k: int) -> str:
        if k == 0:
            return s

        h = [(-f, c) for c, f in Counter(s).items()]
        heapify(h)
        result, kwindow, n = [], deque([]), len(s)
        for _ in range(k):
            if not h:
                return ""
            kwindow.append(heappop(h))
        while len(result) < n:
            # add next most frequent k-away char
            f, c = kwindow.popleft()
            result.append(c)
            f += 1
            if f < 0:
                heappush(h, (f, c))
            if h:
                kwindow.append(heappop(h))

        return "".join(result) if self.check(result, k) else ""
```

## Notes
- To build the string most likely to yield a valid result, we need to always append the character with the highest amount of unused left that is at least `k` away from its previous placement in the result string. We can do this by maintaining a max heap with unused amounts as the comparison key, and a double-ended queue to enforce the `k` away property. More specifically, in each iteration of the main part of the algorithm, we pop from the heap and add that character to the result; we then add it to the `kwindow` double-ended queue such that the character only gets readded back to the heap when we are at an index in result that is `k` away from its previous placement.
- With this strategy, it is still possible that we generate invalid result strings if there is an excess of particular characters (consider the Example 2), so we run a final validation step before returning.