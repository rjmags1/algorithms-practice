# 352. Data Stream as Disjoint Intervals - Hard

Given a data stream input of non-negative integers `a1, a2, ..., an`, summarize the numbers seen so far as a list of disjoint intervals.

Implement the `SummaryRanges` class:

- `SummaryRanges()` Initializes the object with an empty stream.
- `void addNum(int value)` Adds the integer `value` to the stream.
- `int[][] getIntervals()` Returns a summary of the integers in the stream currently as a list of disjoint intervals `[starti, endi]`. The answer should be sorted by `starti`.


##### Example 1:

```
Input
["SummaryRanges", "addNum", "getIntervals", "addNum", "getIntervals", "addNum", "getIntervals", "addNum", "getIntervals", "addNum", "getIntervals"]
[[], [1], [], [3], [], [7], [], [2], [], [6], []]
Output
[null, null, [[1, 1]], null, [[1, 1], [3, 3]], null, [[1, 1], [3, 3], [7, 7]], null, [[1, 3], [7, 7]], null, [[1, 3], [6, 7]]]

Explanation
SummaryRanges summaryRanges = new SummaryRanges();
summaryRanges.addNum(1);      // arr = [1]
summaryRanges.getIntervals(); // return [[1, 1]]
summaryRanges.addNum(3);      // arr = [1, 3]
summaryRanges.getIntervals(); // return [[1, 1], [3, 3]]
summaryRanges.addNum(7);      // arr = [1, 3, 7]
summaryRanges.getIntervals(); // return [[1, 1], [3, 3], [7, 7]]
summaryRanges.addNum(2);      // arr = [1, 2, 3, 7]
summaryRanges.getIntervals(); // return [[1, 3], [7, 7]]
summaryRanges.addNum(6);      // arr = [1, 2, 3, 6, 7]
summaryRanges.getIntervals(); // return [[1, 3], [6, 7]]
```

##### Constraints:

- <code>0 <= value <= 10<sup>4</sup></code>
- At most <code>3 * 10<sup>4</sup></code> calls will be made to `addNum` and `getIntervals`.

Follow-up: What if there are lots of merges and the number of disjoint intervals is small compared to the size of the data stream? 

## Solution

```
# Overall Space: O(r) if r is the range size
class SummaryRanges:
    RANGEMIN, RANGEMAX = 0, 10000
    def __init__(self):
        self.tree = {}
        self.roots = {}
        
    # Time: O(ack(r)) ~ O(1)
    def find(self, value):
        if self.tree[value] == value:
            return value
        self.tree[value] = self.find(self.tree[value])
        return self.tree[value]

    # Time: O(ack(r)) ~ O(1)
    def addNum(self, value: int) -> None:
        if value in self.tree:
            return
        if value - 1 in self.tree and value + 1 in self.tree:
            mergestart = self.find(value - 1)
            mergestop = self.roots[value + 1][1]
            self.roots.pop(value + 1)
            self.roots[mergestart][1] = mergestop
            self.tree[value] = mergestart
            self.tree[value + 1] = mergestart
        elif value + 1 in self.tree:
            mergestop = self.roots[value + 1][1]
            self.tree[value + 1] = value
            self.tree[value] = value
            self.roots.pop(value + 1)
            self.roots[value] = [value, mergestop]
        elif value - 1 in self.tree:
            mergestart = self.find(value - 1)
            self.tree[value] = mergestart
            self.roots[mergestart][1] = value
        else:
            self.tree[value] = value
            self.roots[value] = [value, value]

    # Time: O(klog(k)) where k == number of disjoint intervals
    def getIntervals(self) -> List[List[int]]:
        return [self.roots[r] for r in sorted(list(self.roots.keys()))]
```

## Notes
- The prompt has disjoint in the title and we are asked to detect merges between intervals as we receive values, so we should probably be considering a Union Find solution. There are four cases to consider when adding a new value to an instance of `Summary Ranges`: we have already seen the value; we have not seen the value and it does not touch any previously held ranges; we have not seen the value and it touches the end of a previously held range; we have not seen the value and it touches the start of a previously held range; we have not seen the value and it touches the start of a previously held range AND the end of a different previously held range. 
- The above solution handles all these cases by identifying values that belong to a particular interval using the smallest value in the interval as the root in a Union Find fashion; this is the `self.tree` member of `SummaryRange`. We keep track of only roots and the range of the interval they represent in `self.roots`. We can update `self.tree` and `self.roots` as we receive values based on the above cases always in constant (ackermann function) time as long as we implement path compression for `self.tree`. 
- We minimize the average runtime of `getIntervals` by sorting a list of interval starts. There will be at most `rangesize // 2` unique intervals for a particular `rangesize` and for our particular inputs going with this approach will result in much lower average runtime than naively iterating over `[0, rangesize]` and getting all roots via lookup. This strategy also minimizes the average runtime in the case asked in the follow up, mainly when there is a large input stream that results many merges.