# 470. Implement Rand10() Using Rand7() - Medium

Given the API `rand7()` that generates a uniform random integer in the range `[1, 7]`, write a function `rand10()` that generates a uniform random integer in the range `[1, 10]`. You can only call the API `rand7()`, and you shouldn't call any other API. Please do not use a language's built-in random API.

Each test case will have one internal argument `n`, the number of times that your implemented function `rand10()` will be called while testing. Note that this is not an argument passed to `rand10()`.

##### Example 1:

```
Input: n = 1
Output: [2]
```

##### Example 2:

```
Input: n = 2
Output: [2,8]
```

##### Example 3:

```
Input: n = 3
Output: [3,8,10]
```

##### Constraints:

- <code>1 <= n <= 10<sup>5</sup></code>

Follow-up: 

- What is the expected value for the number of calls to `rand7()` function?
- Could you minimize the number of calls to `rand7()`?

## Solution

```
# Time: O(1) average, O(inf) for rand10 in worst case due to rej. sampling
# Space: O(1)
class Solution:
    def __init__(self):
        self.matrix = []
        k = 1
        for i in range(7):
            self.matrix.append([])
            for j in range(7):
                self.matrix[-1].append(k)
                k = 1 if k == 10 else k + 1

    def rand10(self):
        """
        :rtype: int
        """
        while 1:
            i, j = rand7() - 1, rand7() - 1
            if i == 6 or (i == 5 and j > 4):
                continue
            return self.matrix[i][j]
```

## Notes
- Rejection sampling from a `7x7` 2D matrix.
- The expected value of calls to `rand7` is based on recursive probability weight equation `E(calls til valid i and j) = 2 * prob(i, j in valid range) + (calls after these two invalid calls + 2) * prob(i, j not in valid range)` which equals `E(calls til valid) = 2 * (40/49) + (2 + E(calls til valid)) * (9 / 49) = 2.45`. If we wanted to minimize calls to `rand7` we could do some extra rand7 calls in each while loop iteration to take advantage of sample rejections but this barely changes the expected number of calls (decreases it by 0.15). Main thing to takeaway here is the recursive probability weight expected value equation and rejection sampling on a 2d matrix with dimensions equivalent to random range bounds.