# 525. Contiguous Array - Medium

Given a binary array `nums`, return the maximum length of a contiguous subarray with an equal number of `0` and `1`.

##### Example 1:

```
Input: nums = [0,1]
Output: 2
Explanation: [0, 1] is the longest contiguous subarray with an equal number of 0 and 1.
```

##### Example 2:

```
Input: nums = [0,1,0]
Output: 2
Explanation: [0, 1] (or [1, 0]) is a longest contiguous subarray with equal number of 0 and 1.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- `nums[i]` is either `0` or `1`.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def findMaxLength(self, nums: List[int]) -> int:
        balance, balances = 0, {0: -1}
        result = 0
        for i, num in enumerate(nums):
            balance += 1 if num == 1 else -1
            if balance not in balances:
                balances[balance] = i
            else:
                result = max(result, i - balances[balance])
        return result
```

## Notes
- The relative amount of `0`s and `1`s in a `nums` prefix can be used to consider all large balanced subarrays, where balanced is an equal number of `0`s and `1`s. A smaller prefix ending at some index `j` with the same balance as the current prefix ending at `i` denotes a balanced subarray of length `i - j`. We only want to store the first index with a particular balance in the hash table; overwriting would lead to considering too small balanced subarrays.