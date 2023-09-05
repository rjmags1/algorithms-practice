# 739. Daily Temperatures - Medium

Given an array of integers `temperatures` represents the daily temperatures, return an array `answer` such that `answer[i]` is the number of days you have to wait after the `i`th day to get a warmer temperature. If there is no future day for which this is possible, keep `answer[i] == 0` instead.

##### Example 1:

```
Input: temperatures = [73,74,75,71,69,72,76,73]
Output: [1,1,4,2,1,1,0,0]
```

##### Example 2:

```
Input: temperatures = [30,40,50,60]
Output: [1,1,1,0]
```

##### Example 3:

```
Input: temperatures = [30,60,90]
Output: [1,1,0]
```

##### Constraints:

- <code>1 <= temperatures.length <= 10<sup>5</sup></code>
- <code>30 <= temperatures[i] <= 100</code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        # non-increasing stack
        # if not stack or stack[-1] >= curr, append
        # else while stack and stack[-1] < curr, pop and result[pop_idx] = curr_idx - pop_idx
        n = len(temperatures)
        result = [0] * n
        stack = []
        for i, temp in enumerate(temperatures):
            while stack and temperatures[stack[-1]] < temp:
                k = stack.pop()
                result[k] = i - k
            stack.append(i)
            
        return result
```

## Notes
- Monotonic stack.