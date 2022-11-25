# 209. Minimum Size Subarray Sum - Medium

Given an array of positive integers nums and a positive integer target, return the minimal length of a subarray whose sum is greater than or equal to target. If there is no such subarray, return 0 instead.

##### Example 1:

```
Input: target = 7, nums = [2,3,1,2,4,3]
Output: 2
Explanation: The subarray [4,3] has the minimal length under the problem constraint.
```

##### Example 2:

```
Input: target = 4, nums = [1,4,4]
Output: 1
```

##### Example 3:

```
Input: target = 11, nums = [1,1,1,1,1,1,1,1]
Output: 0
```

##### Constraints:

- <code>1 <= target <= 10<sup>9</sup></code>
- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>1 <= nums[i] <= 10<sup>4</sup></code>

Follow-up: If you have figured out the `O(n)` solution, try coding another solution of which the time complexity is `O(n log(n))`.

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minSubArrayLen(self, target: int, nums: List[int]) -> int:
        curr = l = 0
        result = inf
        for r, num in enumerate(nums):
            curr += num
            while l <= r and curr >= target:
                result = min(result, r - l + 1)
                curr -= nums[l]
                l += 1
                
        return result if result != inf else 0
```

## Notes
- Typical sliding window problem. Do not forget to handle cases where there are no subarray sums `>= target`. This approach allows us to consider all subarrays whose sum is `>= target` in linear time.

## Solution 2

```
# Time: O(n * log(n))
# Space: O(n)
class Solution:
    def minSubArrayLen(self, target: int, nums: List[int]) -> int:
        prefixsums = []
        for num in nums:
            prefixsums.append(prefixsums[-1] + num if prefixsums else num)
        
        result = inf
        for i in range(len(nums)):
            if prefixsums[i] < target:
                continue
            l, r = 0, i
            while l <= r:
                mid = (l + r) // 2
                curr = prefixsums[i] - prefixsums[mid] + nums[mid]
                if curr >= target:
                    result = min(result, i - mid + 1)
                    l = mid + 1
                else:
                    r = mid - 1
        
        return result if result is not inf else 0
```

## Notes
- The `O(nlog(n))` solution asked for in the followup involves prefix sums. For each prefix subarray, we can find the minimum sum subarray `>= target` in it in logarithmic time using binary search on the prefix sums subarray.