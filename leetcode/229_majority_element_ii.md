# 229. Majority Element II - Medium

Given an integer array of size `n`, find all elements that appear more than `⌊ n/3 ⌋` times.

##### Example 1:

```
Input: nums = [3,2,3]
Output: [3]
```

##### Example 2:

```
Input: nums = [1]
Output: [1]
```

##### Example 3:

```
Input: nums = [1,2]
Output: [1,2]
```

##### Constraints:

- <code>1 <= nums.length <= 5 * 10<sup>4</sup></code>
- <code>-10<sup>9</sup> <= nums[i] <= 10<sup>9</sup></code>

Follow-up: Could you solve the problem in linear time and in `O(1)` space? 

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    def majorityElement(self, nums: List[int]) -> List[int]:
        if not nums:
            return []
        
        cand1 = cand2 = None
        count1 = count2 = 0
        for num in nums:
            # can only increase 1 of the counters if cands are distinct
            if num == cand1 or num == cand2:
                if num == cand1:
                    count1 += 1
                else:
                    count2 += 1
                continue
            
            # eliminate a triplet
            if count1 > 0 and count2 > 0:
                count1 -= 1
                count2 -= 1
                continue
                
            # only replace one eliminated cand at a time
            if count1 == 0:
                cand1, count1 = num, 1
            else:
                cand2, count2 = num, 1
        
        floor = len(nums) // 3
        return [c for c in [cand1, cand2] if nums.count(c) > floor]
```

## Notes
- Trivially solvable with a Counter, but that would be non-constant space.
- When you hear majority element, Boyer-Moore voting algorithm should come to mind straightaway. The application for `k > 1` is non-trivial though so kind of a bad question. 
- The driving idea behind this algorithm is that instead of determining a single majority element by eliminating pairs of "votes" that offset each other as in the typical Boyer-Moore, we eliminate triplets of "votes" that offset each other, where `2` of the "votes" in a triplet are majority elements. Consider this: there can only be at most `2` candidates that have more than `n // 3` votes; the most votes a bronze winning candidate could possibly get is `n // 3`. All of the bronze votes would offset __just some__ of the silver and gold candidates' votes (here gold and silver are individual people even if they get the same number of votes).
- Ok this idea is making some sense. However the implementation is challenging, and requires a bit of state machine logic, which is tough for beginners. Again if we are supposed to seriously answer the followup in an interview setting this question should be ranked hard/is a bad question.