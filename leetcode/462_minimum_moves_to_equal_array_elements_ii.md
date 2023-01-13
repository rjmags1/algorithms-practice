# 462. Minimum Moes to Equal Array Elements II - Medium

Given an integer array `nums` of size `n`, return the minimum number of moves required to make all array elements equal.

In one move, you can increment or decrement an element of the array by `1`.

Test cases are designed so that the answer will fit in a 32-bit integer.

##### Example 1:

```
Input: nums = [1,2,3]
Output: 2
Explanation:
Only two moves are needed (remember each move increments or decrements one element):
[1,2,3]  =>  [2,2,3]  =>  [2,2,2]
```

##### Example 2:

```
Input: nums = [1,10,2,9]
Output: 16
```

##### Constraints:

- <code>n == nums.length</code>
- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def qs(self, nums, k):
        start, stop = 0, len(nums) - 1
        while start < stop:
            p = random.randrange(start, stop + 1)
            nums[start], nums[p] = nums[p], nums[start]
            p = start
            piv, l, r = nums[p], start + 1, stop
            while l <= r:
                if nums[l] > piv and nums[r] < piv:
                    nums[l], nums[r] = nums[r], nums[l]
                if nums[l] <= piv:
                    l += 1
                if nums[r] >= piv:
                    r -= 1
            nums[p], nums[r] = nums[r], nums[p]
            if r == k:
                return piv
            if r < k:
                start = r + 1
            else:
                stop = r - 1
        return nums[start]

    def minMoves2(self, nums: List[int]) -> int:
        median = self.qs(nums, len(nums) // 2)
        return sum(abs(num - median) for num in nums)
```

## Notes
- The optimal way to equalize all elements is to increment or decrement until all elements are equivalent to the median of the original array; if there is no median due to `n % 2 == 0`, one of the two median forming elements (ie the ones that would be averaged to obtain the median) can be used as the equalizing target. Once this is determined, we can use quickselect as above to get linear average median find followed by summing all distances from median. Sorting would also work for median finding but time complexity would degrade to `O(nlogn)`. 
- Note that LC test cases won't be passable with quickselect approach unless a random pivot element is chosen (as opposed to using the first element of the current search subarray every time for pivot, which you will see in many of my quickselect implementations for ease of implementation despite this being technically incorrect). 