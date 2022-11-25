# 228. Summary Ranges - Easy

You are given a sorted unique integer array `nums`.

A range `[a,b]` is the set of all integers from `a` to `b` (inclusive).

Return the smallest sorted list of ranges that cover all the numbers in the array exactly. That is, each element of `nums` is covered by exactly one of the ranges, and there is no integer `x` such that `x` is in one of the ranges but not in `nums`.

Each range `[a,b]` in the list should be output as:

- `"a->b"` if `a != b`
- `"a"` if `a == b`

##### Example 1:

```
Input: nums = [0,1,2,4,5,7]
Output: ["0->2","4->5","7"]
Explanation: The ranges are:
[0,2] --> "0->2"
[4,5] --> "4->5"
[7,7] --> "7"
```

##### Example 2:

```
Input: nums = [0,2,3,4,6,8,9]
Output: ["0","2->4","6","8->9"]
Explanation: The ranges are:
[0,0] --> "0"
[2,4] --> "2->4"
[6,6] --> "6"
[8,9] --> "8->9"
```

##### Constraints:

- <code>0 <= nums.length <= 20</code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>
- All the values of `nums` are unique.
- `nums` is sorted in ascending order.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def summaryRanges(self, nums: List[int]) -> List[str]:
        if not nums:
            return []
        def fr(start, stop):
            return str(start) if start == stop else f"{start}->{stop}"
        
        start = prev = nums[0]
        result = []
        for i in range(1, len(nums)):
            curr = nums[i]
            if curr != prev + 1:
                result.append(fr(start, prev))
                start = curr
            prev = curr
        result.append(fr(start, prev))
        return result
```

## Notes
- Fairly trivial just need to handle last range including `nums[-1]`.