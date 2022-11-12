# 152. Maximum Product Subarray - Medium

Given an integer array `nums`, find a subarray that has the largest product, and return the product.

The test cases are generated so that the answer will fit in a 32-bit integer.

##### Example 1:

```
Input: nums = [2,3,-2,4]
Output: 6
Explanation: [2,3] has the largest product 6.
```

##### Example 2:

```
Input: nums = [-2,0,-1]
Output: 0
Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
```

##### Constraints:

- <code>1 <= nums.length <= 2 * 10<sup>4</sup></code>
- <code>-10 <= nums[i] <= 10</code>
- The product of any prefix or suffix of `nums` is guaranteed to fit in a 32-bit integer.

## Solution 1

```
# Time: O(n)
# Space: O(n)
class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [nums[0]]
        result = dp[0] = nums[0]
        prevnegi = 0 if nums[0] < 0 else None
        for i in range(1, n):
            curr = nums[i]
            dp.append(None)
            if curr < 0:
                dp[i] = curr
                if prevnegi is not None:
                    for j in range(prevnegi, i):
                        dp[i] *= nums[j]
                    if prevnegi > 0 and dp[prevnegi - 1] > 0:
                        dp[i] *= dp[prevnegi - 1]
                prevnegi = i
            else:
                dp[i] = max(curr, curr * dp[i - 1])
            
            result = max(result, dp[i])
        
        return result
```

## Notes
- This solution uses dp to determine the max product for each subarray starting at `i = 0`. 
- Everytime we see a negative number, if there was a negative number previously, then the max product subarray ending at that number is the product of it, the previous negative number, all the numbers in between, and the max product of the subarray before the previous negative number (if there was one and its subarray product was positive). If there wasn't a negative number previously then the max product subarray is just the negative number itself. 
- Everytime we see a positive number, we either continue a previously positive chain of subarray products, or in the case where we have only seen one negative number, the max subarray product ending in the current positive number is just the current positive number itself.

## Solution 2

```
# Time: O(n)
# Space: O(n)
class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        result = minchain = maxchain = nums[0]
        for i in range(1, len(nums)):
            num = nums[i]
            oldmax = maxchain
            maxchain = max(maxchain * num, minchain * num, num)
            minchain = min(oldmax * num, minchain * num, num)
            result = max(result, maxchain)
            
        return result
```

## Notes
- This is another dp approach that doesn't need any auxiliary space because at each index, we can determine what the maximum subarray product and the minimum subarray product are up to a given `i` based on the what they were for `i - 1`. As long as we always know the maximum subarray product and the minimum subarray product for the previous index, we can determine what it is for the current index based on the value at the current index.
- If we encounter a zero, we have to start our `maxchain` and `minchain` over. If we encounter a negative number, our `maxchain` becomes our `minchain`, and our `minchain` becomes our `maxchain`. If we encounter a positive number, the magnitudes of `minchain` and `maxchain` increase or stay the same along with their signs.