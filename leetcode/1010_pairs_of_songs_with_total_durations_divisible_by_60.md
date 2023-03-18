# 1010. Pairs of Songs With Total Durations Divisible by 60 - Medium

You are given a list of songs where the `i`th song has a duration of `time[i]` seconds.

Return the number of pairs of songs for which their total duration in seconds is divisible by `60`. Formally, we want the number of indices `i`, `j` such that `i < j` with `(time[i] + time[j]) % 60 == 0`.

##### Example 1:

```
Input: time = [30,20,150,100,40]
Output: 3
Explanation: Three pairs have a total duration divisible by 60:
(time[0] = 30, time[2] = 150): total duration 180
(time[1] = 20, time[3] = 100): total duration 120
(time[1] = 20, time[4] = 40): total duration 60
```

##### Example 2:

```
Input: time = [60,60,60]
Output: 3
Explanation: All three pairs have a total duration of 120, which is divisible by 60.
```

##### Constraints:

- <code>1 <= time.length <= 6 * 10<sup>4</sup></code>
- `1 <= time[i] <= 500`

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(1)
class Solution:
    def numPairsDivisibleBy60(self, time: List[int]) -> int:
        remainders = [0] * 60
        result = 0
        for t in time:
            r = t % 60
            result += remainders[(60 - r) % 60]
            remainders[r] += 1
        return result
```

## Notes
- Two numbers have a sum divisible by some `k` when they have remainders that when divided by `k` sum to `k`. For some `k`, there are `[0, k - 1]` possible remainders, so we can use an array to keep track of the frequency of each remainder as we traverse the input.