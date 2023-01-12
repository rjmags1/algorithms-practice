# 220. Contains Duplicate III - Hard

You are given an integer array `nums` and two integers `indexDiff` and `valueDiff`.

Find a pair of indices `(i, j)` such that:

- `i != j`,
- `abs(i - j) <= indexDiff`.
- `abs(nums[i] - nums[j]) <= valueDiff`, and

Return `true` if such pair exists or `false` otherwise.

##### Example 1:

```
Input: nums = [1,2,3,1], indexDiff = 3, valueDiff = 0
Output: true
Explanation: We can choose (i, j) = (0, 3).
We satisfy the three conditions:
i != j --> 0 != 3
abs(i - j) <= indexDiff --> abs(0 - 3) <= 3
abs(nums[i] - nums[j]) <= valueDiff --> abs(1 - 1) <= 0
```

##### Example 2:

```
Input: nums = [1,5,9,1,5,9], indexDiff = 2, valueDiff = 3
Output: false
Explanation: After trying all the possible pairs (i, j), we cannot satisfy the three conditions, so we return false.
```

##### Constraints:

- <code>2 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>
- <code>1 <= indexDiff <= nums.length</code>
- <code>0 <= valueDiff <= 10<sup>9</sup></code>

## Solution 1

```
# Time: O(n)
# Space: O(k)
class BucketNode:
    def __init__(self, idx, val):
        self.idx = idx
        self.val = val
        
class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], indexDiff: int, valueDiff: int) -> bool:
        bucketsize = valueDiff + 1
        def calculateRange(val):
            rangebottom = rangetop = None
            if val >= 0:
                rangebottom = (val // bucketsize) * bucketsize
                rangetop = rangebottom + bucketsize - 1
            else:
                val += 1
                rangetop = int(val / bucketsize) * bucketsize - 1
                rangebottom = rangetop - bucketsize + 1
            return (rangebottom, rangetop)
        
        buckets = defaultdict(set)
        idxdict = {}
        for i, num in enumerate(nums):
            if i - indexDiff - 1 in idxdict:
                removedbucket = idxdict[i - indexDiff - 1]
                idx, val = removedbucket.idx, removedbucket.val
                removedrange = calculateRange(val)
                buckets[removedrange].remove(removedbucket)
                idxdict.pop(i - indexDiff - 1)
                
            newbucket = BucketNode(i, num)
            idxdict[i] = newbucket
            newrange = calculateRange(num)
            buckets[newrange].add(newbucket)
            if len(buckets[newrange]) == 2:
                return True
            
            rangebottom, rangetop = newrange
            prevrange, nextrange = calculateRange(rangebottom - 1), calculateRange(rangetop + 1)
            if prevrange in buckets and len(buckets[prevrange]) == 1:
                for bucket in buckets[prevrange]:
                    if abs(bucket.val - num) <= valueDiff:
                        return True
            if nextrange in buckets and len(buckets[nextrange]) == 1:
                for bucket in buckets[nextrange]:
                    if abs(bucket.val - num) <= valueDiff:
                        return True
        
        return False
```

## Notes
- Tough bucket solution. The bucket concept is not conceptually difficult to understand, it can be tough to implement though. In particular for this problem, seeing how buckets apply is tricky, and it is also difficult to correctly assign ranges to buckets and get negative ranges correct. The idea behind this solution is to keep a set of range-buckets that contain elements in our current `k` window, where `k == indexDiff + 1`. If the range-buckets only contain elements in the range `[n*valueDiff, (n + 1)*valueDiff - 1]`, then all we need to do to check if there are elements in the current `k` window that have magnitude difference `<= valueDiff` is check the bucket the new element falls into as well as adjacent buckets when we add a new element to the `k` window. __If two elements are in the same range-bucket, it is guaranteed that their magnitude difference is `<= valueDiff`; if two elements are in adjacent range-buckets, it is possible that their magnitude difference is `<= valueDiff`. If two elements are in non-adjacent, non-identical buckets, it is impossible for their magnitude difference to be `<= valueDiff`.__
- There is also an AVL tree (self-balancing BST) solution that runs in `O(nlog(k))` time, but since python does not have a standard implementation of that I am not going to attempt to implement it myself. Java has a standard AVL tree, so that would be the language to use if an AVL tree is needed. The idea behind the AVL tree solution is that it allows us to determine the elements in the current window of size `k` that are inside the acceptable range `[num - valueDiff, num + valueDiff]`, in logarithmic time. The self-balancing property of AVL trees is what allows us to do this in logarithmic time. Could also use non-standard SortedList for python which is effectively the same as AVL Tree (TreeSet) in Java.