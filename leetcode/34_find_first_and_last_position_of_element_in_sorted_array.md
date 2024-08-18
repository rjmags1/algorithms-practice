# 34. Find First and Last Position of Element in Sorted Array - Medium

Given an array of integers `nums` sorted in non-decreasing order, find the starting and ending position of a given `target` value.

If `target` is not found in the array, return `[-1, -1]`.

You must write an algorithm with `O(log n)` runtime complexity.

##### Example 1:

```
Input: nums = [5,7,7,8,8,10], target = 8
Output: [3,4]
```

##### Example 2:

```
Input: nums = [5,7,7,8,8,10], target = 6
Output: [-1,-1]
```

##### Example 3:

```
Input: nums = [], target = 0
Output: [-1,-1]
```

##### Constraints:

- <code>0 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>
- `nums` is a non-decreasing array.
- <code>-10<sup>9</sup> <= target <= 10<sup>9</sup></code>

## Solution

```
# Time: O(log(n))
# Space: O(1)
LEFT, RIGHT = "LEFT", "RIGHT"
class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:
        n = len(nums)
        def findBound(bound):
            i, j = 0, n - 1
            while i <= j:
                mid = (i + j) // 2
                if nums[mid] == target:
                    if bound == LEFT:
                        if mid == 0 or nums[mid - 1] != target:
                            return mid
                        else:
                            j = mid - 1
                    else:
                        if mid == n - 1 or nums[mid + 1] != target:
                            return mid
                        else:
                            i = mid + 1
                elif target < nums[mid]:
                    j = mid - 1
                else:
                    i = mid + 1
            
            return -1
        
        lb = findBound(LEFT)
        if lb == -1:
            return [-1, -1]
        return [lb, findBound(RIGHT)]
```

## Notes
- Just binary search with a couple extra conditions that allow us to find the left and right bounds for duplicate targets.  


## Solution - C++

```
// Time: O(log(n))
// Space: O(1)
class Solution {
public:
    vector<int> searchRange(vector<int>& nums, int target) {
        vector<int> result { -1, -1 };
        result[0] = getBound(nums, target, true);
        if (result[0] == -1) {
            return result;
        }
        
        result[1] = getBound(nums, target, false);
        return result;
    }

private:
    int getBound(vector<int>& nums, int target, bool leftBound) {
        int n = nums.size();
        int i = 0;
        int j = n - 1;
        while (i <= j) {
            int k = (i + j) / 2;
            if (nums[k] == target) {
                if (leftBound) {
                    if (k == 0 || nums[k] != nums[k - 1]) {
                        return k;
                    }
                    else {
                        j = k - 1;
                    }
                }
                else {
                    if (k == n - 1 || nums[k] != nums[k + 1]) {
                        return k;
                    }
                    else {
                        i = k + 1;
                    }
                }
            }
            else if (target < nums[k]) {
                j = k - 1;
            }
            else {
                i = k + 1;
            }
        }

        return -1;
    }
};
```
