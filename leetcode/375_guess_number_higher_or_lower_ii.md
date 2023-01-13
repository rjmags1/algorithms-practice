# 375. Guess Number Higher or Lower II - Medium

We are playing the Guessing Game. The game will work as follows:

- I pick a number between `1` and `n`.
- You guess a number.
- If you guess the right number, you win the game.
- If you guess the wrong number, then I will tell you whether the number I picked is higher or lower, and you will continue guessing.
- Every time you guess a wrong number `x`, you will pay `x` dollars. If you run out of money, you lose the game.

Given a particular `n`, return the minimum amount of money you need to guarantee a win regardless of what number I pick.

##### Example 1:

```
Input: n = 10
Output: 16
Explanation: The winning strategy is as follows:
- The range is [1,10]. Guess 7.
    - If this is my number, your total is $0. Otherwise, you pay $7.
    - If my number is higher, the range is [8,10]. Guess 9.
        - If this is my number, your total is $7. Otherwise, you pay $9.
        - If my number is higher, it must be 10. Guess 10. Your total is $7 + $9 = $16.
        - If my number is lower, it must be 8. Guess 8. Your total is $7 + $9 = $16.
    - If my number is lower, the range is [1,6]. Guess 3.
        - If this is my number, your total is $7. Otherwise, you pay $3.
        - If my number is higher, the range is [4,6]. Guess 5.
            - If this is my number, your total is $7 + $3 = $10. Otherwise, you pay $5.
            - If my number is higher, it must be 6. Guess 6. Your total is $7 + $3 + $5 = $15.
            - If my number is lower, it must be 4. Guess 4. Your total is $7 + $3 + $5 = $15.
        - If my number is lower, the range is [1,2]. Guess 1.
            - If this is my number, your total is $7 + $3 = $10. Otherwise, you pay $1.
            - If my number is higher, it must be 2. Guess 2. Your total is $7 + $3 + $1 = $11.
The worst case in all these scenarios is that you pay $16. Hence, you only need $16 to guarantee a win.
```

##### Example 2:

```
Input: n = 1
Output: 0
Explanation: There is only one possible number, so you can guess 1 and not have to pay anything.
```

##### Example 3:

```
Input: n = 2
Output: 1
Explanation: There are two possible numbers, 1 and 2.
- Guess 1.
    - If this is my number, your total is $0. Otherwise, you pay $1.
    - If my number is higher, it must be 2. Guess 2. Your total is $1.
The worst case is that you pay $1.
```

##### Constraints:

- `1 <= n <= 200`

## Solution 1

```
from functools import cache

# Time: O(n^3)
# Space: O(n^2)
class Solution:
    def getMoneyAmount(self, n: int) -> int:
        @cache
        def rec(l, r):
            if l >= r:
                return 0

            result = math.inf
            for pick in range(l, r + 1):
                leftcost = rec(l, pick - 1)
                rightcost = rec(pick + 1, r)
                pickcost = max(leftcost, rightcost) + pick
                result = min(result, pickcost)

            return result
            
        return rec(1, n)
```

## Notes
- This is a merge intervals problem, where for a given range of potential answers, we want to determine the minimum amount of money needed to guarantee we will eventually guess the correct number. Since our partner will tell us whether an incorrect guess is too high or too low, we can say *for any particular guess in a particular interval, the lowest amount we would have to pay to guarantee a win is equal to the cost of our incorrect guess (AKA the incorrect guessed number) plus the* `max(possible cost of searching the left side of the interval, possible cost of searching the right side of the interval)`, *where the split is the incorrect guess* (we would search the left side if the split number is a too high guess and the right side of the split number is too low). For any particular interval, since we want to minimize the amount of money we guarantee to win, we want to return the minimum possible cost associated with incorrectly guessing any number in the interval.
- Notice how we just asked the same initial question (min cost of guaranteeing a win in a particular range of potential answers), but with a smaller interval. This is overlapping subproblems, so we can use dp for this. For dp general recipe is to come up with an idiomatic top-down recursive solution that translates the recurrence relation described above (italicized) into code in a straightforward manner, and then see if there is a way to optimize with a bottom-up that avoids using the call stack and/or improves runtime or memory usage.