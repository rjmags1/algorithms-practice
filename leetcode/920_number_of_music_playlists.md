# 920. Number of Music Playlists - Hard

Your music player contains `n` different songs. You want to listen to `goal` songs (not necessarily different) during your trip. To avoid boredom, you will create a playlist so that:

- Every song is played at least once.
- A song can only be played again only if `k` other songs have been played.

Given `n`, `goal`, and `k`, return the number of possible playlists that you can create. Since the answer can be very large, return it modulo <code>10<sup>9</sup> + 7</code>.

##### Example 1:

```
Input: n = 3, goal = 3, k = 1
Output: 6
Explanation: There are 6 possible playlists: [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], and [3, 2, 1].
```

##### Example 2:

```
Input: n = 2, goal = 3, k = 0
Output: 6
Explanation: There are 6 possible playlists: [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2, 1], [2, 1, 2], and [1, 2, 2].
```

##### Example 3:

```
Input: n = 2, goal = 3, k = 1
Output: 2
Explanation: There are 2 possible playlists: [1, 2, 1] and [2, 1, 2].
```

##### Constraints:

- `0 <= k < n <= goal <= 100`

## Solution

```
from functools import cache

# Time: O(n * goal)
# Space: O(n * goal)
class Solution:
    def numMusicPlaylists(self, n: int, goal: int, k: int) -> int:
        last_played = [-1] * n
        M = 10 ** 9 + 7
        MOD = lambda x: x % M
        
        @cache
        def rec(i, num_played):
            if i == goal:
                return int(num_played == n)
            if n - num_played > goal - i:
                return 0

            result = 0
            for song in range(n):
                if last_played[song] == -1:
                    last_played[song] = i
                    result = MOD(result + rec(i + 1, num_played + 1))
                    last_played[song] = -1
                elif i - last_played[song] > k:
                    prev = last_played[song]
                    last_played[song] = i
                    result = MOD(result + rec(i + 1, num_played))
                    last_played[song] = prev
                    
            return result
        
        return rec(0, 0)
```

## Notes
- Wording of the problem kind of confusing - I initially thought the constraint around `k` songs before the next replay meant that after `k` songs a song could be replayed consecutively, but that is incorrect based on Example 3. We can use backtracking with caching to solve this problem because for a given number of songs played `i` and a given number of distinct songs already played `num_played` the number of possible playlists generable with the given playlist prefix is the same regardless of the actual prefix contents. There is a more efficient solution based on combinatorics but this is probably ok for coding interviews. 