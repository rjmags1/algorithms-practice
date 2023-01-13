# 458. Poor Pigs - Hard

There are `buckets` buckets of liquid, where exactly one of the buckets is poisonous. To figure out which one is poisonous, you feed some number of (poor) pigs the liquid to see whether they will die or not. Unfortunately, you only have `minutesToTest` minutes to determine which bucket is poisonous.

You can feed the pigs according to these steps:

- Choose some live pigs to feed.
- For each pig, choose which buckets to feed it. The pig will consume all the chosen buckets simultaneously and will take no time. Each pig can feed from any number of buckets, and each bucket can be fed from by any number of pigs.
- Wait for `minutesToDie` minutes. You may not feed any other pigs during this time.
- After `minutesToDie` minutes have passed, any pigs that have been fed the poisonous bucket will die, and all others will survive.
- Repeat this process until you run out of time.

Given `buckets`, `minutesToDie`, and `minutesToTest`, return the minimum number of pigs needed to figure out which bucket is poisonous within the allotted time.

##### Example 1:

```
Input: buckets = 4, minutesToDie = 15, minutesToTest = 15
Output: 2
Explanation: We can determine the poisonous bucket as follows:
At time 0, feed the first pig buckets 1 and 2, and feed the second pig buckets 2 and 3.
At time 15, there are 4 possible outcomes:
- If only the first pig dies, then bucket 1 must be poisonous.
- If only the second pig dies, then bucket 3 must be poisonous.
- If both pigs die, then bucket 2 must be poisonous.
- If neither pig dies, then bucket 4 must be poisonous.
```

##### Example 2:

```
Input: buckets = 4, minutesToDie = 15, minutesToTest = 30
Output: 2
Explanation: We can determine the poisonous bucket as follows:
At time 0, feed the first pig bucket 1, and feed the second pig bucket 2.
At time 15, there are 2 possible outcomes:
- If either pig dies, then the poisonous bucket is the one it was fed.
- If neither pig dies, then feed the first pig bucket 3, and feed the second pig bucket 4.
At time 30, one of the two pigs must die, and the poisonous bucket is the one it was fed.
```

##### Constraints:

- `1 <= buckets <= 1000`
- `1 <= minutesToDie <= minutesToTest <= 100`

## Solution

```
# Time: O(log(b))
# Space: O(1)
class Solution:
    def poorPigs(self, buckets: int, minutesToDie: int, minutesToTest: int) -> int:
        pigs, rounds = 0, minutesToTest // minutesToDie
        while (rounds + 1) ** pigs < buckets:
            pigs += 1
        return pigs
```

## Notes
- This problem is all math, has to do with understanding how the number of digits `n` in a value represented in a particular base `k` determines the number of representable integers using `n` digits of base `k`. In short, the base is the number of `minutesToDie // minutesToTest` testing rounds `+ 1`, and we are trying to find the number of digits (`pigs`) we need such that we can represent `>= buckets`. But to see this, one first has to get a feeling for how we would optimally distribute buckets to pigs each round such that we can discern individual buckets as being poisonous based on the combination of results after all testing rounds, then relate back to integer based number systems, which is non-trivial if you haven't seen this kind of question before.  
- Seems simple after seeing the solution code but it took me several rounds of contemplation over a few days to understand this one. In a real interview without having seen this before you would need to derive the optimal way of feeding pigs on your own (detailed below) and then notice the resulting geometric series relating rounds and pigs to buckets is the same as the geometric series describing the number of integers `>= 0` representable with base `k` using `n` digits. Tall order.
- Let's say `rounds` is `4`, so a pig could be in `5` states after testing (no death, death in first round, ... death in fourth round). If `buckets <= 5`, we only need `1` pig, corresponding to `5` states - `0`, `1`, `2`, `3`, `4`. If `5 < buckets <= 25`, we only need `2` pigs, which encodes all states in `00 to 44` if we are using base `5` numbers. To make better sense of the case where `2` pigs are needed for `4` rounds of testing, consider the following from Stefan Pochmann: 

    - "With 2 pigs, poison killing in 15 minutes, and having 60 minutes, we can find the poison in up to 25 buckets in the following way. Arrange the buckets in a 5×5 square:
        ```
        1  2  3  4  5
        6  7  8  9 10
        11 12 13 14 15
        16 17 18 19 20
        21 22 23 24 25
        ```
        Now use one pig to find the row (make it drink from buckets 1, 2, 3, 4, 5, wait 15 minutes, make it drink from buckets 6, 7, 8, 9, 10, wait 15 minutes, etc). Use the second pig to find the column (make it drink 1, 6, 11, 16, 21, then 2, 7, 12, 17, 22, etc). Having 60 minutes and tests taking 15 minutes means we can run four tests. If the row pig dies in the third test, the poison is in the third row. If the column pig doesn't die at all, the poison is in the fifth column (this is why we can cover five rows/columns even though we can only run four tests)."

- Visualizing more dimensions (more from Stefan)

    - "With 3 pigs, we can similarly use a 5×5×5 cube instead of a 5×5 square and again use one pig to determine the coordinate of one dimension (one pig drinks layers from top to bottom, one drinks layers from left to right, one drinks layers from front to back). So 3 pigs can solve up to 125 buckets... Actually 4D is not hard to visualize. Just reuse one of our familiar spatial dimensions. Instead of trying to imagine a "5x5x5x5" 4D-cube, think of five 5x5x5 cubes in a row. And then:

        - First pig drinks the left slice of all five cubes, then the second-left slice, etc.
        - Second pig drinks the top slice of all five cubes, then the second-top slice, etc.
        - Third pig drinks the front slice of all five cubes, then the second-front slice, etc.
        - Fourth pig drinks the first of the five cubes, then the second of the five cubes, etc.

        Now the fourth pig tells you which cube has the poison, and the other three pigs tell you the coordinate in that cube.

        You can equally go to even higher dimensions: For 5D, just imagine a 2D array of 3D cubes. And so on. It does get more and more crowded, but it's imaginable, as we're just imagining things in our familiar 3D."