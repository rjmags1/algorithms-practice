# 300. Longest Increasing Subsequence - Medium

Given an integer array `nums`, return the length of the longest strictly increasing subsequence.

##### Example 1:

```
Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.
```

##### Example 2:

```
Input: nums = [0,1,0,3,2,3]
Output: 4
```

##### Example 3:

```
Input: nums = [7,7,7,7,7,7,7]
Output: 1
```

##### Constraints:

- `1 <= nums.length <= 2500`
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>

Follow-up: Can you come up with an algorithm that runs in `O(n log(n))` time complexity?

## Solution 1

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [1] * n
        for i in range(1, n):
            num = nums[i]
            for j in reversed(range(i)):
                prev = nums[j]
                if prev < num:
                    dp[i] = max(dp[i], 1 + dp[j])
        return max(dp)
```

## Notes
- Keep track of the largest increasing subsequence with largest number at the end of the subarray, of each subarray starting from index 0. For the next largest subarray, the largest increasing subsequence will be `1` plus the length of the largest increasing subsequence whose last value less than the last value of the next largest subarray.

## Solution 2

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        lis = [nums[0]]
        for i in range(1, len(nums)):
            num = nums[i]
            if num > lis[-1]:
                lis.append(num)
            else:
                for j, seqn in enumerate(lis):
                    if seqn >= num:
                        lis[j] = num
                        break
                        
        return len(lis)
```

## Notes
- This solution on average will perform much, much better than the dynamic programming solution because it does not do a full linear scan of `dp` for every element of `nums`; in cases where the current `num` is greater than the last number of the current `lis`, we don't scan at all in this solution. And in cases where the current `num` is `<= lis[-1]`, we only linear scan until we find the first number `>= num`.

## Solution 3

```
# Time: O(n * log(n))
# Space: O(n)
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        lis = [nums[0]]
        for i in range(1, len(nums)):
            num = nums[i]
            if num > lis[-1]:
                lis.append(num)
            else:
                l, r = 0, len(lis) - 1
                while l < r:
                    mid = (l + r) // 2
                    if lis[mid] == num:
                        l = mid
                        break
                    if lis[mid] > num:
                        r = mid
                    else:
                        l = mid + 1
                lis[l] = num
                        
        return len(lis)
```

## Notes
- Use binary search to find `lis` elements for replacement.