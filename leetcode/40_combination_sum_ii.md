# 40. Combination Sum II - Medium

Given a collection of candidate numbers (`candidates`) and a target number (`target`), find all unique combinations in `candidates` where the candidate numbers sum to `target`.

Each number in `candidates` may only be used once in the combination.

Note: The solution set must not contain duplicate combinations.

##### Example 1:

```
Input: candidates = [10,1,2,7,6,1,5], target = 8
Output: 
[
[1,1,6],
[1,2,5],
[1,7],
[2,6]
]
```

##### Example 2:

```
Input: candidates = [2,5,2,1,2], target = 5
Output: 
[
[1,2,2],
[5]
]
```

##### Constraints:

- `1 <= candidates.length <= 100` 
- `1 <= candidates[i] <= 50`
- `1 <= target <= 30`

## Solution 1

```
# Time: O(2^n)
# Space: O(n)
class Solution:
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        counts = Counter(candidates)
        nums = list(counts.keys())
        n = len(nums)
        builder, result = [], []
        def rec(i, remaining):
            if remaining == 0:
                result.append(builder[:])
                return
            if i == n:
                return
            
            num = nums[i]
            freq = counts[num]
            for multiple in range(freq + 1):
                amount = multiple * num
                if amount > remaining:
                    break
                    
                for m in range(multiple):
                    builder.append(num)
                rec(i + 1, remaining - amount)
                for m in range(multiple):
                    builder.pop()
        
        rec(0, target)
        return result
```

## Notes
- This problem is considerably trickier than 39. Combination Sum because it can have duplicate elements. If we had distinct elements this problem would be the same as 39. but with a few small modifications. 
- The trick to not getting TLE on this problem is to avoid generating duplicate combinations that sum to target. This does not mean simply putting all combos in a set, including duplicates, and then transforming the set to a list before returning. This will cause TLE because the recursive call tree gets all the way down the base case for every single duplicated combo, and for an input such as `candidates = [1] * 50, target = 30`, this wastes a ton of time.
- To avoid generating duplicate combinations, we need to make sure that for any given duplicated element, there is only one recursive call made for each possible frequency of that element in the combination. In the above solution, we achieve this using python's `Counter` from the `collections` library.
- The time complexity is <code>O(2<sup>n</sup>)</code> because in the worst case each element is distinct, and since we are dealing with combinations where each element can appear at most once, we get a binary recursive call tree of max depth `n`. The binary recursive call structure comes from the fact that we can either include a particular element, or we exclude it (2 choices).

## Solution 2

```
# Time: O(2^n)
# Space: O(n) or O(log(n)) depending on sorting algo
class Solution:
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        candidates.sort()
        n = len(candidates)
        result, builder = [], []
        def rec(i, remaining):
            if remaining == 0:
                result.append(builder[:])
                return
            
            for j in range(i, n):
                if j > i and candidates[j] == candidates[j - 1]:
                    continue
                
                curr = candidates[j]
                if curr > remaining:
                    return
                builder.append(curr)
                rec(j + 1, remaining - curr)
                builder.pop()
            
        rec(0, target)
        return result
```

## Notes
- We do not need an auxiliary data structure (at least in the top level function that solves the problem) to avoid TLE; we can sort. Sorting will group all of the duplicate elements together, which allows us to avoid multiple recursive calls with a given frequency of a duplicated element.
- In the above solution, each grouped-together duplicate element is added to `builder` as the first instance of that element in a combo once. This avoids multiple recursive calls with a given frequency of a duplicated element. I.e., if our candidates looks like so: <code>[..., x<sub>1</sub>, x<sub>2</sub>, x<sub>3</sub>, ...]</code>, we would generate a single combo for each possible frequency of x, like so: <code>[..., x<sub>1</sub>, x<sub>2</sub>, x<sub>3</sub>, ...]</code>, <code>[..., x<sub>2</sub>, x<sub>3</sub>, ...]</code>, and <code>[..., x<sub>3</sub>, ...]</code> (so long as these combos do not exceed target).