# 321. Maximum Number - Hard

You are given two integer arrays `nums1` and `nums2` of lengths `m` and `n` respectively. `nums1` and `nums2` represent the digits of two numbers. You are also given an integer `k`.

Create the maximum number of length `k <= m + n` from digits of the two numbers. The relative order of the digits from the same array must be preserved.

Return an array of the `k` digits representing the answer.

##### Example 1:

```
Input: nums1 = [3,4,6,5], nums2 = [9,1,2,5,8,3], k = 5
Output: [9,8,6,5,3]
```

##### Example 2:

```
Input: nums1 = [6,7], nums2 = [6,0,4], k = 5
Output: [6,7,6,0,4]
```

##### Example 3:

```
Input: nums1 = [3,9], nums2 = [8,9], k = 3
Output: [9,8,9]
```

##### Constraints:

- `m == nums1.length`
- `n == nums2.length`
- `1 <= m, n <= 500`
- `0 <= nums1[i], nums2[i] <= 9`
- `1 <= k <= m + n`

## Solution

```
# Time:  O(k * (m + n)^2)
# Space: O(k)
class Solution:
    def maxNumber(self, nums1: List[int], nums2: List[int], k: int) -> List[int]:
        def largest(k, nums):
            n = len(nums)
            pops, stack = n - k, []
            for num in nums:
                while stack and stack[-1] < num and pops > 0:
                    stack.pop()
                    pops -= 1
                stack.append(num)
            return stack[:len(stack) - pops]
        
        def merge(l1, l2):
            merged, m, n = [], len(l1), len(l2)
            i = j = 0
            while i < m or j < n:
                if i == m:
                    merged.append(l2[j])
                    j += 1
                elif j == n:
                    merged.append(l1[i])
                    i += 1
                elif l1[i] == l2[j]:
                    k, l = i, j
                    while k < m and l < n and l1[k] == l2[l]:
                        k += 1
                        l += 1
                    if k == m:
                        merged.append(l2[j])
                        j += 1
                    elif l == n:
                        merged.append(l1[i])
                        i += 1
                    elif l1[k] > l2[l]:
                        merged.append(l1[i])
                        i += 1
                    else:
                        merged.append(l2[j])
                        j += 1
                        
                elif l1[i] > l2[j]:
                    merged.append(l1[i])
                    i += 1
                else:
                    merged.append(l2[j])
                    j += 1
            return merged
        
        result = []
        for k1 in range(k + 1):
            l1, l2 = largest(k1, nums1), largest(k - k1, nums2)
            merged = merge(l1, l2)
            if len(merged) > len(result):
                result = merged
            elif len(merged) == len(result) and merged > result:
                result = merged
        
        return result
```

## Notes
- Very very difficult problem. I think backtracking could work here with no time constraints but is difficult to get right because any given call to `dp(i, j)` would need to consider all possible maxes of all combined subsequence lengths `<= k` for a given `nums1[i:], nums2[j:]` for return to its caller. This is an indication that we will need some sort of problem-specific greedy strategy to solve this. 
- For this problem, we can say for sure we would need some amount of numbers `x <= k` from `nums1` and some other amount of numbers `y = k - x` from `nums2` to form our `k`-length answer. We could check all such `x` and `y` combinations that sum to `k` and we could say for sure that our answer is in this search space. Each `x` and `y` combination would represent combining the best `x` numbers of `nums1` and the best `y` numbers of `nums2` into the largest possible result, similar to merge sort. The best `x` or `y` numbers of the respective array would be the decreasing monotonic stack of size `x` or `y` such that we stop popping from the stack once we have popped `m - x` or `n - y` times if `m` and `n` are the lengths of `nums1` and `nums2` respectively. This ensures the first elements of the result are as large as possible without returning an excessively small result.
- The last tricky part of this problem is getting the merge function correct, in particular handling the case where we are trying to merge elements of equivalent value. In short, to handle this case correctly we need to always add the element that may have larger values closer to it. This edge case gave me heartburn.