# 386. Lexicographical Numbers - Medium

Given an integer `n`, return all the numbers in the range `[1, n]` sorted in lexicographical order.

You must write an algorithm that runs in `O(n)` time and uses `O(1)` extra space. 

##### Example 1:

```
Input: n = 13
Output: [1,10,11,12,13,2,3,4,5,6,7,8,9]
```

##### Example 2:

```
Input: n = 2
Output: [1,2]
```

##### Constraints:

- <code>1 <= n <= 5 * 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(log(n))
class Solution:
    def lexicalOrder(self, n: int) -> List[int]:
        result = []
        def rec(start, stop):
            for num in range(start, min(n, stop) + 1):
                result.append(num)
                nxt = num * 10
                if nxt <= n:
                    rec(nxt, nxt + 9)

        rec(1, 9)
        return result
```

## Notes
- Preorder traverse denary tree inherent to decimal number system. Note this solution can be optimized to constant space by avoiding stack usage; we would just keep track of the current number `x` and either multiply it by `10`, floor it by `10`, or add `1` depending on the status of the denary tree traversal. The trickiest part about getting the constant space solution right is flooring the correct number of times to simulate backtracking back up the denary tree during preorder traversal; consider `x = 499`, we would need to floor twice, whereas for `x = 29` would only need to floor once.