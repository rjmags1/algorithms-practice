# 128. Longest Consecutive Subsequence - Medium

Given an unsorted array of integers `nums`, return the length of the longest consecutive elements sequence.

You must write an algorithm that runs in `O(n)` time.

##### Example 1:

```
Input: nums = [100,4,200,1,3,2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
```

##### Example 2:

```
Input: nums = [0,3,7,2,5,8,4,6,0,1]
Output: 9
```

##### Constraints:

- <code>0 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        counted = {num: False for num in nums}
        result = 0
        for num in counted.keys():
            if counted[num]:
                continue
            
            counted[num] = True
            curr = 1
            l = num - 1 if num - 1 in counted and not counted[num - 1] else None
            r = num + 1 if num + 1 in counted and not counted[num + 1] else None
            while l is not None or r is not None:
                if l is not None:
                    curr += 1
                    counted[l] = True
                    l = l - 1 if l - 1 in counted and not counted[l - 1] else None
                if r is not None:
                    curr += 1
                    counted[r] = True
                    r = r + 1 if r + 1 in counted and not counted[r + 1] else None
            result = max(curr, result)
        
        return result
```

## Notes
- The idea here is to expand left and right as far as we can for each element to determine the longest consecutive sequence containing it, marking each element within the current sequence we are expanding as having been seen in order to not consider the same sequence twice. This is how we achieve `O(n)`.