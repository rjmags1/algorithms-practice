# 164. Maximum Gap - Hard

Given an integer array `nums`, return the maximum difference between two successive elements in its sorted form. If the array contains less than two elements, return `0`.

You must write an algorithm that runs in linear time and uses linear extra space.

##### Example 1:

```
Input: nums = [3,6,9,1]
Output: 3
Explanation: The sorted form of the array is [1,3,6,9], either (3,6) or (6,9) has the maximum difference 3.
```

##### Example 2:

```
Input: nums = [10]
Output: 0
Explanation: The array contains less than 2 elements, therefore return 0.
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>0 <= nums[i] <= 10<sup>9</sup></code>

## Solution 1

```
# Time: O(d * (r + n)) ~~> O(n)
# Space: O(n)
class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0
        
        radix, exp = 10, 0
        prev = nums[:]
        buckets = [[] for _ in range(radix)]
        while exp < 10:
            for num in prev:
                digit = (num // (radix ** exp)) % radix
                buckets[digit].append(num)
                
            curr = []
            for b in buckets:
                for val in b:
                    curr.append(val)
                    
            prev = curr
            buckets = [[] for _ in range(radix)]
            exp += 1
        
        result = 0
        for i in range(1, n):
            result = max(result, prev[i] - prev[i - 1])
        return result
```

## Notes
- Here we sort in (pseudo) linear time with radix sort and then compare consecutive elements with a basic linear scan. Radix sort works well if you are working with large inputs but there is a reasonable upper bound on the range of the elements in the input. Here we are working with a max value of <code>10<sup>9</sup></code> as our upper bound, so it makes sense to sacrifice 10 linear passes for each possible magnitude of 10 in a positive integer <code><= 10<sup>9</sup></code> to obtain a sorted version of `nums` and easily find the desired max gap.

## Solution 2

```
# Time: O(n) (4-pass)
# Space: O(n)
class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0
        
        minnum, maxnum = inf, -inf
        for num in nums:
            minnum, maxnum = min(minnum, num), max(maxnum, num)
        
        minMaxgap = (maxnum - minnum) / (n - 1)
        bucketrangesize = max(1, int(minMaxgap))
        numbuckets = (maxnum - minnum) // bucketrangesize + 1
        buckets = [[inf, -inf] for _ in range(bucketrangesize)]
        for num in nums:
            bucketIdx = (num - minnum) // bucketrangesize
            bmin, bmax = buckets[bucketIdx]
            bmin, bmax = min(bmin, num), max(bmax, num)
            buckets[bucketIdx][0], buckets[bucketIdx][1] = bmin, bmax
                    
        result = int(minMaxgap)
        prevmax = None
        for bmin, bmax in buckets:
            if bmin == inf:
                continue
            if prevmax is None:
                prevmax = bmax
                continue
            result = max(result, bmin - prevmax)
            prevmax = bmax
        
        return result
```

## Notes
- This solution follows from the idea that for a given `nums` of length `n` with elements in the range `[a, b]`, the inclusive lower bound of max gap between consecutive elements in `sorted(nums)` is `(b - a) // (n - 1)`. From here on when I say max gap I am referring to the max gap between adjacent elements if they were in their sorted position.
- Consider the array `[2, 4, 6, 8]`; there are `n - 1` gaps in this array and all the elements have the minimum possible gap between each other because they all are `2` greater than the previous one. If the array was `[2, 4, 5, 8]`, the lower bound on max gap would still be `2`, but the actual max gap is `3` because the we shifted an element closer to its left counterpart, increasing the gap between itself and its right counterpart as a result. If we have `[2, 4, 6, 7]`, the range `[a, b]` has decreased such that now the max gap low bound is `1`, which is less than the actual max gap, `2`. 
- In short, the maximal gap between consecutive numbers in `nums` is always inclusively lower bounded by `(b - a) // (n - 1)`. We can use this fact to solve the problem in linear space and linear time. If we collect the elements of `nums` into range buckets whose subrange distance is less than or equal to the inclusive lower bound on max gap, and keep track of the smallest and largest elements in each range bucket, we have a way of comparing all relevant elements that could potentially form the actual max gap, in linear time - collect elements into subrange buckets and then compare the max and min values in adjacent buckets to find the max gap. 
- Since the buckets are range buckets (they only hold numbers in a particular subrange of `[a, b]`) and their subrange distance is `<=` the inclusive lower bound of max gap between consecutive elements, it is guaranteed that elements in the same bucket will never be the consecutive elements whose difference is the max gap. In other words, elements in the same bucket will always have gap less than the lowest possible max gap.