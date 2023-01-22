# 552. Student Attendance Record II - Hard

An attendance record for a student can be represented as a string where each character signifies whether the student was absent, late, or present on that day. The record only contains the following three characters:

- `'A'`: Absent.
- `'L'`: Late.
- `'P'`: Present.

Any student is eligible for an attendance award if they meet both of the following criteria:

- The student was absent (`'A'`) for strictly fewer than 2 days total.
- The student was never late (`'L'`) for 3 or more consecutive days.

Given an integer `n`, return the number of possible attendance records of length `n` that make a student eligible for an attendance award. The answer may be very large, so return it modulo <code>10<sup>9</sup> + 7</code>.

##### Example 1:

```
Input: n = 2
Output: 8
Explanation: There are 8 records with length 2 that are eligible for an award:
"PP", "AP", "PA", "LP", "PL", "AL", "LA", "LL"
Only "AA" is not eligible because there are 2 absences (there need to be fewer than 2).
```

##### Example 2:

```
Input: n = 1
Output: 3
```

##### Example 3:

```
Input: n = 10101
Output: 183236316
```

##### Constraints:

- <code>1 <= n <= 10<sup>5</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def checkRecord(self, n: int) -> int:
        M = 10 ** 9 + 7
        MOD = lambda x: x % M
        dp = [0] * max(4, (n + 1))
        dp[0], dp[1], dp[2], dp[3] = 1, 2, 4, 7
        for i in range(4, n + 1):
            dp[i] = MOD(2 * dp[i - 1] - dp[i - 4])
        result = dp[n]
        for i in range(1, n + 1):
            result = MOD(result + MOD(dp[i - 1] * dp[n - i]))
        return result
```

## Notes
- Another tricky dp problem, because a more naive topdown approach where for each `i` we consider the number of records composable by inserting a particular letter based on the previous two letters (checking for `LLL`) and if an `A` has occurred already will TLE because of strict test cases; the topdown recursive function would look like `dp(i, a, l)` and would result in `O(n * 2 * 3)-> O(5E5)` time and space which is normally OK for leetcode but not for problems with purposely restrictive test cases.
- To pass the test cases, an alternative dp approach is required. The above solution first determines the result if we we didn't have to consider absences. For any position in the record, we could put an `L` or a `P`; this yields the recurrence relation `dp[i] = 2 * dp[i - 1]`. But to avoid including records with `3` `L`s in a row at the end, we need to subtract `dp[i - 4]` for a final recurrence relation of `dp[i] = 2 * dp[i - 1] - dp[i - 4]`. `dp[i - 4]` represents the number of possibilites associated with `record[-3:] == "LLL"`, assuming that `record[:-3]` does not contain any `LLL`. To wrap your head around this you could picture cutting off the 8th leaf of a complete binary tree with `3` levels.
- We are still not done, because we haven't accounted for absences still. Well, we can only use `1` absence, which could be inserted into any of the `n` positions in any of the records generated from the previous step using just `L` and `P`. It follows the number of possible records from inserting an `A` at any `i`, is `dp[i - 1] * dp[n - i]`.