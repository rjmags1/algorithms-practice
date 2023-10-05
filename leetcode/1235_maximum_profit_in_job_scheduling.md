# 1235. Maximum Profit in Job Scheduling - Hard

We have `n` jobs, where every job is scheduled to be done from `startTime[i]` to `endTime[i]`, obtaining a profit of `profit[i]`.

You're given the `startTime`, `endTime` and `profit` arrays, return the maximum profit you can take such that there are no two jobs in the subset with overlapping time range.

If you choose a job that ends at time `X` you will be able to start another job that starts at time `X`.

##### Example 1:

```
Input: startTime = [1,2,3,3], endTime = [3,4,5,6], profit = [50,10,40,70]
Output: 120
Explanation: The subset chosen is the first and fourth job. 
Time range [1-3]+[3-6] , we get profit of 120 = 50 + 70.
```

##### Example 2:

```
Input: startTime = [1,2,3,4,6], endTime = [3,5,10,6,9], profit = [20,20,100,70,60]
Output: 150
Explanation: The subset chosen is the first, fourth and fifth job. 
Profit obtained 150 = 20 + 70 + 60.
```

##### Example 3:

```
Input: startTime = [1,1,1], endTime = [2,3,4], profit = [5,6,4]
Output: 6
```

##### Constraints:

- <code>1 <= startTime.length == endTime.length == profit.length <= 5 * 10<sup>4</sup></code>
- <code>1 <= startTime[i] < endTime[i] <= 10<sup>9</sup></code>
- <code>1 <= profit[i] <= 10<sup>4</sup></code>

## Solution

```
from bisect import bisect_right

# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
        n = len(profit)
        dp = [0] * n
        jobs = sorted(zip(endTime, startTime, profit))
        stack = []
        for i, (e, s, p) in enumerate(jobs):
            if i == 0:
                stack.append((e, i))
                dp[i] = p
                continue

            prev_e, prev_s, prev_p = jobs[i - 1]
            if prev_e <= s:
                dp[i] = p + dp[i - 1]
                stack.append((e, i))
                continue
            
            k = bisect_right(stack, s, key=lambda tup: tup[0]) - 1
            if k == -1:
                dp[i] = max(dp[i - 1], p)
            else:
                max_p_e_before_s, max_p_i_before_s = stack[k]
                dp[i] = max(dp[i - 1], p + dp[max_p_i_before_s])

            if dp[i] > dp[stack[-1][1]]:
                stack.append((e, i))
        
        return dp[-1]
```

## Notes
- Simple recurrence relation if we sort by end times - for a given `i`, the max attainable profit is either the previous max attainable profit, or `profit[i]` plus the max profit attainable before `startTime[i]`. The tricky part of the problem lies in dealing with the large upper bound on possible start and end times without TLE. We can do this by binary searching on a monotonic increasing stack of profits that are mappable to the associated end time.