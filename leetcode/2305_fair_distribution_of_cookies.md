# 2305. Fair Distribution of Cookes - Medium

You are given an integer array `cookies`, where `cookies[i]` denotes the number of cookies in the `ith` bag. You are also given an integer `k` that denotes the number of children to distribute all the bags of cookies to. All the cookies in the same bag must go to the same child and cannot be split up.

The unfairness of a distribution is defined as the maximum total cookies obtained by a single child in the distribution.

Return the minimum unfairness of all distributions.

##### Example 1:

```
Input: cookies = [8,15,10,20,8], k = 2
Output: 31
Explanation: One optimal distribution is [8,15,8] and [10,20]
- The 1st child receives [8,15,8] which has a total of 8 + 15 + 8 = 31 cookies.
- The 2nd child receives [10,20] which has a total of 10 + 20 = 30 cookies.
The unfairness of the distribution is max(31,30) = 31.
It can be shown that there is no distribution with an unfairness less than 31.
```

##### Example 2:

```
Input: cookies = [6,1,3,2,2,4,1,2], k = 3
Output: 7
Explanation: One optimal distribution is [6,1], [3,2,2], and [4,1,2]
- The 1st child receives [6,1] which has a total of 6 + 1 = 7 cookies.
- The 2nd child receives [3,2,2] which has a total of 3 + 2 + 2 = 7 cookies.
- The 3rd child receives [4,1,2] which has a total of 4 + 1 + 2 = 7 cookies.
The unfairness of the distribution is max(7,7,7) = 7.
It can be shown that there is no distribution with an unfairness less than 7.
```

##### Constraints:

- <code>2 <= cookies.length <= 8</code>
- <code>2 <= k <= cookies.length</code>
- <code>1 <= cookies[i] <= 10<sup>5</sup></code>

## Solution

```
# Time: O(k^n)
# Space: O(n + k)
class Solution:
    def distributeCookies(self, cookies: List[int], k: int) -> int:
        dp = [0] * k
        n = len(cookies)
        result = 2 ** 31
        def rec(i):
            nonlocal result
            if n - i < sum(int(dist == 0) for dist in dp):
                return
            if i == n:
                result = min(result, max(dp))
                return

            for j in range(k):
                dp[j] += cookies[i]
                rec(i + 1)
                dp[j] -= cookies[i]

        rec(0)
        return result
```

## Notes
- It doesn't say it in the prompt but any children ending up unfed is considered an invalid distribution, and allows us to prune the brute force search tree. Without this bit of information, the brute force approach, which seems to be the correct approach, times out (at least in python).