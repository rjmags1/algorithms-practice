# 4. Median of Two Sorted Arrays - Hard

Given two sorted arrays `nums1` and `nums2` of size `m` and `n` respectively, return the median of the two sorted arrays.

The overall run time complexity should be `O(log(m+n))`.

##### Example 1:

```
Input: nums1 = [1,3], nums2 = [2]
Output: 2.00000
Explanation: merged array = [1,2,3] and median is 2.
```

##### Example 2:

```
Input: nums1 = [1,2], nums2 = [3,4]
Output: 2.50000
Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
```

##### Constraints:

- `nums1.length == m`
- `nums2.length == n`
- `0 <= m <= 1000`
- `0 <= n <= 1000` 
- `1 <= m + n <= 2000`
- <code>-10<sup>6</sup> <= nums1[i], nums2[i] <= 10<sup>6</sup></code>

## Solution - Python

```
# Time: O(log(min(m, n)))
# Space: O(1)
class Solution:
    def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:
        if len(nums1) >= len(nums2):
            long, short = nums1, nums2
        else:
            long, short = nums2, nums1
        m, n = len(long), len(short)
        
        elems = m + n
        i, j = -1, n - 1 
        smallBucketSize = elems // 2
        while i <= j:
            l1 = (i + j) // 2
            l2 = smallBucketSize - (l1 + 1) - 1
            r1, r2 = l1 + 1, l2 + 1
            left1 = short[l1] if 0 <= l1 < n else -inf
            right1 = short[r1] if 0 <= r1 < n else inf
            left2 = long[l2] if 0 <= l2 < m else -inf
            right2 = long[r2] if 0 <= r2 < m else inf
            
            if left1 <= right2 and left2 <= right1:
                if elems % 2 == 1:
                    return min(right1, right2)
                return (max(left1, left2) + min(right1, right2)) / 2
            
            if left1 > right2:
                j = l1 - 1
            else:
                i = l1 + 1
```

## Notes
- The main idea behind all implementations of this problem is to use binary search to efficiently search partitions of `short` in order to find the one that splits both arrays such that we can compute their median. We know we have found the partition pair that contains the median (or medians) about one of the split points when the numbers to the left of the split points are `<=` the numbers to the right of the split points. To wrap your head around this you could think of discarding elements from the front of either array one by one based on which is smaller until half of all elements have been discarded.
- It is best to choose `short` to run binary search/partition on instead of `long` because the search space for `long` contains incorrect answers... i.e., if we partition too close to the start or end of `long` the size of the bucket containing numbers `<` the median will be too big or too small compared to the size of the bucket with numbers `>=` the median.
- The above iterative approach to this problem is annoyingly hard to implement, primarily because it is difficult to correctly partition `long` and `short` on each iteration based on a given split point. I tend to struggle with getting this part of the problem correct everytime I revisit and don't have it committed to memory. 
- It is trivial to determine how to partition `long` based on how we partition `short`, __as long as we are consistent about the meaning of the indices surrounding the split points for `long` and `short`__. `l1` represents the index of the largest element in `short` that belongs to the bucket of numbers `<` the median. If `l1 == -1`, this means there are no numbers in `short` that belong to the bucket of numbers less than the median.
- See below diagram for visualization:
```
A      : [ | 2 4 6]    L : [1 3 5]
B      : [1 3 5 | ]    R : [2 4 6] ----- ❌, since 5 > 2

A      : [2 | 4 6]     L : [1 2 3]
B      : [1 3 | 5]     R : [4 5 6] ----- ✔, since 2 < 5 and 3 < 4

A      : [2 4 | 6]     L : [1 2 4]
B      : [1 | 3 5]     R : [3 5 6] ----- ❌, since 4 > 3

A      : [2 4 6 | ]    L : [2 4 6]
B      : [ | 1 3 5]    R : [1 3 5] ----- ❌, since 6 > 1
```

## Solution - C++

```
#include <algorithm>
#include <cmath>

using namespace std;

// Time: O(log(min(m, n)))
// Space: O(1)
class Solution {
public:
    double findMedianSortedArrays(vector<int>& big, vector<int>& small) {
        const int m = big.size();
        const int n = small.size();
        if (m < n) {
            return findMedianSortedArrays(small, big);
        }

        const int nums = m + n;
        if (nums == 1) {
            return big[0];
        }

        const int lteMedians = nums / 2;
        int smallRangeStart = -1;
        int smallRangeEnd = n - 1;
        int l1, r1, l2, r2;
        int* left1, * right1, * left2, * right2;
        while (smallRangeStart <= smallRangeEnd) {
            l1 = (smallRangeStart + smallRangeEnd) / 2;
            r1 = l1 + 1;
            l2 = lteMedians - (l1 + 1) - 1;
            r2 = l2 + 1;
            left1 = l1 == -1 ? nullptr : &small[l1];
            right1 = r1 == n ? nullptr : &small[r1];
            left2 = l2 == -1 ? nullptr : &big[l2];
            right2 = r2 == m ? nullptr : &big[r2];

            bool validSplitCond1 = left1 == nullptr || right2 == nullptr || *left1 <= *right2;
            bool validSplitCond2 = left2 == nullptr || right1 == nullptr || *left2 <= *right1;
            if (validSplitCond1 && validSplitCond2) {
                break;
            }
            if (!validSplitCond1) {
                smallRangeEnd = l1 - 1;
            }
            else {
                smallRangeStart = l1 + 1;
            }
        }

        double result;
        if (nums & 1) {
            if (right1 == nullptr || right2 == nullptr) {
                result = right1 == nullptr ? *right2 : *right1;
            }
            else {
                result = min(*right1, *right2);
            }
        }
        else {
            double biggestInSmallHalf, smallestInBigHalf;
            if (left1 == nullptr || left2 == nullptr) {
                biggestInSmallHalf = left1 == nullptr ? *left2 : *left1;
            }
            else {
                biggestInSmallHalf = max(*left1, *left2);
            }
            if (right1 == nullptr || right2 == nullptr) {
                smallestInBigHalf = right1 == nullptr ? *right2 : *right1;
            }
            else {
                smallestInBigHalf = min(*right1, *right2);
            }
            result = (biggestInSmallHalf + smallestInBigHalf) / 2;
        }

        return result;
    }
};
```