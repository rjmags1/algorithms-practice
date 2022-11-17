# 135. Candy - Hard

There are `n` children standing in a line. Each child is assigned a rating value given in the integer array `ratings`.

You are giving candies to these children subjected to the following requirements:

- Each child must have at least one candy.
- Children with a higher rating get more candies than their neighbors.

Return the minimum number of candies you need to have to distribute the candies to the children.

##### Example 1:

```
Input: ratings = [1,0,2]
Output: 5
Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.
```

##### Example 2:

```
Input: ratings = [1,2,2]
Output: 4
Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
The third child gets 1 candy because it satisfies the above two conditions.
```

##### Constraints:

- `n == ratings.length`
- <code>1 <= n <= 2 * 10<sup>4</sup></code>
- <code>0 <= ratings[i] <= 2 * 10<sup>4</sup></code>

## Solution

```
# Time: O(n)
# Space: O(n)
class Solution:
    def candy(self, ratings: List[int]) -> int:
        n = len(ratings)
        dp = [1] * n
        for i in range(1, n):
            if ratings[i] > ratings[i - 1]:
                dp[i] = dp[i - 1] + 1
        
        result = dp[n - 1]
        for i in reversed(range(n - 1)):
            if ratings[i] > ratings[i + 1]:
                dp[i] = max(dp[i], dp[i + 1] + 1)
            result += dp[i]
        
        return result
```

## Notes
- If you walk through a few more interesting examples besides the ones LC gives, one will see that the distribution of awards follows a `..., 3, 2, 1, 2, 1, ...` (rising and falling) pattern. This is because for any given child, they need to have more than the people around them that have lesser ratings, and students adjacent to them may have higher ratings than the people around them (who are not the original child). More specifically, if there are more children in a rise to the left of a child with a relative peak rating such that the left neighbor of a child must get at least `4` candies, but the child to the right must get at least `2` candies, then the peak child must get `5` candies, since giving `3` that would break the higher rating -> more candy rule when comparing to children to the left. 
- The reason we don't literally expand from local peaks or valleys in this approach is that we don't need to; this is a cleaner implementation of the same idea, and will make sense if you think about this vs. the expanding from peaks/valleys approach.
- Also need to be careful to handle cases where students can have the same rating. 
- There is a one pass constant space solution that involves keeping track of the lengths of the most recent up and down rating slope lengths in order to make a determination about the rewards resulting from a "mountain", but it is a bit of a nightmare to implement and most interviewers would probably be ok with the two-pass linear space solution.