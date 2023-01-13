# 338. Counting Bits - Easy

Given an integer `n`, return an array `ans` of length `n + 1` such that for each `i (0 <= i <= n)`, `ans[i]` is the number of `1`'s in the binary representation of `i`.

##### Example 1:

```
Input: n = 2
Output: [0,1,1]
Explanation:
0 --> 0
1 --> 1
2 --> 10
```

##### Example 2:

```
Input: n = 5
Output: [0,1,1,2,1,2]
Explanation:
0 --> 0
1 --> 1
2 --> 10
3 --> 11
4 --> 100
5 --> 101
```

##### Constraints:

- <code>0 <= n <= 10<sup>5</sup></code>

Follow-up: 

- It is very easy to come up with a solution with a runtime of `O(n log n)`. Can you do it in linear time `O(n)` and possibly in a single pass?
- Can you do it without using any built-in function (i.e., like `__builtin_popcount` in C++)?


## Solution 1

```
# Time: O(nlog(n))
# Space: O(1)
class Solution:
    def countBits(self, n: int) -> List[int]:
        result = []
        for i in range(n + 1):
            k, bits = i, 0
            while k:
                bits += 1
                k &= (k - 1)
            result.append(bits)
        return result
```

## Notes
- Here we shave off least significant bits until we have found all bits, for each `i` in `[0, n]`. This is better than naively scanning all 32 bits of a number but will still scan a logarithmic number of bits for numbers with a lot of bits, so we can only comfortably describe this part of the algorithm as logarithmically upper bounded in terms of runtime. 

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def countBits(self, n: int) -> List[int]:
        result = [0]
        for i in range(1, n + 1):
            rmb = i & -i 
            result.append(1 + result[i - rmb])
        return result
```

## Notes
- One can notice that for a given number, it will always be greater than the same number `x` but without the rightmost bit of the original number. If we calculate bit counts from `0` to `n`, `x` will always have been previously calculated, and so we can use dynamic programming.