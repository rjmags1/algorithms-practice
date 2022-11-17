# 77. Combinations - Medium

Given two integers `n` and `k`, return all possible combinations of `k` numbers chosen from the range `[1, n]`.

You may return the answer in any order.

##### Example 1:

```
Input: n = 4, k = 2
Output: [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
Explanation: There are 4 choose 2 = 6 total combinations.
Note that combinations are unordered, i.e., [1,2] and [2,1] are considered to be the same combination.
```

##### Example 2:

```
Input: n = 1, k = 1
Output: [[1]]
Explanation: There is 1 choose 1 = 1 total combination.
```

##### Constraints:

- `1 <= n <= 20`
- `1 <= k <= n`

## Solution

```
# Time: O(n!/((n - k)! * k!) * n) ("n choose k")
# Space: O(n!/((n - k)! * k!) * n)
class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        result, builder = [], []
        def rec(start, size):
            if size == k:
                result.append(builder[:])
                return
            
            for num in range(start, n + 1):
                builder.append(num)
                rec(num + 1, size + 1)
                builder.pop()
         
        rec(1, 0)
        return result
```

## Notes
- Very straightforward if you are familiar with the concept of combinations in math.
- If we were given an array of numbers that could potentially contain duplicate elements and wanted unique combinations we would need to implement some mechanism to avoid adding a number twice to the current combination, most likely sorting the input and then skipping over duplicates in the main loop of the recursive function.