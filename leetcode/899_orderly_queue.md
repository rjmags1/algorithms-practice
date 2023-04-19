# 899. Orderly Queue - Hard

You are given a string `s` and an integer `k`. You can choose one of the first `k` letters of `s` and append it at the end of the string.

Return the lexicographically smallest string you could have after applying the mentioned step any number of moves.

##### Example 1:

```
Input: s = "cba", k = 1
Output: "acb"
Explanation: 
In the first move, we move the 1st character 'c' to the end, obtaining the string "bac".
In the second move, we move the 1st character 'b' to the end, obtaining the final result "acb".
```

##### Example 2:

```
Input: s = "baaca", k = 3
Output: "aaabc"
Explanation: 
In the first move, we move the 1st character 'b' to the end, obtaining the string "aacab".
In the second move, we move the 3rd character 'c' to the end, obtaining the final result "aaabc".
```

##### Constraints:

- `1 <= k <= s.length <= 1000`
- `s` consist of lowercase English letters.

## Solution

```
# Time: O(n^2)
# Space: O(n)
class Solution:
    def orderlyQueue(self, s: str, k: int) -> str:
        n = len(s)
        if k == 1:
            return min(s[i:] + s[:i] for i in range(n))
        return "".join(sorted(s))
```

## Notes
- This question is actually deceptively simple. The title and difficulty make it seem like a complicated scenario involving a queue data structure when in fact all we need to realize to answer this question is that for `k > 1`, it is possible to achieve any permutation of the input because it is possible to swap any two letters through a series of moves in a bubble sort fashion. For `k = 1`, we simply get the rotation of the string that results in the largest lexicographical order.