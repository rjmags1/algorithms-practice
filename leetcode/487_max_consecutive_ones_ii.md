# 487. Max Consecutive Ones II - Medium

Given a binary array `nums`, return the maximum number of consecutive `1`'s in the array if you can flip at most one `0`.

##### Example 1:

```
Input: nums = [1,0,1,1,0]
Output: 4
Explanation: 
- If we flip the first zero, nums becomes [1,1,1,1,0] and we have 4 consecutive ones.
- If we flip the second zero, nums becomes [1,0,1,1,1] and we have 3 consecutive ones.
The max number of consecutive ones is 4.
```

##### Example 2:

```
Input: nums = [1,0,1,1,0,1]
Output: 4
Explanation: 
- If we flip the first zero, nums becomes [1,1,1,1,0,1] and we have 4 consecutive ones.
- If we flip the second zero, nums becomes [1,0,1,1,1,1] and we have 4 consecutive ones.
The max number of consecutive ones is 4.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- `nums[i]` is either `0` or `1`.

Follow-up: What if the input numbers come in one by one as an infinite stream? In other words, you can't store all numbers coming from the stream as it's too large to hold in memory. Could you solve it efficiently?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def findMaxConsecutiveOnes(self, nums: List[int]) -> int:
        l = result = 0
        zerolocs = []
        for r, num in enumerate(nums):
            if num == 0:
                zerolocs.append(r)
            if len(zerolocs) == 2:
                l = zerolocs[0] + 1
                zerolocs = zerolocs[1:]
            result = max(result, r - l + 1)
        return result
```

## Notes
- Sliding window, only care about the two most recently seen indexes of `0`s in the stream. This core idea of this solution addresses the followup, without implementing a class with method for getting the next number in the stream.