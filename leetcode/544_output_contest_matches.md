# 544. Output Contest Matches - Medium

During the NBA playoffs, we always set the rather strong team to play with the rather weak team, like make the rank `1` team play with the rank `nth` team, which is a good strategy to make the contest more interesting.

Given `n` teams, return their final contest matches in the form of a string.

The `n` teams are labeled from `1` to `n`, which represents their initial rank (i.e., Rank `1` is the strongest team and Rank `n` is the weakest team).

We will use parentheses `'('`, and `')'` and commas `','` to represent the contest team pairing. We use the parentheses for pairing and the commas for partition. During the pairing process in each round, you always need to follow the strategy of making the rather strong one pair with the rather weak one.

##### Example 1:

```
Input: n = 4
Output: "((1,4),(2,3))"
Explanation:
In the first round, we pair the team 1 and 4, the teams 2 and 3 together, as we need to make the strong team and weak team together.
And we got (1, 4),(2, 3).
In the second round, the winners of (1, 4) and (2, 3) need to play again to generate the final winner, so you need to add the paratheses outside them.
And we got the final answer ((1,4),(2,3)).
```

##### Example 2:

```
Input: n = 8
Output: "(((1,8),(4,5)),((2,7),(3,6)))"
Explanation:
First round: (1, 8),(2, 7),(3, 6),(4, 5)
Second round: ((1, 8),(4, 5)),((2, 7),(3, 6))
Third round: (((1, 8),(4, 5)),((2, 7),(3, 6)))
Since the third round will generate the final winner, you need to output the answer (((1,8),(4,5)),((2,7),(3,6))).
```

##### Constraints:

- <code>n == 2<sup>x</sup></code> where `x` in in the range `[1, 12]`.

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def findContestMatch(self, n: int) -> str:
        arr = [x for x in range(1, n + 1)]
        pops = n // 2
        while pops:
            for i in range(pops):
                arr[i] = (arr[i], arr.pop())
            pops //= 2
        return "".join(c for c in str(tuple(arr[0])) if c != " ")
```

## Notes
- To understand the time and space, note that `2n - 1` is the sum of a geometric series from `1` to `n` where series elements are double the previous element. This sequence represents the number of pop operatiors we will perform to construct the final result. If we count the result space into the space complexity, it will still be `O(n)` because the number of parentheses added is `2 * (2n - 1)`.