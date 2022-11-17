# 179. Largest Number - Medium

Given a list of non-negative integers `nums`, arrange them such that they form the largest number and return it.

Since the result may be very large, so you need to return a string instead of an integer.

##### Example 1:

```
Input: nums = [10,2]
Output: "210"
```

##### Example 2:

```
Input: nums = [3,30,34,5,9]
Output: "9534330"
```

##### Constraints:

- `1 <= nums.length <= 100`
- <code>0 <= nums[i] <= 10<sup>9</sup></code>

## Solution 1

```
# Time: O(n^2)
# Space: O(n)
GT, LTE = "gt", "lte"
class Solution:
    def largestNumber(self, nums: List[int]) -> str:
        def cmp(a, b):
            return LTE if a + b <= b + a else GT
        
        nz = []
        z = 0
        for num in nums:
            if num == 0:
                z += 1
            else:
                nz.append(str(num))
        n = len(nz)
        if n == 0:
            return "0"
        
        for i in reversed(range(n - 1)):
            for j in range(i, n - 1):
                a, b = nz[j], nz[j + 1]
                if cmp(a, b) == GT:
                    nz[j], nz[j + 1] = b, a
        
        return "".join(reversed(nz)) + "0" * z
```

## Notes
- Insertion sort with custom comparator. We always want numbers that will lead to a larger result to come first. Watch out for edge case where there are only zeroes in the input.

## Solution 2

```
# Time: O(nlog(n) * m)
GT, LTE = "gt", "lte"
class NumKey(str):
    def __lt__(self, other):
        return self + other < other + self

class Solution:
    def largestNumber(self, nums: List[int]) -> str:
        containsnz = any([num != 0 for num in nums])
        if not containsnz:
            return "0"
        
        return "".join(reversed(sorted([str(num) for num in nums], key=NumKey)))
```

## Notes
- More "pythonic" way of handling this using a custom key object with a method for comparing.