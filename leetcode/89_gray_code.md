# 89. Gray Code - Medium

An n-bit gray code sequence is a sequence of <code>2<sup>n</sup></code> integers where:

- Every integer is in the inclusive range <code>[0, 2<sup>n</sup> - 1]</code>,
- The first integer is `0`,
- An integer appears no more than once in the sequence,
- The binary representation of every pair of adjacent integers differs by exactly one bit, and
- The binary representation of the first and last integers differs by exactly one bit.

Given an integer `n`, return any valid n-bit gray code sequence.

##### Example 1:

```
Input: n = 2
Output: [0,1,3,2]
Explanation:
The binary representation of [0,1,3,2] is [00,01,11,10].
- 00 and 01 differ by one bit
- 01 and 11 differ by one bit
- 11 and 10 differ by one bit
- 10 and 00 differ by one bit
[0,2,3,1] is also a valid gray code sequence, whose binary representation is [00,10,11,01].
- 00 and 10 differ by one bit
- 10 and 11 differ by one bit
- 11 and 01 differ by one bit
- 01 and 00 differ by one bit
```

##### Example 2:

```
Input: n = 1
Output: [0,1]
```

##### Constraints:

- `1 <= n <= 16`

## Solution

```
# Time: O(2^n)
# Space: O(2^n)
class Solution:
    def grayCode(self, n: int) -> List[int]:
        prev = [0, 1]
        for k in range(2, n + 1):
            curr = []
            for i, num in enumerate(prev):
                if i & 1:
                    curr.append((num << 1) | 1)
                    curr.append((num << 1) | 0)
                else:
                    curr.append((num << 1) | 0)
                    curr.append((num << 1) | 1)
            prev = curr
        
        return prev
```

## Notes
- This is one of those problems where to solve in an interview you need to have seen it before or are able to __discern the pattern__ driving the optimal solution in a reasonable time frame. 
- This solution takes advantage of the fact that the `n`th gray code sequence can be derived from the `n - 1`th gray code sequence. Consider `[0, 1]` for `n = 1`. We can derive the gray code sequence for `n = 2` by iterating over the gray code sequence of `n = 1` and (for even indices) left shift the element + `| 0` + append to the next sequence (for `n = 2`), then left shift the element + `| 1` + append. Vice versa for odd indices. This allows us to generate the up-down pattern of gray code sequences with overall trend up then down, while also respecting uniqueness of integers.