# 1498. Number of Subsequences That Satisfy the Given Sum Condition - Medium

You are given an array of integers `nums` and an integer `target`.

Return the number of non-empty subsequences of `nums` such that the sum of the minimum and maximum element on it is less or equal to `target`. Since the answer may be too large, return it modulo <code>10<sup>9</sup> + 7</code>.

##### Example 1:

```
Input: nums = [3,5,6,7], target = 9
Output: 4
Explanation: There are 4 subsequences that satisfy the condition.
[3] -> Min value + max value <= target (3 + 3 <= 9)
[3,5] -> (3 + 5 <= 9)
[3,5,6] -> (3 + 6 <= 9)
[3,6] -> (3 + 6 <= 9)
```

##### Example 2:

```
Input: nums = [3,3,6,8], target = 10
Output: 6
Explanation: There are 6 subsequences that satisfy the condition. (nums can have repeated numbers).
[3] , [3] , [3,3], [3,6] , [3,6] , [3,3,6]
```

##### Example 3:

```
Input: nums = [2,3,3,4,6,7], target = 12
Output: 61
Explanation: There are 63 non-empty subsequences, two of them do not satisfy the condition ([6,7], [7]).
Number of valid subsequences (63 - 2 = 61).
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>1 <= nums[i] <= 10<sup>6</sup></code>
- <code>1 <= target <= 10<sup>6</sup></code>

## Solution

```
# Time: O(nlog(n))
# Space: O(n) timsort
class Solution:
    def numSubseq(self, nums: List[int], target: int) -> int:
        nums = sorted(nums)
        n, result = len(nums), 0
        l, r = 0, n - 1
        while l <= r:
            left, right = nums[l], nums[r]
            if left + right > target:
                r -= 1
            else:
                result += (1 << (r - l)) % 1_000_000_007
                l += 1
            result %= 1_000_000_007
        
        return result
```

## Notes
- This is a tricky problem because we need to sort to avoid TLE, but with subsequence problems usually preserving the order of the input is necessary. This problem is an exception, because all that matters for considering a particular subsequence is the maximum and minimum elements in it - we can ignore order due to the unique constraints of this prompt. If we sort we can use a two pointer approach to look for `l`, `r` pairs whose element sum is less than or equal to `target`. All elements in these ranges form subsequences whose max and min sum to some value `<= target`, and we can use simple math to determine the number of such subsequences for a given range.