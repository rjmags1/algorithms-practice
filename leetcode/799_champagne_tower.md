# 799. Champagne Tower - Medium

We stack glasses in a pyramid, where the first row has `1` glass, the second row has `2` glasses, and so on until the 100th row.  Each glass holds one cup of champagne.

Then, some champagne is poured into the first glass at the top.  When the topmost glass is full, any excess liquid poured will fall equally to the glass immediately to the left and right of it.  When those glasses become full, any excess champagne will fall equally to the left and right of those glasses, and so on.  (A glass at the bottom row has its excess champagne fall on the floor.)

For example, after one cup of champagne is poured, the top most glass is full.  After two cups of champagne are poured, the two glasses on the second row are half full.  After three cups of champagne are poured, those two cups become full - there are 3 full glasses total now.  After four cups of champagne are poured, the third row has the middle glass half full, and the two outside glasses are a quarter full, as pictured below.

![](../assets/799-tower.png)

Now after pouring some non-negative integer cups of champagne, return how full the `j`th glass in the `i`th row is (both `i` and `j` are 0-indexed.)

##### Example 1:

```
Input: poured = 1, query_row = 1, query_glass = 1
Output: 0.00000
Explanation: We poured 1 cup of champange to the top glass of the tower (which is indexed as (0, 0)). There will be no excess liquid so all the glasses under the top glass will remain empty.
```

##### Example 2:

```
Input: poured = 2, query_row = 1, query_glass = 1
Output: 0.50000
Explanation: We poured 2 cups of champange to the top glass of the tower (which is indexed as (0, 0)). There is one cup of excess liquid. The glass indexed as (1, 0) and the glass indexed as (1, 1) will share the excess liquid equally, and each will get half cup of champange.
```

##### Example 3:

```
Input: poured = 100000009, query_row = 33, query_glass = 17
Output: 1.00000
```

##### Constraints:

- <code>0 <= poured <= 10<sup>9</sup></code>
- <code>0 <= query_glass <= query_row < 100</code>

## Solution

```
# Time: O(1)
# Space: O(1)
class Solution:
    def champagneTower(self, poured: int, query_row: int, query_glass: int) -> float:
        if poured == 0:
            return 0
        if query_row == 0:
            return min(1, poured)

        prev = [poured]
        for row in range(1, query_row + 1):
            curr = [0] * (row + 1)
            for i, cup in enumerate(prev):
                overflow = cup - 1
                if overflow > 0:
                    split = overflow / 2
                    curr[i] += split
                    curr[i + 1] += split
            prev = curr
        
        return min(1, prev[query_glass])
```

## Notes
- Simulation, constant space because there are never more than 100 rows, with max 100 glasses in a row.