# 31. Next Permutation - Medium

A permutation of an array of integers is an arrangement of its members into a sequence or linear order.

- For example, for `arr = [1,2,3]`, the following are all the permutations of `arr: [1,2,3], [1,3,2], [2, 1, 3], [2, 3, 1], [3,1,2], [3,2,1]`.

The next permutation of an array of integers is the next lexicographically greater permutation of its integer. More formally, if all the permutations of the array are sorted in one container according to their lexicographical order, then the next permutation of that array is the permutation that follows it in the sorted container. If such arrangement is not possible, the array must be rearranged as the lowest possible order (i.e., sorted in ascending order).

- For example, the next permutation of `arr = [1,2,3]` is `[1,3,2]`.
- Similarly, the next permutation of `arr = [2,3,1]` is `[3,1,2]`.
- While the next permutation of `arr = [3,2,1]` is `[1,2,3]` because `[3,2,1]` does not have a lexicographical larger rearrangement.

Given an array of integers `nums`, find the next permutation of `nums`.

The replacement must be in place and use only constant extra memory.

##### Example 1:

```
Input: nums = [1,2,3]
Output: [1,3,2]
```

##### Example 2:

```
Input: nums = [3,2,1]
Output: [1,2,3]
```

##### Example 3:

```
Input: nums = [1,1,5]
Output: [1,5,1]
```

##### Constraints:

- `1 <= nums.length <= 100`
- `0 <= nums[i] <= 100`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def nextPermutation(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        def reverseRange(start, stop):
            i, j = start, stop
            while i < j:
                nums[i], nums[j] = nums[j], nums[i]
                i += 1
                j -= 1
            
        n = len(nums)
        for i in range(n - 2, -1, -1):
            if nums[i] < nums[i + 1]:
                j = i + 1
                while j < n and nums[j] > nums[i]:
                    j += 1
                j -= 1
                nums[i], nums[j] = nums[j], nums[i]
                reverseRange(i + 1, n - 1)
                return
        
        reverseRange(0, n - 1)
```

## Notes
- This problem can be tricky to solve without having seen it before. But it can be done: write out all permutations for a short example in lexicographical order and try to notice a pattern.
- To implement this, you need to realize that the next greater permutation will always have the first decreasing element RTL (at index `i`) swapped with the smallest element greater than it to the right (at index `j`). After that, all we need to do is sort the numbers to the right of `i` in ascending order and we will have our answer.
- However, sorting will result in non-constant memory usage. So we need to find a way to get the elements to the right of index `i` in ascending order without simply sorting them. Recall that when we searched for `i`, we were looking for the first decreasing element RTL, so that means all of the numbers we passed while doing that search were in descending order LTR (ascending order RTL). And since the element at `j` is the smallest element greater than the element at `i`, swapping them does not disrupt the descending order LTR of elements to the right of `i`. All of that to say, to get the numbers to the right of `i` sorted in ascending order, all we need to do is `reverseRange(i + 1, n - 1)`.

## Solution - C++

```
class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        int n = nums.size();
        int k;
        for (k = n - 2; k >= 0; k--) {
            if (nums[k] < nums[k + 1]) break;
        }
        if (k == -1) {
            reverse(nums.begin(), nums.end());
            return;
        }
        int j;
        for (j = n - 1; j > k; j--) {
            if (nums[j] > nums[k]) break;
        }
        swap(nums[k], nums[j]);
        reverse(nums.begin() + k + 1, nums.end());
    }
};
```
