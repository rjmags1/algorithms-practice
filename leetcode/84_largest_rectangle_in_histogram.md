# 84. Largest Rectangle in Histogram - Hard

Given an array of integers `heights` representing the histogram's bar height where the width of each bar is `1`, return the area of the largest rectangle in the histogram.

##### Example 1:

```
Input: heights = [2,1,5,6,2,3]
Output: 10
Explanation: The above is a histogram where width of each bar is 1.
The largest rectangle is shown in the red area, which has an area = 10 units.
```

##### Example 2:

```
Input: heights = [2,4]
Output: 4
```

##### Constraints:

- <code>1 <= heights.length <= 10<sup>5</sup></code>
- <code>0 <= heights[i] <= 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        n = len(heights)
        stack = [-1]
        heights.append(-1)
        result = 0
        for i, h in enumerate(heights):
            if i < n and (stack[-1] == -1 or h >= heights[stack[-1]]):
                stack.append(i)
                continue
            
            while stack[-1] != -1 and h < heights[stack[-1]]:
                poppedIdx = stack.pop()
                popped = heights[poppedIdx]
                d = i - stack[-1] - 1
                area = popped * d
                result = max(result, area)
            
            stack.append(i)
                
        heights.pop()
        return result
```

## Notes
- Notice that to find the largest rectangle in a histogram with a stack, we want indices on the stack to have non-descending order, because histogram rectangles have their width bounded by rectangles shorter than them, and wider histogram rectangles with shorter heights may have larger rectangles in them than the bounding ("shorter") height.
- The stack of indices allows us to always know, for any particular bar, which indices bound the rectangle containing that bar with the height of that bar. Trying to solve this by expanding out from local mins or local maxes does not work because the max histogram could be low in height but large in width such that it spans multiple peak-valley cycles. We also cannot use the same approaches for trapping water problems (two-pointer outside-in, etc.) because this is a fundamentally different problem, though it seems similar because we are dealing with a histogram input.