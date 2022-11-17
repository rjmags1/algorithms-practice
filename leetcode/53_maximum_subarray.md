# 53. Maximum Subarray - Medium

Given an integer array `nums`, find the subarray which has the largest sum and return its sum.

##### Example 1:

```
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.
```

##### Example 2:

```
Input: nums = [1]
Output: 1
```

##### Example 3:

```
Input: nums = [5,4,-1,7,8]
Output: 23
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>

Follow-up: If you have figured out the `O(n)` solution, try coding another solution using the divide and conquer approach, which is more subtle.

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        result = -inf
        curr = 0
        for num in nums:
            curr = max(num, num + curr)
            result = max(result, curr)
        return result
```

## Notes
- This is Kadane's algorithm, which I've seen be characterized as dp because we are relying on answers to previous subproblems to answer the current subproblem, but seems greedy to me since at each iteration we are making the locally optimal decision about continuing with or restarting the current subarray under consideration (whose sum is `curr`) with just the current element (`num`). 
- The main thing to keep in mind here is whenever the current subarray sum dips below the value of the current element in `nums`, we are better off ditching the previous subarray and starting a new one with the current element. Consider if we continued with the previous subarray; the sum would never be higher than if we had ditched it because of the relative decrease when added the current number versus starting fresh with the current number.

## Solution 2

```
# Time: O(n * log(n))
# Space: O(log(n))
class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        def rec(i, j):
            if j < i:
                return -inf
            
            mid = (i + j) // 2
            bestLeft = bestRight = -inf
            curr = 0
            for k in range(mid, i - 1, -1):
                curr += nums[k]
                bestLeft = max(bestLeft, curr)
            curr = 0
            for k in range(mid + 1, j + 1):
                curr += nums[k]
                bestRight = max(bestRight, curr)
            
            bestHere = max(bestLeft, bestRight, bestLeft + bestRight)
            bestSubLeft = rec(i, mid - 1)
            bestSubRight = rec(mid + 1, j)
            return max(bestHere, bestSubLeft, bestSubRight)
        
        return rec(0, len(nums) - 1)
```

## Notes
- Crafty divide and conquer solution based on the idea that for any given subarray, the max sum subarray contained within the original subarray will either contain `mid` or be on the left or right side of `mid`.