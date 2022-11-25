# 277. Find the Celebrity - Medium

Suppose you are at a party with `n` people labeled from `0` to `n - 1` and among them, there may exist one celebrity. The definition of a celebrity is that all the other `n - 1` people know the celebrity, but the celebrity does not know any of them.

Now you want to find out who the celebrity is or verify that there is not one. The only thing you are allowed to do is ask questions like: "Hi, A. Do you know B?" to get information about whether A knows B. You need to find out the celebrity (or verify there is not one) by asking as few questions as possible (in the asymptotic sense).

You are given a helper function `bool knows(a, b)` that tells you whether A knows B. Implement a function `int findCelebrity(n)`. There will be exactly one celebrity if they are at the party.

Return the celebrity's label if there is a celebrity at the party. If there is no celebrity, return `-1`.

##### Example 1:

```
Input: graph = [[1,1,0],[0,1,0],[1,1,1]]
Output: 1
Explanation: There are three persons labeled with 0, 1 and 2. graph[i][j] = 1 means person i knows person j, otherwise graph[i][j] = 0 means person i does not know person j. The celebrity is the person labeled as 1 because both 0 and 2 know him but 1 does not know anybody.
```

##### Example 2:

```
Input: graph = [[1,0,1],[1,1,0],[0,1,1]]
Output: -1
Explanation: There is no celebrity.
```

##### Constraints:

- `n == graph.length == graph[i].length`
- `2 <= n <= 100`
- `graph[i][i] == 1`
- `graph[i][j]` is `0` or `1`.

Follow-up: If the maximum number of allowed calls to the API `knows` is `3 * n`, could you find a solution without exceeding the maximum number of calls?

## Solution 1

```
# Time: O(n^2)
# Space: O(n^2)
class Solution:
    def findCelebrity(self, n: int) -> int:
        edges = defaultdict(set)
        for person in range(n):
            for otherperson in range(n):
                if person == otherperson:
                    continue
                if knows(person, otherperson):
                    edges[person].add(otherperson)
                    
        celebs = [p for p in range(n) if len(edges[p]) == 0]
        for celeb in celebs:
            if all([celeb in edges[p] or celeb == p for p in range(n)]):
                return celeb
        return -1
```

## Notes
- This will not pass on Leetcode due to strict time restrictions, they want people to discover the optimal solution. Still, this is a reasonable approach for small `n` and reasonably speedy `knows` call times, especially if we were to introduce caching into this solution. We enumerate all edges of the graph, then for each node we check that the current node has no outgoing edges and all the other nodes have outgoing edges pointing to the current node.
- The key takeaway for this problem is caching API calls!! Having quadratic runtime for `n` upper bounded by `100` is OK.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def findCelebrity(self, n: int) -> int:
        cand, memo = 0, {}
        for person in range(1, n):
            k = knows(cand, person)
            memo[(cand, person)] = k
            if k:
                cand = person
        for person in range(n):
            if person == cand:
                continue
            if (cand, person) not in memo:
                memo[(cand, person)] = knows(cand, person)
            if (person, cand) not in memo:
                memo[(person, cand)] = knows(person, cand)
            k1, k2 = memo[(cand, person)], memo[(person, cand)]
            if k1 or not k2:
                return -1
        
        return cand
```

## Notes
- With some thought we realize that each call to `knows` allows us to eliminate `1` node as being a celebrity. For `knows(a, b)`, if `False` is returned, we know that `b` cannot be a celebrity because celebrities have incoming edges from all other nodes. If `True` is returned, we know that `a` cannot be a celebrity because celebrities have no outgoing edges. So, `n - 1` calls to `knows` will eliminate `n - 1` potential celebrities if all of our calls to `knows` have an uneliminated person as the first argument. However, the candidate after these `n - 1` calls may not be a celebrity, as would be the case for a circular graph. As a result, we should do another linear pass to determine if the candidate is actually a celebrity, which is trivial.
- Submitting even this solution (linear with caching) may sometimes not pass on leetcode, due to some combination of: my unoptimized for python python code being slow, inconsistency of leetcode submission runtimes, and leetcode forcing `know` calls to take a while to get users to think about caching API calls. However, this conceptually is the most optimal solution and will run in the `90+` percentile when we do not get unlucky on submit.