# 11. Container With Most Water - Medium

You are given an integer array height of length `n`. There are `n` vertical lines drawn such that the two endpoints of the `i`th line are `(i, 0)` and `(i, height[i])`.

Find two lines that together with the x-axis form a container, such that the container contains the most water.

Return the maximum amount of water a container can store.

Notice that you may not slant the container.

##### Example 1:

<img src="../assets/11_containers.jpg" />

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

## Solution - Python
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
- This is really a dp problem, that can be solved with two dp arrays that track, respectively, the largest height we have seen LTR and the largest height we have seen RTL. The constant space one-pass approach shown above is more greedy in nature and follows from the two array approach, observing that the only rectangles worth considering are the ones with the next biggest possible area and next biggest possible heights.
- In other words, to solve the problem, we use fact that we can tell the amount of water that can fit inside a given subrectangle based on `dist`, `leftmax`, and `rightmax`, and iterate outside in in a greedy fashion.

## Solution - C++
```
#include <vector>
#include <algorithm>

// Time: O(n)
// Space: O(1)
class Solution {
public:
    int maxArea(vector<int>& height) {
        int result = 0;
        int l = 0;
        int r = height.size() - 1;
        while (l < r) {
            int water = (r - l) * min(height[l], height[r]);
            result = max(result, water);
            height[l] < height[r] ? l++ : r--;
        }

        return result;
    }
};
```