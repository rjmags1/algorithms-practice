# 604. Design Compressed String Iterator - Easy

Design and implement a data structure for a compressed string iterator. The given compressed string will be in the form of each letter followed by a positive integer representing the number of this letter existing in the original uncompressed string.

Implement the `StringIterator` class:

- `next()` Returns the next character if the original string still has uncompressed characters, otherwise returns a white space.
- `hasNext()` Returns `true` if there is any letter needs to be uncompressed in the original string, otherwise returns `false`.


##### Example 1:

```
Input
["StringIterator", "next", "next", "next", "next", "next", "next", "hasNext", "next", "hasNext"]
[["L1e2t1C1o1d1e1"], [], [], [], [], [], [], [], [], []]
Output
[null, "L", "e", "e", "t", "C", "o", true, "d", true]

Explanation
StringIterator stringIterator = new StringIterator("L1e2t1C1o1d1e1");
stringIterator.next(); // return "L"
stringIterator.next(); // return "e"
stringIterator.next(); // return "e"
stringIterator.next(); // return "t"
stringIterator.next(); // return "C"
stringIterator.next(); // return "o"
stringIterator.hasNext(); // return True
stringIterator.next(); // return "d"
stringIterator.hasNext(); // return True
```

##### Constraints:

- `1 <= compressedString.length <= 1000`
- `compressedString` consists of lower-case an upper-case English letters and digits.
- The number of a single character repetitions in `compressedString` is in the range <code>[1, 10^<sup>9</sup>]</code>
- At most `100` calls will be made to `next` and `hasNext`.

## Solution

```
# Overall Space: O(n)
class StringIterator:
    # Time: O(n)
    def __init__(self, compressedString: str):
        self.s = compressedString
        self.i, self.n = 1, len(self.s)
        self.c = None if self.n == 0 else self.s[0]
        self.count = 0
        self.parsecount()
    
    # Time: O(n)
    def parsecount(self):
        self.count = 0
        while self.i < self.n and self.s[self.i].isdigit():
            self.count = self.count * 10 + int(self.s[self.i])
            self.i += 1

    # Time: O(n)
    def next(self) -> str:
        if self.count == 0:
            self.c = None if self.i == self.n else self.s[self.i]
            self.i += 1
            self.parsecount()
        self.count -= 1
        return self.c if self.c else " "

    # Time: O(n)
    def hasNext(self) -> bool:
        return self.count > 0 or self.i < self.n
```

## Notes
- A little trickier than it seems at first glance because we are not guaranteed single digit repeats and characters precede repeat count in the input, but otherwise fairly straightforward.