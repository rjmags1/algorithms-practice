# 47. Permutations II - Medium

Given a collection of numbers, `nums`, that might contain duplicates, return all possible unique permutations in any order.

##### Example 1:

```
Input: nums = [1,1,2]
Output:
[[1,1,2],
 [1,2,1],
 [2,1,1]]
```

##### Example 2:

```
Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

```

##### Constraints:

- `1 <= nums.length <= 8`
- `-10 <= nums[i] <= 10`

## Solution 1

```
# Time: O(n! * n)
# Space: O(n! * n)
class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        freqs = Counter(nums)
        result, builder = [], []
        n = len(nums)
        def buildPerms(i):
            if i == n:
                result.append(builder[:])
                return
            
            for num, left in freqs.items():
                if left == 0:
                    continue
                
                builder.append(num)
                freqs[num] -= 1
                buildPerms(i + 1)
                builder.pop()
                freqs[num] += 1
        
        buildPerms(0)
        return result
```

## Notes
- This problem is trickier than 46. Permutations because we can have duplicate numbers in the input, which will lead to duplicate permutations if left unaddressed.
- The workaround for this is pretty straightforward. As we build permutations, we want to place each possible unique number left to choose from (as opposed to simply every number at and to the right of the current index when input elements are distinct as in 46. Permutations) in the current index. We can achieve this using a frequency hash table, similar to the solution for 40. Combination Sum II.