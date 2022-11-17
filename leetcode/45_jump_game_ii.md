# 45. Jump Game II - Medium

You are given a 0-indexed array of integers `nums` of length `n`. You are initially positioned at `nums[0]`.

Each element `nums[i]` represents the maximum length of a forward jump from index `i`. In other words, if you are at `nums[i]`, you can jump to any `nums[i + j]` where:

- `0 <= j <= nums[i]` and
- `i + j < n`

Return the minimum number of jumps to reach `nums[n - 1]`. The test cases are generated such that you can reach `nums[n - 1]`.

##### Example 1:

```
Input: nums = [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
```

##### Example 2:

```
Input: nums = [2,3,0,1,4]
Output: 2
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- `0 <= nums[i] <= 1000`

## Solution 1

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def jump(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [inf] * n
        dp[0] = 0
        for i, steps in enumerate(nums):
            if i == n - 1:
                break
            for step in range(1, min(n, steps + 1)):
                if i + step >= n:
                    break
                dp[i + step] = min(dp[i + step], dp[i] + 1)
        return dp[-1]
```

## Notes
- This dp solution times out on LC but is the most intuitive approach I have seen besides enumerating all possible routes. Recurrence relation is straightforward, we simply determine the shortest number of jumps needed to get to each index, and use answers from earlier subproblems to answer later ones.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def jump(self, nums: List[int]) -> int:
        reach, steps, jumps = 0, 1, 0
        for i in range(len(nums) - 1):
            reach = max(reach, i + nums[i])
            steps -= 1
            if steps == -1:
                return -1
            if steps == 0:
                jumps += 1
                steps = reach - i
        
        return jumps
```

## Notes
- This solution relies on the fact that we always know the furthest we can reach based on previously traversed indices. `steps` in the solution tracks how many iterations through `nums` we have left before we will have exhausted the range of our current jump. If in the current jump, we encountered an index that expanded our reach, all we need to do is lazily update `steps` based on the previously updated `reach` when `steps` reaches 0, incrementing `jumps` as well, because when `steps == 0` this means we have reached the end of the range of our current jump.

## Solution 3

```
# Time: O(n)
# Space: O(1)
class Solution:
    def jump(self, nums: List[int]) -> int:
        jumps = currJumpEnd = reach = 0
        for i in range(len(nums) - 1):
            reach = max(reach, i + nums[i])
            if i == currJumpEnd:
                jumps += 1
                currJumpEnd = reach
        
        return jumps
```

## Notes
- This solution is similar to above but is more greedy in nature than specific to this particular problem. It relies on the fact that at any position in `nums`, we would always want to jump to the index in the range `[i + 1, i + nums[i]]` that allows us to move the furthest distance on the next jump. This strategy guarantees that we will get to the indices included in the optimal path in the least amount of jumps.