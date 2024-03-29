# 90. Subsets II - Medium

Given an integer array `nums` that may contain duplicates, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.

##### Example 1:

```
Input: nums = [1,2,2]
Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]
```

##### Example 2:

```
Input: nums = [0]
Output: [[],[0]]
```

##### Constraints:

- `1 <= nums.length <= 10`
- `-10 <= nums[i] <= 10`

## Solution

```
# Time: O(n * 2^n)
# Space: O(n * 2^n)
class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        freqs = Counter(nums)
        result = [[]]
        for unique, freq in freqs.items():
            n = len(result)
            for j in range(n):
                sub = result[j]
                for amount in range(1, freq + 1):
                    added = [unique] * amount
                    result.append(sub + added)
        
        return result
```

## Notes
- In the worst case we have distinct elements in our input. For such an input, there will be <code>2<sup>n</sup></code> sets in its powerset.
- To avoid adding duplicates to `result`, we must be careful about how we add duplicate elements to smaller sets already present in `result`. For any duplicated element `x` for which there are `n` duplicates, we only want to add `[x]`, `[x, x]`, ... `[x] * n - 1`, `[x] * n` to smaller sets already present in `result`. This can be achieved with a hash table of element frequencies, or by sorting the input and then only adding duplicate `x` elements to smaller sets already present in `result` which were generated by adding the previous `x` element.
- To really visualize how this eliminates duplicate sets efficiently, it helps to draw out an example input such as `[1, 1, 1, 1, 2, 2, 2, 3, 3, 3]`.