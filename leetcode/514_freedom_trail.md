# 514. Freedom Trail - Hard

In the video game Fallout 4, the quest "Road to Freedom" requires players to reach a metal dial called the "Freedom Trail Ring" and use the dial to spell a specific keyword to open the door.

Given a string `ring` that represents the code engraved on the outer ring and another string `key` that represents the keyword that needs to be spelled, return the minimum number of steps to spell all the characters in the keyword.

Initially, the first character of the ring is aligned at the `"12:00"` direction. You should spell all the characters in `key` one by one by rotating `ring` clockwise or anticlockwise to make each character of the string key aligned at the `"12:00"` direction and then by pressing the center button.

At the stage of rotating the ring to spell the key character `key[i]`:

- You can rotate the ring clockwise or anticlockwise by one place, which counts as one step. The final purpose of the rotation is to align one of `ring`'s characters at the `"12:00"` direction, where this character must equal `key[i]`.
- If the character `key[i]` has been aligned at the `"12:00"` direction, press the center button to spell, which also counts as one step. After the pressing, you could begin to spell the next character in the key (next stage). Otherwise, you have finished all the spelling.


##### Example 1:

![](../assets/514-ring.jpg)

```
Input: ring = "godding", key = "gd"
Output: 4
Explanation:
For the first key character 'g', since it is already in place, we just need 1 step to spell this character. 
For the second key character 'd', we need to rotate the ring "godding" anticlockwise by two steps to make it become "ddinggo".
Also, we need 1 more step for spelling.
So the final output is 4.
```

##### Example 2:

```
Input: ring = "godding", key = "godding"
Output: 13
```

##### Constraints:

- `1 <= ring.length, key.length <= 100`
- `ring` and `key` consist of only lower case English letters.
- It is guaranteed that `key` could always be spelled by rotating `ring`.

## Solution

```
from collections import defaultdict
from functools import cache

# Time: O(m * n^2)
# Space: O(mn)
class Solution:
    def findRotateSteps(self, ring: str, key: str) -> int:
        maxint = 2 ** 31 - 1
        idxs, m, n = defaultdict(list), len(ring), len(key)
        for i, l in enumerate(ring):
            idxs[l].append(i)

        @cache
        def rec(i, j):
            if j == n:
                return 0
            if ring[i] == key[j]:
                return 1 + rec(i, j + 1)
            
            result = maxint
            for k in idxs[key[j]]:
                left = i - k if k <= i else i + m - k
                right = k - i if i <= k else m - i + k
                result = min(result, min(left, right) + rec(k, j))
            return result
        
        return rec(0, 0)
```

## Notes
- Top-down dp. To get the letter at `"12:00"` on `ring` to equal the letter in `key` we are currently trying to match, we rotate `ring` to the right or to the left to match a location on `ring` of the `key` letter. We need to test all locations, not just the ones closest based on the current orientation of `ring`, because a longer rotation could lead to a shorter rotation in the future. Time and space complexity come from the memoization of all possible `ring` positions for a letter we need to match in `key`.