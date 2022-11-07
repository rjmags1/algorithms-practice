# 11. Container With Most Water - Medium

You are given an integer array height of length `n`. There are `n` vertical lines drawn such that the two endpoints of the `i`th line are `(i, 0)` and `(i, height[i])`.

Find two lines that together with the x-axis form a container, such that the container contains the most water.

Return the maximum amount of water a container can store.

Notice that you may not slant the container.

##### Example 1:

```
Input: height = [1,8,6,2,5,4,8,3,7]
Output: 49
Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
```

##### Example 2:

```
Input: height = [1,1]
Output: 1
```

##### Constraints:

- `n == height.length` 
- <code>2 <= n <= 10<sup>5</sup></code>
- <code>0 <= height[i] <= 10<sup>4</sup></code>

## Solution
```
# Time: O(n) (one-pass)
# Space: O(1)
class Solution:
    def maxArea(self, height: List[int]) -> int:
        n = len(height)
        i, j = 0, n - 1
        leftmax = rightmax = result = -inf
        while i < j:
            leftmax = max(height[i], leftmax)
            rightmax = max(height[j], rightmax)
            dist = j - i
            curr = min(leftmax, rightmax) * dist
            result = max(result, curr)
            if height[i] <= height[j]:
                i += 1
            else:
                j -= 1
        
        return result
```

## Notes
- Bottom up dp problem, where we start from the largest subrectangles formed by vertical lines and use two pointer outside in approach, moving the pointer to the smaller of the two elems. 
- In other words, to solve the problem, we use fact that we can tell the amount of water that can fit inside a given subrectangle based on `dist`, `leftmax`, and `rightmax`, and iterate outside in, greedily. 