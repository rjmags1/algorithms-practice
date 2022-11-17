# 169. Majority Element - Easy

Given an array `nums` of size `n`, return the majority element.

The majority element is the element that appears more than `⌊n / 2⌋` times. You may assume that the majority element always exists in the array.

##### Example 1:

```
Input: nums = [3,2,3]
Output: 3
```

##### Example 2:

```
Input: nums = [2,2,1,1,1,2,2]
Output: 2
```

##### Constraints:

- `n == nums.length`
- <code>1 <= n <= 5 * 10<sup>4</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

## Solution 1

```
# Time: O(n) (but 32 passes)
# Space: O(1)
class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        maj = 0
        checker = 1 << 30
        for bit in range(31):
            ones = zeroes = 0
            for num in nums:
                if num & checker > 0:
                    ones += 1
                else:
                    zeroes += 1
            
            if ones > zeroes:
                maj |= checker
            checker >>= 1
        
        neg = 0
        for num in nums:
            neg += 1 if num < 0 else -1
        return -(~maj) if neg > 0 else maj
```

## Notes
- This solution follows from the idea that all the bits in the majority element will be present in at least the majority of the elements in `nums`. Tracking each majority bit is trivial, but since it is possible for our input to contain negative numbers, we need to be considerate of this fact, especially when the majority element is negative. CPython uniquely handles integers such that they can be arbitrarily long, recording whether they are negative or not in a separate struct field and storing the actual magnitude as a positive number. Before any bitwise operations are done on negative numbers, their magnitude is converted to two's complement.
- So in short, to handle negative majority elements, since when performing bitwise operations negative python integers have their magnitudes converted to two's complement, we need to flip all the bits in `maj` so that its magnitude is correct before making it negative, which internally will change the value in a struct field to indicate that our result is negative. In other languages, making it negative would constitute negating and flipping the sign bit, which would be the 32nd bit from the left in a 32-bit environment. 
- I.e. if the majority element was `-4`, by the time we exit the main loop `maj` magnitude internally would look like `1111...011`. We know this should be `-4`, and so we negate to `0000...100` before flipping the sign to be negative.

## Solution 2

```
# Time: O(n)
# Space: O(1)
class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        curr, count = nums[0], 1
        n = len(nums)
        for i in range(1, n):
            count += 1 if nums[i] == curr else -1
            if count == 0:
                count, curr = 1, nums[i]
        return curr
```

## Notes
- Though it is possible to come up with the algorithm naively since it is relatively simple, the intuition behind it could take a little bit to stumble on in an interview. The idea is we consider any element as the majority element, incrementing its counter when we see the the current candidate and decrementing when we see an element that isn't the current candidate. If the counter ever reaches `0`, we forget about all the elements we previously encountered and consider the current element as potentially being the majority candidate. 
- Why does this work? Well, it is guaranteed that any minority candidate will have its count decremented as many times as it is incremented because the frequency of a majority element will always be more than `n // 2`. Consider `[7, 7, 7, 8, 8, 8, 8]` or `[7, 7, 8, 8, 8, 8]`, which are examples of the maximum number of a minority element in an input for this problem in odd and even `n` cases. Regardless of the order of elements in this array, the counter for `7` will always be decremented as many times as it is incremented. 
- Conversely, it is also guaranteed that there must be one majority element whose counter gets incremented more times than it is decremented.