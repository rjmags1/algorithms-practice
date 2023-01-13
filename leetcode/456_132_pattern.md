# 456. 132 Pattern - Medium

Given an array of `n` integers `nums`, a 132 pattern is a subsequence of three integers `nums[i]`, `nums[j]` and `nums[k]` such that `i < j < k` and `nums[i] < nums[k] < nums[j]`.

Return `true` if there is a 132 pattern in `nums`, otherwise, return `false`.

##### Example 1:

```
Input: nums = [1,2,3,4]
Output: false
Explanation: There is no 132 pattern in the sequence.
```

##### Example 2:

```
Input: nums = [3,1,4,2]
Output: true
Explanation: There is a 132 pattern in the sequence: [1, 4, 2].
```

##### Example 3:

```
Input: nums = [-1,3,2,0]
Output: true
Explanation: There are three 132 patterns in the sequence: [-1, 3, 2], [-1, 3, 0] and [-1, 2, 0].
```

##### Constraints:

- <code>n == nums.length</code>
- <code>1 <= n <= 2 * 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def find132pattern(self, nums: List[int]) -> bool:
        ivals, n = [nums[0]], len(nums)
        for i in range(1, n):
            ivals.append(min(ivals[-1], nums[i]))
            
        kvals = [nums[-1]]
        for j in reversed(range(1, n - 1)):
            while kvals and kvals[-1] <= ivals[j - 1]:
                kvals.pop()
            if kvals and ivals[j - 1] < nums[j] > kvals[-1] and kvals[-1] > ivals[j - 1]:
                return True
            if not kvals or nums[j] < kvals[-1]:
                kvals.append(nums[j])

        return False
```

## Notes
- To find a 132 pattern, it is always useful to know the smallest element to the left of the current position in the array to serve as the `1` in a `132` pattern at index `i`. If for any position we always know the smallest number to the left of it, we can iterate RTL using a monotonically decreasing stack to keep track of `2` values to the right of the current position `j`. This allows us to always know the smallest `2` value at some index `k` greater than the `1` value for some `j`. We want a monotonically decreasing stack because it will allow us to save larger than necessary `2` values for later as we iterate RTL; `1` values at `ivals[j - 1]` will only increase as we iterate RTL since `ivals[j] = min(nums[i] for i in range(j))`.