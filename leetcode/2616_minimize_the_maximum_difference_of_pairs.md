# 2616. Minimize the Maximum Difference of Pairs - Medium

You are given a 0-indexed integer array `nums` and an integer `p`. Find `p` pairs of indices of `nums` such that the maximum difference amongst all the pairs is minimized. Also, ensure no index appears more than once amongst the `p` pairs.

Note that for a pair of elements at the index `i` and `j`, the difference of this pair is `|nums[i] - nums[j]|`, where `|x|` represents the absolute value of `x`.

Return the minimum maximum difference among all `p` pairs. We define the maximum of an empty set to be zero.

##### Example 1:

```
Input: nums = [10,1,2,7,1,3], p = 2
Output: 1
Explanation: The first pair is formed from the indices 1 and 4, and the second pair is formed from the indices 2 and 5. 
The maximum difference is max(|nums[1] - nums[4]|, |nums[2] - nums[5]|) = max(0, 1) = 1. Therefore, we return 1.
```

##### Example 2:

```
Input: nums = [4,2,1,2], p = 1
Output: 0
Explanation: Let the indices 1 and 3 form a pair. The difference of that pair is |2 - 2| = 0, which is the minimum we can attain.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>0 <= nums[i] <= 10<sup>9</sup></code>
- <code>0 <= p <= (nums.length)/2</code>

## Solution

```
# Time: O(n * log(r)) + O(n * log(n))
# Space: O(n) (timsort)
class Solution:
    def minimizeMax(self, nums: List[int], p: int) -> int:
        nums = sorted(nums)
        n = len(nums)
        def at_least_p_diffs(diff):
            i, count = 0, 0
            while count < p and i < n - 1:
                if nums[i + 1] - nums[i] <= diff:
                    count += 1
                    i += 1
                i += 1
            return count == p

        l, r = 0, nums[-1] - nums[0]
        while l < r:
            diff = (l + r) // 2
            if at_least_p_diffs(diff):
                r = diff
            else:
                l = diff + 1
        return l
```

## Notes
- Tricky if you haven't seen a lot of binary search problems. This solution performs binary search on the range of answers to find the pair difference `diff` for which there are at least `p` pairs in `nums` with a difference `<= diff`. Note the iteration pattern in the helper method.
