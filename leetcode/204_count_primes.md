# 204. Count Primes - Medium

Given an integer `n`, return the number of prime numbers that are strictly less than `n`.

##### Example 1:

```
Input: n = 10
Output: 4
Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.
```

##### Example 2:

```
Input: n = 0
Output: 0
```

##### Example 3:

```
Input: n = 1
Output: 0
```

##### Constraints:

<code>0 <= n <= 5 * 10<sup>6</sup></code>

## Solution

```
# Time: O(sqrt(n) * log(log(n)))
# Space: O(n)
class Solution:
    def countPrimes(self, n: int) -> int:
        if n < 2:
            return 0
        prime = [True] * n
        prime[0] = prime[1] = False
        currprime = 2
        stop = int(sqrt(n)) + 1
        while currprime < stop:
            for comp in range(currprime * currprime, n, currprime):
                prime[comp] = False
            currprime += 1
            while currprime < stop and not prime[currprime]:
                currprime += 1
        
        return sum(prime)
```

## Notes
- The key to not TLE on this question is having an awareness of the nature of composite and prime numbers. Composite numbers always have at least one prime factor. So, it follows that if we rule out composite numbers based their smallest prime factors (`2, 3, ...`), we will be able to not only rule out all composite numbers `< n`, but also we will always know the next smallest prime to use for ruling out because it will be the next non-composite number after the current prime. This logic is the driving concept behind the algorithm, but will still time out if not optimized because there are still a lot of extra iterations involved.
- We can cut down on redundant/unnecessary iterations with 2 key optimizations:
    - For any given prime that we are using to rule out composite numbers with (these composite numbers will have this prime as its smallest prime factor), it is redundant to start iterating on multiples of the prime less than the prime itself. I.e., if the current prime is `5`, `2 * 5` and `3 * 5` will have been ruled out already when we previously ruled out composites whose smallest prime factors were `2` or `3`.
    - Along a similar line of thinking, it is useless to consider smallest prime factors that are greater than the square root of `n`, because by definition any composite numbers `< n` that have a prime factor greater than the square root on `n` will already have been ruled out by a smaller prime factor. For example, if `n = 75`, `2 * 37 = 74` will have been ruled out by `2`, not `37`.