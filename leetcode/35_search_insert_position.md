# 35. Search Insert Position - Easy

Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with `O(log n)` runtime complexity.

##### Example 1:

```
Input: nums = [1,3,5,6], target = 5
Output: 2
```

##### Example 2:

```
Input: nums = [1,3,5,6], target = 2
Output: 1
```

##### Example 3:

```
Input: nums = [1,3,5,6], target = 7
Output: 4
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>4</sup></code>
- <code>-10<sup>4</sup> <= nums.length <= 10<sup>4</sup></code>
- `nums` contains distinct values sorted in ascending order.
- <code>-10<sup>4</sup> <= target <= 10<sup>4</sup></code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        i, j = 0, len(nums) - 1
        while i <= j:
            mid = (i + j) // 2
            if nums[mid] == target:
                if mid == 0 or nums[mid - 1] != target:
                    return mid
                j = mid - 1
            elif target < nums[mid]:
                j = mid - 1
            else:
                i = mid + 1
        
        return i
```

## Notes
- Binary search, notice how targets not present in input are pointed to by `i` at the end of the while loop.


## Solution - C++

```
// Time: O(log(n))
// Space: O(1)
class Solution {
public:
    int searchInsert(vector<int>& nums, int target) {
        int n = nums.size();
        int i = 0;
        int j = n - 1;
        while (i < j) {
            int k = (i + j) / 2;
            if (nums[k] == target) {
                return k;
            }

            if (target < nums[k]) {
                j = k - 1;
            }
            else {
                i = k + 1;
            }
        }

        return i == n || nums[i] >= target ? i : i + 1;
    }
};
```
