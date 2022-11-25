# 217. Contains Duplicate - Easy

Given an integer array `nums`, return `true` if any value appears at least twice in the array, and return `false` if every element is distinct.

##### Example 1:

```
Input: nums = [1,2,3,1]
Output: true
```

##### Example 2:

```
Input: nums = [1,2,3,4]
Output: false
```

##### Example 3:

```
Input: nums = [1,1,1,3,3,4,3,2,4,2]
Output: true
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        seen = set()
        for num in nums:
            if num in seen:
                return True
            seen.add(num)
        return False
```

## Notes
- Note there are no bit manipulation tricks to solve this question. Just use a hash table/set to record previously seen numbers, or sort and look for identical consecutives for a slight time tradeoff but improvement in memory usage.