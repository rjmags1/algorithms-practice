# 42. Trapping Rain Water - Hard

Given `n` non-negative integers representing an elevation map where the width of each bar is `1`, compute how much water it can trap after raining.

##### Example 1:

```
Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6
Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
```

##### Example 2:

```
Input: height = [4,2,0,3,2,5]
Output: 9
```

##### Constraints:

- `n == height.length`
- <code>1 <= n <= 2 * 10<sup>4</sup></code>
- <code>0 <= height[i] <= 10<sup>5</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def trap(self, height: List[int]) -> int:
        n, result, stack = len(height), 0, []
        for i, h in enumerate(height):
            if i == 0 or height[i - 1] >= h:
                stack.append(i)
                continue
            
            right, rightIdx = h, i
            while stack and height[stack[-1]] <= right:
                popped = height[stack.pop()]
                if not stack:
                    break
                leftIdx = stack[-1]
                left = height[leftIdx]
                bound = min(left, right)
                dist = rightIdx - leftIdx - 1
                trapped = dist * (bound - popped)
                result += trapped
            
            stack.append(i)
            
        return result
```

## Notes
- This solution is much harder than the following but is a good demonstration of more advanced stack techniques. We put indices on the stack, and only add to the stack when `height[i] <= height[i - 1]`. This allows us to determine how much water is trapped between heights in horizontal blocks when `height[i] > height[i - 1]` by popping off the stack.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def trap(self, height: List[int]) -> int:
        leftMax = rightMax = -inf
        i, j = 0, len(height) - 1
        result = 0
        while i <= j:
            left, right = height[i], height[j]
            leftMax = max(leftMax, left)
            rightMax = max(rightMax, right)
            if leftMax < rightMax:
                result += leftMax - left
                i += 1
            else:
                result += rightMax - right
                j -= 1
                
        return result
```

## Notes
- There are many other trapping water problems similar to this, and the optimal solution tends be similar to the above because it allows us to solve in constant space. Classic dp solutions to these kinds of problems require linear space, and if solveable with a stack, that will require linear space as well.
- The key to understanding this solution is realizing that for a given height, the amount of water we can trap in it is dependent on the highest heights to the left and right of it, inclusive of the height in question. More specifically, `trapped[i] = min(leftMax, rightMax) - height[i]`. We can always know the `leftMax` and `rightMax` for a given `height[i]` if we use a two-pointer approach and iterate from the outside in.