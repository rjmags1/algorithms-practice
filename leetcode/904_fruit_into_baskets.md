# 904. Fruit Into Baskets - Medium

You are visiting a farm that has a single row of fruit trees arranged from left to right. The trees are represented by an integer array `fruits` where `fruits[i]` is the type of fruit the `i`th tree produces.

You want to collect as much fruit as possible. However, the owner has some strict rules that you must follow:

- You only have two baskets, and each basket can only hold a single type of fruit. There is no limit on the amount of fruit each basket can hold.
- Starting from any tree of your choice, you must pick exactly one fruit from every tree (including the start tree) while moving to the right. The picked fruits must fit in one of your baskets.
- Once you reach a tree with fruit that cannot fit in your baskets, you must stop.

Given the integer array `fruits`, return the maximum number of fruits you can pick.

##### Example 1:

```
Input: fruits = [1,2,1]
Output: 3
Explanation: We can pick from all 3 trees.
```

##### Example 2:

```
Input: fruits = [0,1,2,2]
Output: 3
Explanation: We can pick from trees [1,2,2].
If we had started at the first tree, we would only pick from trees [0,1].
```

##### Example 3:

```
Input: fruits = [1,2,3,2,2]
Output: 4
Explanation: We can pick from trees [2,3,2,2].
If we had started at the first tree, we would only pick from trees [1,2].
```

##### Constraints:

- <code>1 <= fruits.length <= 10<sup>5</sup></code>
- <code>0 <= fruits[i] < fruits.length</code>

## Solution

```
from collections import defaultdict

# Time: O(n)
# Space: O(1)
class Solution:
    def totalFruit(self, fruits: List[int]) -> int:
        baskets = defaultdict(int)
        result = left = 0
        for i, f in enumerate(fruits):
            baskets[f] += 1
            while len(baskets) > 2:
                baskets[fruits[left]] -= 1
                if baskets[fruits[left]] == 0:
                    baskets.pop(fruits[left])
                left += 1
            result = max(result, i - left + 1)
        return result
```

## Notes
- This is a rephrasing of the sliding window for K elements problem. To get this working with one pass we could consider counts only instead of sliding window bounds (indices), though this is somewhat of a departure from typical sliding window thinking.