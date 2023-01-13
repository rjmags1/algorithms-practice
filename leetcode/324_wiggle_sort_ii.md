# 324. Wiggle Sort II - Medium

Given an integer array `nums`, reorder it such that `nums[0] < nums[1] > nums[2] < nums[3]....`

You may assume the input array always has a valid answer.

##### Example 1:

```
Input: nums = [1,5,1,1,6,4]
Output: [1,6,1,5,1,4]
Explanation: [1,4,1,5,1,6] is also accepted.
```

##### Example 2:

```
Input: nums = [1,3,2,2,3,1]
Output: [2,3,1,3,1,2]
```

##### Constraints:

- <code>1 <= nums.length <= 5 * 10<sup>4</sup></code>
- `0 <= nums[i] <= 5000`
- It is guaranteed that there will be an answer for the given input `nums`.

Follow-up: Can you do it in `O(n)` time and/or in-place with `O(1)` extra space?

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def wiggleSort(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        n, R = len(nums), 5000
        counts = [0] * (R + 1)
        for num in nums:
            counts[num] += 1
        x = y = z = 0
        mid = n // 2 + 1 if n & 1 else n // 2
        for num, count in enumerate(counts):
            if count == 0:
                continue
            x = num
            if z + count >= mid:
                y = mid - z
                break
            else:
                z += count
        
        k, i = x, 0
        while i < n:
            if k == x:
                for _ in range(y):
                    nums[i] = k
                    counts[k] -= 1
                    i += 2
                k -= 1
            else:
                while counts[k] == 0:
                    k -= 1
                nums[i] = k
                counts[k] -= 1
                i += 2
        k, i = R, 1
        while i < n:
            while counts[k] == 0:
                k -= 1
            nums[i] = k
            counts[k] -= 1
            i += 2
```

## Notes
- Since we have a reasonably small input range constraint, we can use 'constant' space to solve this without any esoteric tricks. Get the counts of each number in an array, determine the median, and use the median to figure out the range of values that are in the smallest half. Then order the next biggest small half number before the next biggest big half number in-place into `nums` using `counts`. This ordering is necessary to correctly handle edge cases related to equivalent adjacent elements; consider `[4, 5, 5, 6]` or `[1, 1, 2, 2, 3, 3]`.