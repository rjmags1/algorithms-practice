# 1. Two Sum - Easy

Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to `target`.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

##### Example 1:

```
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
```

##### Example 2:

```
Input: nums = [3,2,4], target = 6
Output: [1,2]
```

##### Example 3:

```
Input: nums = [3,3], target = 6
Output: [0,1]
```

##### Constraints:

- <code>2 <= nums.length <= 10<sup>4</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>
- <code>-10<sup>9</sup> <= target <= 10<sup>9</sup></code>
- Only one valid answer exists.


Follow-up: Can you come up with an algorithm that is less than <code>O(n<sup>2</sup>)</code> time complexity?

## Solution 1 - Python
```
# Time: O(n)
# Space: O(n)
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        seen = {}
        for i, num in enumerate(nums):
            diff = target - num
            if diff in seen:
                return [seen[diff], i]
            seen[num] = i
```

## Notes
- Order matters because we are being asked to return indices. Otherwise, could achieve `O(n * log(n))` time, `O(1)` space with sorting and two pointer approach.
- Note how the check to see if a particular number is in `seen` occurs before the current number is added to `seen`. Otherwise we could accidentally return the same index twice if `2 * nums[i] == target`.
- It is OK to overwrite hash table entries for a particular number if there are multiple instances of it in the array because the overwrite occurs after we check for `diff` in `seen`.

## Solution 2 - C++
```
#include <vector>
#include <unordered_map>

using namespace std;

// Time: O(n)
// Space: O(n)
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> seen = { };
        vector<int> result = { };
        for (int i = 0; i < nums.size(); i++) {
            auto j = seen.find(target - nums[i]);
            if (j != seen.end()) {
                result.push_back(i);
                result.push_back(j->second);
                break;
            }
            seen[nums[i]] = i;
        }

        return result;
    }
};
```
