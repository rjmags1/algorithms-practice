# 55. Jump Game - Medium

You are given an integer array `nums`. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

Return `true` if you can reach the last index, or `false` otherwise.

##### Example 1:

```
Input: nums = [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
```

##### Example 2:

```
Input: nums = [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>0 <= nums[i] <= 10<sup>5</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        last, reach = len(nums) - 1, 0
        for i, dist in enumerate(nums):
            if reach < i or reach >= last:
                break
            reach = max(reach, i + dist)
        
        return reach >= last
```

## Notes
- Pretty straightforward greedy problem. At each iteration, we decide if we are able to determine a final answer based on the value of reach, and if not, we update reach if the current element allows us to get to an index greater than the current reach.