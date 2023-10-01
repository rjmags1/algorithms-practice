# 2141. Maximum Running Time of N Computers - Hard

You have `n` computers. You are given the integer `n` and a 0-indexed integer array `batteries` where the `i`th battery can run a computer for `batteries[i]` minutes. You are interested in running all `n` computers simultaneously using the given batteries.

Initially, you can insert at most one battery into each computer. After that and at any integer time moment, you can remove a battery from a computer and insert another battery any number of times. The inserted battery can be a totally new battery or a battery from another computer. You may assume that the removing and inserting processes take no time.

Note that the batteries cannot be recharged.

Return the maximum number of minutes you can run all the `n` computers simultaneously.

##### Example 1:

```
Input: n = 2, batteries = [3,3,3]
Output: 4
Explanation: 
Initially, insert battery 0 into the first computer and battery 1 into the second computer.
After two minutes, remove battery 1 from the second computer and insert battery 2 instead. Note that battery 1 can still run for one minute.
At the end of the third minute, battery 0 is drained, and you need to remove it from the first computer and insert battery 1 instead.
By the end of the fourth minute, battery 1 is also drained, and the first computer is no longer running.
We can run the two computers simultaneously for at most 4 minutes, so we return 4.
```

##### Example 2:

```
Input: n = 2, batteries = [1,1,1,1]
Output: 2
Explanation: 
Initially, insert battery 0 into the first computer and battery 2 into the second computer. 
After one minute, battery 0 and battery 2 are drained so you need to remove them and insert battery 1 into the first computer and battery 3 into the second computer. 
After another minute, battery 1 and battery 3 are also drained so the first and second computers are no longer running.
We can run the two computers simultaneously for at most 2 minutes, so we return 2.
```

##### Constraints:

- <code>1 <= n <= batteries.length <= 10<sup>5</sup></code>
- <code>1 <= batteries[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(mlog(m))
# Space: O(m)
class Solution:
    def maxRunTime(self, n: int, batteries: List[int]) -> int:
        batteries = sorted(batteries)
        m = len(batteries)
        times = batteries[m - n:]
        leftover = sum(batteries[i] for i in range(m - n))
        result = times[0]
        for i in range(1, n):
            prev, curr = times[i - 1], times[i]
            leftover_used = (curr - prev) * i
            if leftover_used > leftover:
                return result + (leftover // i)

            result += curr - prev
            leftover -= leftover_used

        return result + (leftover // n)
```

## Notes
- Whatever the actual runtime for all the computers ends up being, power left in batteries with more power than the actual runtime will go unused. If we minimize the amount of power that goes unused we will have found the maximum runtime. To minimize unused power we initially plug all computers into the `n` biggest batteries, and then use the cumulative power in the remaining small batteries to try to extend the runtime of the computers that would otherwise die first. Kind of tricky because of the way the prompt is framed, but as long as we can replace any amount of batteries in a given moment in time we can essentially treat the leftover smaller batteries as a reservoir of extra power.