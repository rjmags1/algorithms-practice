# 385. Mini Parser - Medium

Given a string `s` represents the serialization of a nested list, implement a parser to deserialize it and return the deserialized `NestedInteger`.

Each element is either an integer or a list whose elements may also be integers or other lists.

##### Example 1:

```
Input: s = "324"
Output: 324
Explanation: You should return a NestedInteger object which contains a single integer 324.
```

##### Example 2:

```
Input: s = "[123,[456,[789]]]"
Output: [123,[456,[789]]]
Explanation: Return a NestedInteger object containing a nested list with 2 elements:
1. An integer containing value 123.
2. A nested list containing two elements:
    i.  An integer containing value 456.
    ii. A nested list with one element:
         a. An integer containing value 789
```

##### Constraints:

- <code>1 <= s.length <= 5 * 10<sup>4</sup></code>
- `s` consists of digits, square brackets `"[]"`, negative sign `'-'`, and commas `','`.
- `s` is the serialization of valid `NestedInteger`.
- All the values in the input are in the range <code>[-10<sup>6</sup>, 10<sup>6</sup>]</code>.

## Solution

```
# Time: O(n) where n is length of s
# Space: O(l + e) where l is num lists and e is num ints
class Solution:
    def parseint(self, s, i):
        neg = s[i] == "-"
        if neg:
            i += 1
        curr = 0
        while i < len(s) and s[i].isdigit():
            curr = curr * 10 + int(s[i])
            i += 1
        if neg:
            curr = -curr

        return i, curr

    def deserialize(self, s: str) -> NestedInteger:
        if s[0] != "[":
            return NestedInteger(self.parseint(s, 0)[1])

        stack, i = [NestedInteger()], 1
        result = stack[0]
        while stack:
            if s[i] == "[":
                new = NestedInteger()
                stack[-1].getList().append(new)
                stack.append(new)
            elif s[i] == "-" or s[i].isdigit():
                i, num = self.parseint(s, i)
                stack[-1].getList().append(NestedInteger(num))
                continue
            elif s[i] == "]":
                stack.pop()
            i += 1
        
        return result
```

## Notes
- Stack of `NestedInteger`s that are lists. The stack allows us always have access to the parent list of the current list. Notice how the edge case where input has no lists is handled.