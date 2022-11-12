# 167. Two Sum II - Input Array is Sorted - Medium

Given a 1-indexed array of integers `numbers` that is already sorted in non-decreasing order, find two numbers such that they add up to a specific `target` number. Let these two numbers be <code>numbers[index<sub>1</sub>]</code> and <code>numbers[index<sub>2</sub>]</code> where <code>1 <= index<sub>1</sub> < index<sub>2</sub> <= numbers.length</code>.

Return the indices of the two numbers, <code>index<sub>1</sub></code> and <code>index<sub>2</sub></code>, added by one as an integer array [<code>index<sub>1</sub></code>, <code>index<sub>2</sub></code>] of length `2`.

The tests are generated such that there is exactly one solution. You may not use the same element twice.

Your solution must use only constant extra space.

##### Example 1:

```
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
```

##### Example 2:

```
Input: numbers = [2,3,4], target = 6
Output: [1,3]
Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
```

##### Example 3:

```
Input: numbers = [-1,0], target = -1
Output: [1,2]
Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
```

##### Constraints:

- <code>2 <= numbers.length <= 3 * 10<sup>4</sup></code>
- `-1000 <= numbers[i] <= 1000`
- `numbers` is sorted in non-decreasing order.
- `-1000 <= target <= 1000`
- The tests are generated such that there is exactly one solution.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        l, r = 0, len(numbers) - 1
        while l < r:
            curr = numbers[l] + numbers[r]
            if curr == target:
                return [l + 1, r + 1]
            if curr > target:
                r -= 1
            else:
                l += 1
```

## Notes
- There are other solutions to this problem, including brute force <code>O(n<sup>2</sup>)</code> with constant space and `O(n)` time + space with hash table, but since this input is sorted we can apply the two pointer approach.
- If we start with our two pointers at either end of the array, it is guaranteed that they will both eventually point to the indices of elements that sum to `target` as long as we move `r` when the current sum is greater than `target` and `l` when it is less.