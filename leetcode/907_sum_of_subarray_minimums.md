# 907. Sum of Subarray Minimums - Medium

Given an array of integers `arr`, find the sum of `min(b)`, where `b` ranges over every (contiguous) subarray of `arr`. Since the answer may be large, return the answer modulo <code>10<sup>9</sup> + 7</code>.

##### Example 1:

```
Input: arr = [3,1,2,4]
Output: 17
Explanation: 
Subarrays are [3], [1], [2], [4], [3,1], [1,2], [2,4], [3,1,2], [1,2,4], [3,1,2,4]. 
Minimums are 3, 1, 2, 4, 1, 1, 2, 1, 1, 1.
Sum is 17.
```

##### Example 2:

```
Input: arr = [11,81,94,43,3]
Output: 444
```

##### Constraints:

- <code>1 <= arr.length <= 3 * 10<sup>4</sup></code>
- <code>1 <= arr[i] <= 3 * 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def sumSubarrayMins(self, arr: List[int]) -> int:
        MOD, stack, result, n = 10 ** 9 + 7, [], 0, len(arr)
        for i in range(n + 1):
            while stack and (i == n or arr[stack[-1]] >= arr[i]):
                k = stack.pop()
                l = -1 if not stack else stack[-1]
                result += (k - l) * (i - k) * arr[k]
            stack.append(i)
        return result % MOD
```

## Notes
- To improve upon the quadratic brute force solution, we need to notice that the crux of the question is finding a way to determine subarrays for which a particular element is the minimum. This is perfectly suited for a monotonic stack, specifically a monotonic increasing stack for this problem. In a monotonic increasing stack, whenever we encounter an element as we iterate through the input that is less than the number on the top of the stack, we know the input range for which the element on the top of the stack is the minimum. Notice how in the implementation this condition is actually less than or equal to in order to avoid double counting particular minimums.