# 330. Patching Array - Hard

Given a sorted integer array `nums` and an integer `n`, add/patch elements to the array such that any number in the range `[1, n]` inclusive can be formed by the sum of some elements in the array.

Return the minimum number of patches required.

##### Example 1:

```
Input: nums = [1,3], n = 6
Output: 1
Explanation:
Combinations of nums are [1], [3], [1,3], which form possible sums of: 1, 3, 4.
Now if we add/patch 2 to nums, the combinations are: [1], [2], [3], [1,3], [2,3], [1,2,3].
Possible sums are 1, 2, 3, 4, 5, 6, which now covers the range [1, 6].
So we only need 1 patch.
```

##### Example 2:

```
Input: nums = [1,5,10], n = 20
Output: 2
Explanation: The two patches can be [2, 4].
```

##### Example 3:

```
Input: nums = [1,2,2], n = 5
Output: 0
```

##### Constraints:

- `1 <= nums.length <= 1000`
- <code>1 <= nums[i] <= 10<sup>4</sup></code>
- `nums` is sorted in ascending order.
- <code>1 <= n <= 2<sup>31</sup> - 1</code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def minPatches(self, nums: List[int], n: int) -> int:
        i = result = 0
        need, m = 1, len(nums)
        while need <= n:
            if i < m and nums[i] <= need:
                need += nums[i]
                i += 1
            else:
                result += 1
                need += need
            
        return result
```

## Notes
- Pretty difficult math/observational skills problem that requires the observation that, for a given set of numbers, the lowest sum that we can't create with that set of numbers in the range `[1, n]` is equal to the sum of all of the numbers in the set `+ 1` if it is true that we can create all numbers in the range `[1, sum(numbers)]` using the numbers in the set.
- We go smallest to largest through `nums` and see if adding the current number will allow us to create the previous uncreateable number in the range `[1, n]` for the subarray not containing the current number. If it does, we simply update the smallest uncreateable number `need` to `need + nums[i]`. Otherwise we need to "insert" another number. Now we could "insert" a smaller number than `need` in many cases to allow us to create `need`, but since we could already form numbers in the range `[1, need)` without `need`, we will be able to maximally extend the range of createable numbers if we "insert" `need` into our number set, yielding the new createable range `[1, need + need)`. Again, since we are only required to return the minimal number of patches AKA "inserts", we don't actually insert `need` into `nums`, we just update `need` accordingly and increment the number of patches.