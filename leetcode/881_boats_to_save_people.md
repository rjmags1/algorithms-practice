# 881. Boats to Save People - Medium

You are given an array `people` where `people[i]` is the weight of the `i`th person, and an infinite number of boats where each boat can carry a maximum weight of `limit`. Each boat carries at most two people at the same time, provided the sum of the weight of those people is at most `limit`.

Return the minimum number of boats to carry every given person.

##### Example 1:

```
Input: people = [1,2], limit = 3
Output: 1
Explanation: 1 boat (1, 2)
```

##### Example 2:

```
Input: people = [3,2,2,1], limit = 3
Output: 3
Explanation: 3 boats (1, 2), (2) and (3)
```

##### Example 3:

```
Input: people = [3,5,3,4], limit = 5
Output: 4
Explanation: 4 boats (3), (3), (4), (5)
```

##### Constraints:

- <code>1 <= people.length <= 5 * 10<sup>4</sup></code>
- <code>1 <= people[i] <= limit <= 3 * 10<sup>4</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n) (timsort)
class Solution:
    def numRescueBoats(self, people: List[int], limit: int) -> int:
        under_limit = [p for p in people if p < limit]
        under_limit.sort()
        n, m = len(people), len(under_limit)
        result = n - m
        l, r = 0, m - 1
        while l < r:
            weight = under_limit[l] + under_limit[r]
            result += 1
            if weight <= limit:
                l += 1
                r -= 1
            else:
                r -= 1
        result += int(l == r)

        return result
```

## Notes
- Greedy two-pointer. The minimum number of boats used will maximize the number of pairs of people assigned to single boats. We can get the maximum number of pairs of people whose combined weight is `<= limit` by assigning the next lightest person to the next heaviest person.