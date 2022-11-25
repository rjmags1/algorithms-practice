# 287. Find the Duplicate Number - Medium

Given an array of integers nums containing `n + 1` integers where each integer is in the range `[1, n]` inclusive.

There is only one repeated number in `nums`, return this repeated number.

You must solve the problem without modifying the array `nums` and uses only constant extra space.

##### Example 1:

```
Input: nums = [1,3,4,2,2]
Output: 2
```

##### Example 2:

```
Input: nums = [3,1,3,4,2]
Output: 3
```

##### Constraints:

- <code>1 <= n <= 10<sup>5</sup></code>
- `nums.length == n + 1`
- `1 <= nums[i] <= n`
- All the integers in `nums` appear only once except for precisely one integer which appears two or more times.

Follow-up: 

- How can we prove that at least one duplicate number must exist in `nums`?
- Can you solve the problem in linear runtime complexity?

## Solution 1

```
# Time: O(n)
# Space: O(1)
class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        t = h = 0
        start = True
        while start or t != h:
            start = False
            t = nums[t]
            h = nums[h]
            h = nums[h]
            
        t2 = 0
        while t != t2:
            t = nums[t]
            t2 = nums[t2]
            
        return t
```

## Notes
- Very difficult problem if we stick to all constraints AND try for linear runtime. Users who jump straight to trying for a linear solution who haven't seen a bunch of tortoise and hare problems before will probably get discouraged. To see how tortoise and hare applies to this problem would take applying tortoise and hare to several other problems that are not simply "find the cycle entrance in a LL." Since we are guaranteed all elements fall in the range `[1, n]`, and there are `n + 1` elements in the list, we can be sure that any number we may encounter in the array can be mapped to an index. If there were no duplicate element and we had `n` elements instead of `n - 1`, we would either get caught in a single element cycle or a full array cycle jumping from element to its mapped index element. However, with a duplicated element we will always skip single element cycles, if we start at index `0`, and there will always be a cycle less than the length of the array. 
- Other approaches to this problem include marking seen elements by flipping the sign of the element at their index, but this violates the non-modifying constraint of the problem. This approach would be linear time and constant space, and is the best approach if we didn't care about avoiding modification (if we did this approach we technically could undo our modification by unflipping all signs before returning but tortoise and hare doesn't modify at all).

## Solution 2

```
# Time: O(nlog(n))
# Space: O(1)
class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        n = len(nums) - 1
        l, r = 1, n
        while l < r:
            num = (l + r) // 2
            lte = 0
            for elem in nums:
                if elem <= num:
                    lte += 1
            if lte > num:
                r = num
            else:
                l = num + 1
                
        return r
```

## Notes
- This solution is based on the idea that for the sequence, `[1, n]`, the sorted counts of the number of elements less than or equal to each element in the sequence would look identical to the original sequence. However, when we add extra number(s) to the sequence, the counts sequence becomes altered such that all the counts for the elements `>=` the duplicate element are incremented by the number of extras. Similarly, if there is more than one extra duplicate element, the counts sequence will become shorter due to the absent sequence element, but the counts for sequence elements `>=` the duplicated element will be higher than they would be if there were no duplicates. 
- Following this reasoning, it makes sense that the duplicate element will be the leftmost one in the sorted counts sequence to have a count higher than its value. I.e., consider the input `[1, 2, 3, 4, 4, 5, 6]` with counts sequence `[1, 2, 3, 5, 6, 7]` for each of its unique elements. We can just perform binary search on the range of possible counts for the leftmost count greater than its value.