# 60. Permutation Sequence - Hard

The set `[1, 2, 3, ..., n]` contains a total of `n!` unique permutations.

By listing and labeling all of the permutations in order, we get the following sequence for `n = 3`:

1. "123"
2. "132"
3. "213"
4. "231"
5. "312"
6. "321"

Given `n` and `k`, return the <code>k<sup>th</sup></code> permutation sequence.

##### Example 1:

```
Input: n = 3, k = 3
Output: "213"
```

##### Example 2:

```
Input: n = 4, k = 9
Output: "2314"
```

##### Example 3:

```
Input: n = 3, k = 1
Output: "123"
```

##### Constraints:

- `1 <= n <= 9`
- `1 <= k <= n!`

## Solution

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        if n == 1:
            return "1"
        
        fact = [1]
        for num in range(1, n + 1):
            fact.append(num * fact[-1])
        available = [True] * (n + 1)
        available[0] = False
        
        result = [None] * n
        def buildKthPerm(n, k, i):
            if n == 2:
                first = second = None
                for num, avail in enumerate(available):
                    if avail:
                        if first is None:
                            first = num
                        else:
                            second = num
                            break
                if k == 1:
                    result[i], result[i + 1] = first, second
                else:
                    result[i], result[i + 1] = second, first
                return
                
            multiple = offset = 0
            while k > offset:
                multiple += 1
                offset = multiple * fact[n - 1]
            
            availableCounter = 0
            for num, avail in enumerate(available):
                if avail:
                    availableCounter += 1
                    if availableCounter == multiple:
                        result[i] = num
                        available[num] = False
                        break
                        
            k -= (multiple - 1) * fact[n - 1]
            
            buildKthPerm(n - 1, k, i + 1)
        
        buildKthPerm(n, k, 0)
        return "".join([str(num) for num in result])
```

## Notes
- Above takes advantage of the fact that, for a given n and k, we can determine what the next number is in the permutation we are building with simple math. I.e., for initial problem with n = 4 and k = 22, we know the first number in the result permutation is 4, since the first 18 permutations for n = 4 start with 1, 2, or 3. To determine the second number in the result permutation, we use the same logic on subproblem with n = 3 and k = k - 18 = 4, where the n available numbers for building the rest of the result are 1, 2, and 3. When we go about determining the second number, we know that first 2 permutations for n = 3 would start with the lowest available number 1, the next 2 permutations would start with the next lowest available number, 2, and so we can say for sure the second number in our result permutation is 2, since k = 4 for this subproblem. From there, we have n = 2 and k = k - 2 = 2, with available numbers 1 and 3, which is trivial.