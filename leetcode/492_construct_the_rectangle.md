# 492. Construct the Rectangle - Easy

A web developer needs to know how to design a web page's size. So, given a specific rectangular web page’s area, your job by now is to design a rectangular web page, whose length `L` and width `W` satisfy the following requirements:

- The area of the rectangular web page you designed must equal to the given target area.
- The width `W` should not be larger than the length `L`, which means `L >= W`.
- The difference between length `L` and width `W` should be as small as possible.

Return an array `[L, W]` where `L` and `W` are the length and width of the web page you designed in sequence.

##### Example 1:

```
Input: area = 4
Output: [2,2]
Explanation: The target area is 4, and all the possible ways to construct it are [1,4], [2,2], [4,1]. 
But according to requirement 2, [1,4] is illegal; according to requirement 3,  [4,1] is not optimal compared to [2,2]. So the length L is 2, and the width W is 2.
```

##### Example 2:

```
Input: area = 37
Output: [37,1]
```

##### Example 3:

```
Input: area = 122122
Output: [427,286]
```

##### Constraints:

- <code>1 <= area <= 10<sup>7</sup></code>

## Solution

```
# Time: O(sqrt(n))
# Space: O(1)
class Solution:
    def constructRectangle(self, area: int) -> List[int]:
        for W in reversed(range(1, int(math.sqrt(area)) + 1)):
            if area % W == 0:
                return [area // W, W]
```

## Notes
- For all pairs of factors whose product equals `area`, the smaller factor of each pair will be `<= sqrt(area)`. Similarly, the larger the smaller factor, the smaller the larger factor, and so we should greedily consider all possible small factors; the first one that evenly divides `area` will be the `W` in our answer. Note we could binary search for `W` to solve this problem even faster.