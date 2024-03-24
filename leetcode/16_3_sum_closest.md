# 16. 3Sum Closest - Medium

Given an integer array `nums` of length `n` and an integer `target`, find three integers in `nums` such that the sum is closest to `target`.

Return the sum of the three integers.

You may assume that each input would have exactly one solution.

##### Example 1:

```
Input: nums = [-1,2,1,-4], target = 1
Output: 2
Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
```

##### Example 2:

```
Input: nums = [0,0,0], target = 1
Output: 0
Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).
```

##### Constraints:

- `3 <= nums.length <= 500`
- `-1000 <= nums[i] <= 1000`
- <code>-10<sup>4</sup> <= target <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n^2)
# Space: O(n) or O(log(n)) due to sorting
class Solution:
    def threeSumClosest(self, nums, target):
        nums.sort()
        
        closest = None
        for i in range(len(nums) - 2):
            j, k = i + 1, len(nums) - 1
            while j < k:
                sum = nums[i] + nums[j] + nums[k]
                if closest is None or abs(target - closest) > abs(target - sum):
                    closest = sum
                    
                if closest == target:
                    return target
                elif sum > target:
                    k -= 1
                else:
                    j += 1

        return closest
```

## Notes
- We can break when we find a triplet whose sum equals `target`, because the prompt is asking us for a single answer instead of all possible answers.

## Solution - C++

```
#include <vector>
#include <algorithm>
#include <cstdlib>

// BF -> every triplet with triple for-loop
// n space, n^2 time -> sort + reduce to 2sum
class Solution {
public:
    int threeSumClosest(vector<int>& nums, int target) {
        vector<int> sorted(nums);
        sort(sorted.begin(), sorted.end());
        int n = nums.size();
        int result = sorted[0] + sorted[1] + sorted[2];
        for (int i = 0; i < n - 2; i++) {
            int j = i + 1;
            int k = n - 1;
            while (j < k) {
                int sum = sorted[i] + sorted[j] + sorted[k];
                if (abs(target - sum) < abs(target - result)) {
                    result = sum;
                }
                if (sum == target) return target;
                sum < target ? j++ : k--;
            }
        }

        return result;
    }
};
```

- Shallow copy (ok because `vector<int>`) of `&nums` to not mutate ref input, using copy constructor
