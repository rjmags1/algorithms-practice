# 172. Factorial Trailing Zeroes - Medium

Given an integer `n`, return the number of trailing zeroes in `n!`.

Note that `n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1`.

##### Example 1:

```
Input: n = 3
Output: 0
Explanation: 3! = 6, no trailing zero.
```

##### Example 2:

```
Input: n = 5
Output: 1
Explanation: 5! = 120, one trailing zero.
```

##### Example 3:

```
Input: n = 0
Output: 0
```

##### Constraints:

- <code>0 <= n <= 10<sup>4</sup></code>

Follow-up: Could you write a solution that works in logarithmic time complexity?

## Solution

```
# Time: O(log(n)) (log base 5)
# Space: O(1)
class Solution:
    def trailingZeroes(self, n: int) -> int:
        curr, result = 5, 0
        while curr <= n:
            result += n // curr
            curr *= 5
        return result
```

## Notes
- The main thing to realize in this problem is we care about the number of times `10` can show up in our factorial sequence `n! = n * n - 1 * n - 1 * ... * 3 * 2 * 1` because anytime we multiply something by `10` we add a trailing zero. What are the possible ways we can see `10` show up in the factorial sequence? Well, `10` itself can present, but also a pair of factorial sequence number factors of `5` and `2` will cause a trailing `0` to show up in the result of `n!`. Actually, the latter case consumes the former, so we just need to consider all the times `5` and `2` can show up in the factorial sequence. With a little more consideration it becomes obvious that there will be at least as many but usually way more instances of factors of `2` in our factorial sequence than `5` because all even numbers have factors of `2`.
- So, in short, to find our answer we need to find the number of factors of `5` across all numbers in the factorial sequence. It seems like we could just divide `n` by `5`, but this is wrong! If numbers like `25`, `125`, `625`, etc. (powers of `5`) show up in our factorial sequence, our answer would be too low because dividing by `5` assumes that all numbers in the sequence that are multiples of `5` only have one factor of `5` in them. I.e. `40 // 5 == 8` but there are `9` trailing zeroes in `40!`. Why? Because there are `8` multiples of `5` in `[1, 40]` but one of them, `25`, has an extra factor of `5`, which causes one more trailing zero than expected to show up in our result.
- So to determine the number of times `5` shows up in a factorial sequence factored down to its least common multiples, we can consider the number of times <code>5<sup>1</sup></code> fits into `n` + the number of times <code>5<sup>2</sup></code> fits into `n`, and so on. It helps to draw out on larger example (i.e. `40!`) on paper, but you can think about it as each number in the factorial sequence having a stack on top of it with each of its `5` factors. We get all the lowest `5`s on all factorial sequence number stacks (if there is any) when we consider <code>5<sup>1</sup></code>, we get all the second lowest `5`s on all factorial sequence number stacks (if there is any) when we consider <code>5<sup>2</sup></code>, and so on.