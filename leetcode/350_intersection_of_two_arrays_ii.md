# 350. Intersection of Two Arrays II - Easy

Given two integer arrays `nums1` and `nums2`, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.

##### Example 1:

```
Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2,2]
```

##### Example 2:

```
Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [4,9]
Explanation: [9,4] is also accepted.
```

##### Constraints:

- `1 <= nums1.length, nums2.length <= 1000`
- `0 <= nums1[i], nums2[i] <= 1000`

Follow-up:
- What if the given array is already sorted? How would you optimize your algorithm?
- What if `nums1`'s size is small compared to `nums2`'s size? Which algorithm is better?
- What if elements of `nums2` are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?

## Solution 1

```
# Time: O(n + m)
# Space: O(n + m)
class Solution:
    def intersect(self, nums1: List[int], nums2: List[int]) -> List[int]:
        c1, c2 = Counter(nums1), Counter(nums2)
        inter = set(c1.keys()) & set(c2.keys())
        result = []
        for val in inter:
            result.extend([val] * min(c1[val], c2[val]))
        return result
```

## Notes
- Set intersection of element frequencies hash table keys.

## Solution 2

```
# Time: O(n + m) (assuming pre-sorted input for follow-up 1)
# Space: O(1) (assuming pre-sorted input for follow-up 1)
class Solution:
    def intersect(self, nums1: List[int], nums2: List[int]) -> List[int]:
        nums1.sort()
        nums2.sort()
        m, n = len(nums1), len(nums2)
        i = j = 0
        result = []
        while i < m and j < n:
            if nums1[i] == nums2[j]:
                result.append(nums1[i])
                i += 1
                j += 1
            elif nums1[i] < nums2[j]:
                i += 1
            else:
                j += 1
        return result
```

## Notes
- Follow-up 1 

## Solution 3

```
# Time: O(n + m)
# Space: O(n)
class Solution:
    def intersect(self, nums1: List[int], nums2: List[int]) -> List[int]:
        counts = defaultdict(lambda: [0, 0])
        for num in nums1:
            counts[num][0] += 1
        for num in nums2:
            if num in counts:
                counts[num][1] += 1
        result = []
        for num, c in counts.items():
            result.extend([num] * min(c[0], c[1]))
        return result
```

## Notes
- Follow-ups 2 and 3: would want to store elems present in the array with smallest size/whatever is storable in memory in a hash table.