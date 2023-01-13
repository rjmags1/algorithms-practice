# 327. Count of Range Sum - Hard

Given an integer array `nums` and two integers `lower` and `upper`, return the number of range sums that lie in `[lower, upper]` inclusive.

Range sum `S(i, j)` is defined as the sum of the elements in nums between indices `i` and `j` inclusive, where `i <= j`.

##### Example 1:

```
Input: nums = [-2,5,-1], lower = -2, upper = 2
Output: 3
Explanation: The three ranges are: [0,0], [2,2], and [0,2] and their respective sums are: -2, -1, 2.
```

##### Example 2:

```
Input: nums = [0], lower = 0, upper = 0
Output: 1
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>5</sup> <= lower <= upper <= 10<sup>5</sup></code>
- <code>-2<sup>31</sup> <= nums[i] <= 2<sup>31</sup> - 1</code>
- The answer is guaranteed to fit in a 32-bit integer.

## Solution

```
class BIT:
    def __init__(self, n):
        self.bit = [0] * (n + 1)
        self.n = n
    
    def rmb(self, k):
        return k & -k
    
    def query(self, k):
        result = 0
        while k:
            result += self.bit[k]
            k -= self.rmb(k)
        return result
    
    def update(self, k):
        while k <= self.n:
            self.bit[k] += 1
            k += self.rmb(k)

# Time: O(nlog(n))
# Space: O(n)
class Solution:
    def countRangeSum(self, nums: List[int], lower: int, upper: int) -> int:
        n = len(nums)
        bit = BIT(n + 1)
        prefix = [0]
        for num in nums:
            prefix.append(prefix[-1] + num)
        result, sprefix = 0, sorted(prefix)
        for s in prefix:
            high, low = s - lower, s - upper
            hidx, lidx = bisect_right(sprefix, high), bisect_left(sprefix, low)
            result += bit.query(hidx) - bit.query(lidx)
            bit.update(bisect_left(sprefix, s) + 1)
            
        return result
```

## Notes
- This solution is very challenging because it involves two difficult algorithms paradigms, virtual indexing AKA sorted index as rank and binary index tree, and two basic ones, prefix sums and binary search. The idea here is we need to optimize the naive <code>O(n<sup>2</sup>)</code> solution where for each prefix sum, we check all preceding ones to see if a particular subarray has a sum that is in the range `[lower, upper]`. This linear search is essentially checking if a previous prefix sum is in a particular range `[currprefixsum - upper, currprefixsum - lower]`. 
- Ok, so we need to optimize a range query to be better than linear. What data structures are good for that? Segment tree and BIT. I prefer BIT because though it is conceptually more difficult to understand it is easier to implement and as a result can be treated as a black box. Anyway, if we can utilize a BIT, this will improve our runtime complexity to `O(nlog(bitrange))`. However, given the massive range of possible prefix sums due to the potential range for `nums[i]` given in the problem, it will not be possible for us to go with a naive approach to building a BIT where the tree is filled with all possible range values. This is where I got stuck the first time I attempted this problem because I wasn't aware of 'virtual indexing' AKA sorted index as rank, which is how we get around the large range problem.
- To utilize a BIT in this problem we need to reduce the search space for possible prefix sums. Well, there are only `n` possible prefix sums, so we could make these possible prefix sums the search space, which is seems obvious but from an implementation perspective this is difficult to do. This is where virtual indexing comes in. If we generate all possible prefix sums and sort them, we can use their sorted indexes to assign each of them a relative rank, and use the presence of a particular rank in the BIT as an indication that a prefix sum has been previously encountered. If we stopped here, though, we would still end up traversing the sorted prefix sums to determine the rank range for acceptable `[currprefixsum - upper, currprefixsum - lower]` in a linear fashion.
- This is where binary search comes in. We use binary search to get the acceptable rank range in logarithmic time (binary search for rank of lowest prefix sum of `nums` `>= currprefixsum - upper` and `> currprefixsum - lower`), which can then be used to query the number of prefix sums we have previously encountered via the BIT, also in logarithmic time. 
- A couple other notes about this solution: notice how we add a `0` at the start of the prefix array. This allows us to easily consider cases where a full prefix sum is in the acceptable range. Last, notice the use of `bisect` module. `bisect_left` is binary search that finds the leftmost element in the array `>=` target. `bisect_right` is binary search that finds the leftmost element in the array `>` target. By finding the rank of the lowest prefix sum `> currprefixsum - lower` and the lowest rank of the prefix sum that is `>= currprefixsum - upper`, we will always query for the correct number of prefixes that fall in the range `[currprefixsum - upper, currprefixsum - lower]`. This was counterintuitive to me at first, but it is essentially the same idea as when we do `prefix[i] - prefix[j - 1]` to determine the prefix sum for the subarray `arr[i:j]`. We __do not__ increment the rank target returned by the calls to bisect because of the definition of bisect functions - they return the __0-indexed leftmost `> hidx` or `== lidx`, which if left unincremented when passed to BIT for query will represent 1-index ranks of leftmost `<= hidx` and `< lidx`__, where `hidx` and `lidx` are ranks of `currprefixsum - upper` and `currprefixsum - lower`.