# 163. Missing Ranges - Easy

You are given an inclusive range `[lower, upper]` and a sorted unique integer array `nums`, where all elements are in the inclusive range.

A number `x` is considered missing if `x` is in the range `[lower, upper]` and `x` is not in `nums`.

Return the smallest sorted list of ranges that cover every missing number exactly. That is, no element of `nums` is in any of the ranges, and each missing number is in one of the ranges.

Each range `[a,b]` in the list should be output as:

- `"a->b"` if `a != b`
- `"a"` if `a == b`

##### Example 1:

```
Input: nums = [0,1,3,50,75], lower = 0, upper = 99
Output: ["2","4->49","51->74","76->99"]
Explanation: The ranges are:
[2,2] --> "2"
[4,49] --> "4->49"
[51,74] --> "51->74"
[76,99] --> "76->99"
```

##### Example 2:

```
Input: nums = [-1], lower = -1, upper = -1
Output: []
Explanation: There are no missing ranges since there are no missing numbers.
```

##### Constraints:

- <code>-10<sup>9</sup> <= lower <= upper <= 10<sup>9</sup></code>
- `0 <= nums.length <= 100`
- `lower <= nums[i] <= upper`
- All the values of `nums` are unique.

## Solution

```
# Time: O(n)
# Space: O(n) if count result, else O(1)
class Solution:
    def findMissingRanges(self, nums: List[int], lower: int, upper: int) -> List[str]:
        def formatRange(start, stop):
            if start == stop:
                return f"{start}"
            return f"{start}->{stop}"
        
        if not nums:
            return [formatRange(lower, upper)]
        
        result = []
        if nums[0] != lower:
            result.append(formatRange(lower, nums[0] - 1))
        for i in range(len(nums) - 1):
            if nums[i] + 1 != nums[i + 1]:
                result.append(formatRange(nums[i] + 1, nums[i + 1] - 1))
        if nums[-1] != upper:
            result.append(formatRange(nums[-1] + 1, upper))
            
        return result
```

## Notes
- Straightforward just consider edge cases where `lower < nums[0]`, `nums[-1] < upper`, and empty `nums`. Very useful to use template literals (f-strings in python) in a formatter helper function for this problem.