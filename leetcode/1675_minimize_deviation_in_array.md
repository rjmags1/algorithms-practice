# 1675. Minimize Deviation in Array - Hard

You are given an array `nums` of `n` positive integers.

You can perform two types of operations on any element of the array any number of times:

- If the element is even, divide it by `2`.
    - For example, if the array is `[1,2,3,4]`, then you can do this operation on the last element, and the array will be `[1,2,3,2]`.
- If the element is odd, multiply it by `2`.
    - For example, if the array is `[1,2,3,4]`, then you can do this operation on the first element, and the array will be `[2,2,3,4]`.

The deviation of the array is the maximum difference between any two elements in the array.

Return the minimum deviation the array can have after performing some number of operations.

##### Example 1:

```
Input: nums = [1,2,3,4]
Output: 1
Explanation: You can transform the array to [1,2,3,2], then to [2,2,3,2], then the deviation will be 3 - 2 = 1.
```

##### Example 2:

```
Input: nums = [4,1,5,20,3]
Output: 3
Explanation: You can transform the array after two operations to [4,2,5,5,3], then the deviation will be 5 - 2 = 3.
```

##### Example 3:

```
Input: nums = [2,10,8]
Output: 3
```

##### Constraints:

- `n == nums.length`
- <code>2 <= n <= 5 * 10<sup>4</sup></code>
- <code>1 <= nums[i] <= 10<sup>9</sup></code>

## Solution

```
import heapq

# Time: O(klog(n)) where k is number of possible heap elems
# Space: O(n)
class Solution:
    def minimumDeviation(self, nums: List[int]) -> int:
        h, currmax, currmin = [], -(2 ** 31), 2 ** 31 - 1
        for num in nums:
            h.append(-(num * 2) if num & 1 else -num)
            currmax, currmin = max(currmax, -h[-1]), min(currmin, -h[-1])
        heapq.heapify(h)
        result = currmax - currmin
        while h:
            currmax = -heapq.heappop(h)
            result = min(result, currmax - currmin)
            if currmax % 2 == 0:
                currmin = min(currmin, currmax // 2)
                heapq.heappush(h, -(currmax // 2))
            else:
                break

        return result
```

## Notes
- We are asked to find the minimum deviation between all possible numbers resulting from the initial input array elements if we apply the allowed operations to them. Well, we can simplify the problem considerably if we transform odd input array elements to their maximums by multiplying by `2` (any number multiplied by `2` is even). This leaves us with only one operation to deal with. From there we can use a heap to consider relevant cases, i.e., consider the next case where all numbers are as high as possible, and we cut the highest of those numbers in half. We continue this strategy until we can no longer cut a max in half.