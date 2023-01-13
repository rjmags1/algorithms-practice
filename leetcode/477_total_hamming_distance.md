# 477. Total Hamming Distance - Medium

The Hamming distance between two integers is the number of positions at which the corresponding bits are different.

Given an integer array `nums`, return the sum of Hamming distances between all the pairs of the integers in `nums`.

##### Example 1:

```
Input: nums = [4,14,2]
Output: 6
Explanation: In binary representation, the 4 is 0100, 14 is 1110, and 2 is 0010 (just
showing the four bits relevant in this case).
The answer will be:
HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.
```

##### Example 2:

```
Input: nums = [4,14,4]
Output: 4
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>0 <= nums[i] <= 10<sup>9</sup></code>
- The answer for the given input will fit in a 32-bit integer.

## Solution

```
# Time: O(log(max(nums)) * n)
# Space: O(1)
class Solution:
    def totalHammingDistance(self, nums: List[int]) -> int:
        maxnum = max(nums)
        bit, result, n = 1, 0, len(nums)
        while bit <= maxnum:
            zeroes = 0
            for num in nums:
                if not num & bit:
                    zeroes += 1
            result += zeroes * (n - zeroes)
            bit <<= 1
            
        return result
```

## Notes
- Get the number of bit differences bitwise. For each 1-bit `<= maxnum` the number of differences at that bit is equivalent to the number of zeroes in that bit for all numbers in `nums` times the number of ones in that bit for all numbers in `nums`.