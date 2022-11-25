# 251. Flatten 2D Vector - Medium

Design an iterator to flatten a 2D vector. It should support the `next` and `hasNext` operations.

Implement the `Vector2D` class:

- `Vector2D(int[][] vec)` initializes the object with the 2D vector `vec`.
- `next()` returns the next element from the 2D vector and moves the pointer one step forward. You may assume that all the calls to `next` are valid.
- `hasNext()` returns `true` if there are still some elements in the vector, and `false` otherwise.

##### Example 1:

```
Input
["Vector2D", "next", "next", "next", "hasNext", "hasNext", "next", "hasNext"]
[[[[1, 2], [3], [4]]], [], [], [], [], [], [], []]
Output
[null, 1, 2, 3, true, true, 4, false]

Explanation
Vector2D vector2D = new Vector2D([[1, 2], [3], [4]]);
vector2D.next();    // return 1
vector2D.next();    // return 2
vector2D.next();    // return 3
vector2D.hasNext(); // return True
vector2D.hasNext(); // return True
vector2D.next();    // return 4
vector2D.hasNext(); // return False
```

##### Constraints:

- `0 <= vec.length <= 200`
- `0 <= vec[i].length <= 500`
- `-500 <= vec[i][j] <= 500`
- At most <code>10<sup>5</sup></code> calls will be made to `next` and `hasNext`.

Follow-up: As an added challenge, try to code it using only iterators in C++ or iterators in Java.

## Solution

```
# Overall Space: O(mn) where m is max 1d vector length, n is len(vec)
class Vector2D:
    # Time: O(n)
    def __init__(self, vec: List[List[int]]):
        self.vec = vec
        self.n = len(self.vec)
        self.i, self.j = 0, -1
        if self.n > 0:
            self.advance()
    
    # Time: O(n)
    def advance(self):
        m = len(self.vec[self.i])
        self.j += 1
        while self.j == m and self.i < self.n:
            self.j = 0
            self.i += 1
            if self.i < self.n:
                m = len(self.vec[self.i])

    # Time: O(n)
    def next(self) -> int:
        result = self.vec[self.i][self.j]
        self.advance()
        return result

    # Time: O(1)
    def hasNext(self) -> bool:
        return self.i < self.n
```

## Notes
- Straightforward since dimensions are restricted to `2`. Watch out for edge cases where the input is an empty array, despite the question title.