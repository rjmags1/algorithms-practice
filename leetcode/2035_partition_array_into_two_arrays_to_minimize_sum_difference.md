# 2035. Partition Array Into Two Arrays to Minimize Sum Difference - Hard

You are given an integer array `nums` of `2 * n` integers. You need to partition `nums` into two arrays of length `n` to minimize the absolute difference of the sums of the arrays. To partition `nums`, put each element of `nums` into one of the two arrays.

Return the minimum possible absolute difference.

##### Example 1:

```
Input: nums = [3,9,7,3]
Output: 2
Explanation: One optimal partition is: [3,9] and [7,3].
The absolute difference between the sums of the arrays is abs((3 + 9) - (7 + 3)) = 2.
```

##### Example 2:

```
Input: nums = [-36,36]
Output: 72
Explanation: One optimal partition is: [-36] and [36].
The absolute difference between the sums of the arrays is abs((-36) - (36)) = 72.
```

##### Example 3:

```
Input: nums = [2,-1,0,4,-2,-9]
Output: 0
Explanation: One optimal partition is: [2,4,-9] and [-1,0,-2].
The absolute difference between the sums of the arrays is abs((2 + 4 + -9) - (-1 + 0 + -2)) = 0.
```

##### Constraints:

- <code>1 <= n <= 15</code>
- <code>nums.length == 2 * n</code>
- <code>-10<sup>7</sup> <= nums[i] <= 10<sup>7</sup></code>

## Solution

```
from collections import defaultdict
from itertools import combinations
from bisect import bisect_left

# Time: O(2^n * n)
# Space: O(2^n)
class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        m = len(nums)
        n = m // 2
        left, right = nums[:n], nums[n:]
        def get_comb_sums(A):
            combs = defaultdict(list)
            for comb_size in range(n + 1):
                for comb in combinations(A, comb_size):
                    combs[comb_size].append(sum(comb))
            return combs
        
        l_combs = get_comb_sums(left)
        r_combs = get_comb_sums(right)
        S = sum(nums)
        target_partition_sum = S // 2
        result = 1 << 32
        for l_comb_size in range(n + 1):
            comp_r_combs = r_combs[n - l_comb_size]
            comp_r_combs.sort()
            num_comp_r_combs = len(comp_r_combs)
            for l_comb_sum in l_combs[l_comb_size]:
                search_result_i = bisect_left(comp_r_combs, target_partition_sum - l_comb_sum)
                poss_1, poss_2 = search_result_i - 1, search_result_i
                if 0 <= poss_1 < num_comp_r_combs:
                    part_sum = l_comb_sum + comp_r_combs[poss_1]
                    result = min(result, abs((S - part_sum) - part_sum))
                if 0 <= poss_2 < num_comp_r_combs:
                    part_sum = l_comb_sum + comp_r_combs[poss_2]
                    result = min(result, abs((S - part_sum) - part_sum))
                if result == 0:
                    return 0
        
        return result
```

## Notes
- Very tough problem if haven't seen this technique before. This is a situation where we need to greedily consider subsets in an atypical way. If we naively consider subsets of size `n` in `nums`, we will TLE because `m choose n` is on the order of `10^9`. This technique splits `nums` such that we consider all subsets of each split half, which is on the order of `n * 2^n`. Since `n <= 15`, this is acceptable. We store the sums of each subset in the respective split halves in lists keyed by the size of the combination, which allows us to compare all subsets of size `k` in the left split half in conjunction with all subsets of size `k'` in the right split half such that `k + k' == n`. For each left split half subset sum we can use binary search to find the right split half subset sum that minimizes the absolute partition difference if the two subsets are considered together as a partition of `nums`. Technique is called 'meet in the middle'.