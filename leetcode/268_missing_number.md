# 268. Missing Number - Easy

Given an array `nums` containing `n` distinct numbers in the range `[0, n]`, return the only number in the range that is missing from the array.

##### Example 1:

```
Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
```

##### Example 2:

```
Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
```

##### Example 3:

```
Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
```

##### Constraints:

- `n == nums.length`
- `0 <= nums[i] <= n`
- <code>1 <= n <= 10<sup>4</sup></code>
- All the numbers of `nums` are unique.

Follow-up: Could you implement a solution using only `O(1)` extra space complexity and `O(n)` runtime complexity?

## Solution 1

```
# Time: O(n) (2-pass)
# Space: O(1)
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        mask, n = 0, len(nums)
        for num in range(1, n + 1):
            mask ^= num
        for num in nums:
            mask ^= num
        return mask
```

## Notes
- Any question involving a single number or several numbers that only appear a certain number of times should make you consider using XOR.

## Solution 2:

```
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        n = len(nums)
        mid = (n // 2) + 1 if n & 1 else 0
        totalnomissing = (n + 1) * (n // 2) + mid
        return totalnomissing - sum(nums)
```

## Notes
- Can just use summation sequence to calculate the expected amount if nothing was missing in the range, and then subtract that actual sum. I.e., if we are asked to calculate the sum of numbers in the range `[0, 100]`, we could do `(0 + 100) + (1 + 99) + (2 + 98)...`. This is essentially `100 * 50 + 50`. In this solution my logic was actually `(1 + 100) + (2 + 99) + (3 + 98)...`, but the core idea is the same.