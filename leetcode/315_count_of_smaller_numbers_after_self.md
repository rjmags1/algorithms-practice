# 315. Count of Smaller Number After Self - Hard

Given an integer array `nums`, return an integer array `counts` where `counts[i]` is the number of smaller elements to the right of `nums[i]`.

##### Example 1:

```
Input: nums = [5,2,6,1]
Output: [2,1,1,0]
Explanation:
To the right of 5 there are 2 smaller elements (2 and 1).
To the right of 2 there is only 1 smaller element (1).
To the right of 6 there is 1 smaller element (1).
To the right of 1 there is 0 smaller element.
```

##### Example 2:

```
Input: nums = [-1]
Output: [0]
```

##### Example 3:

```
Input: nums = [-1,-1]
Output: [0,0]
```

##### Constraints:

- <code>1 <= nums.length <= 10<sup>5</sup></code>
- <code>-10<sup>4</sup> <= nums[i] <= 10<sup>4</sup></code>

## Solution

```
class BIT:
    def __init__(self, n):
        self.n = n
        self.bit = [0] * (n + 1)
    
    def rmb(self, num):
        return num & (~num + 1)
    
    def kmap(self, num):
        return self.n // 2 + num + 1
    
    def query(self, num):
        k = self.kmap(num)
        result = 0
        while k:
            result += self.bit[k]
            k -= self.rmb(k)
        return result
    
    def update(self, num):
        k = self.kmap(num)
        while k <= self.n:
            self.bit[k] += 1
            k += self.rmb(k)

# Time: O(n * log(m)) where m is range size
# Space: O(m)
class Solution:
    def countSmaller(self, nums: List[int]) -> List[int]:
        freqbit = BIT(20001)
        result = []
        for i in reversed(range(len(nums))):
            curr = nums[i]
            if curr != -10000:
                result.append(freqbit.query(curr - 1))
            else:
                result.append(0)
            freqbit.update(curr)
        result.reverse()
        return result
```

## Notes
- Combine the concept of buckets/frequencies with BIT. This will allow us to logarithmically query to number of elements smaller than the current element already in the BIT as we iterate RTL through the array. We could significantly cut down the size of the BIT in most cases if we used BIT of element magnitude ranks but this approach suffices.
- We could also use a segment tree to handle this in a similarly straightforward fashion.