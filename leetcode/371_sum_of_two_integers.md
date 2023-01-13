# 371. Sum of Two Integers - Medium

Given two integers `a` and `b`, return the sum of the two integers without using the operators `+` and `-`.

##### Example 1:

```
Input: a = 1, b = 2
Output: 3
```

##### Example 2:

```
Input: a = 2, b = 3
Output: 5
```

##### Constraints:

- `-1000 <= a, b <= 1000`

## Solution 1

```
# Time: O(log(max(a, b)))
# Space: O(1)
class Solution:
    def subcarry(self, x):
        rmb = x & -x
        while rmb:
            x ^= rmb
            rmb >>= 1
        return x
    
    def flipsign(self, x):
        if x == 0:
            return 0
        return self.add(~x, 1) if x < 0 else ~self.sub(x, 1)

    def add(self, a, b):
        result, shift, carry = 0, 1, 0
        while a or b or carry:
            abit, bbit = a & 1, b & 1
            if abit & bbit:
                if carry:
                    result |= shift
                carry = 1
            elif abit | bbit:
                if not carry:
                    result |= shift
                else:
                    carry = 1
            else:
                if carry:
                    result |= shift
                carry = 0

            a >>= 1
            b >>= 1
            shift <<= 1
            
        return result
    
    def sub(self, a, b):
        x = a
        shift, result = 1, 0
        while a:
            abit, bbit = a & 1, b & 1
            if abit ^ bbit:
                result |= shift
                if bbit:
                    a = self.subcarry(a)
            shift <<= 1
            a >>= 1
            b >>= 1

        return result

    def getSum(self, a: int, b: int) -> int:
        aneg, bneg = a < 0, b < 0
        add = aneg and bneg or (not aneg and not bneg)
        if add:
            if a >= 0 and b >= 0:
                return self.add(a, b)
            return self.flipsign(self.add(self.flipsign(a), self.flipsign(b)))
        elif aneg:
            a = self.flipsign(a)
            return self.flipsign(self.sub(a, b)) if a > b else self.sub(b, a)
        else:
            b = self.flipsign(b)
            return self.flipsign(self.sub(b, a)) if b > a else self.sub(a, b)
```

## Notes
- This solution is a little more intuitive; it does not use the `+` or `-` operators *at all*, even as unary operators, and relies on more basic bit manipulation tricks.
- If this problem only considered positive integers, the implementation would be much simpler; we could just submit the `add` method and be done. However, we must also consider negative numbers, which complicates things significantly; in particular, to handle cases where one input number is negative and the other is positive, we need to implement binary subtraction for positive numbers, which requires a subtraction carry function. For this case as well as the case where both inputs are negative we also need a `flipsign` function, although this is trivial if we have already implemented `add` and `sub` and have a basic working understanding of binary numbers.
- For interview purposes, it will be useful to remember how __negating a positive number__ is the same as *incrementing its magnitude and flipping its sign*; similarly, __negating a negative number__ is the same as *decrementing its magnitude and flipping its sign*.

## Solution 2

```
# Time: O(log(max(a, b)))
# Space: O(1)
class Solution:
    def add(self, a, b):
        result, carry = a ^ b, (a & b) << 1
        while carry:
            result, carry = result ^ carry, (result & carry) << 1
        return result

    def sub(self, a, b):
        result, borrow = a ^ b, (~a & b) << 1
        while borrow:
            result, borrow = result ^ borrow, (~result & borrow) << 1
        return result
    
    def getSum(self, a: int, b: int) -> int:
        aneg, bneg = a < 0, b < 0
        add = aneg and bneg or (not aneg and not bneg)
        a, b, = abs(a), abs(b)
        if add:
            return self.add(a, b) if not aneg else -self.add(a, b)
        elif bneg:
            return -self.sub(b, a) if b > a else self.sub(a, b)
        return -self.sub(a, b) if a > b else self.sub(b, a)
```

## Notes
- We can use better bit manipulation tricks to solve this problem with less code, though we will need to rely on the unary `-` operator. Consider the following for binary addition: when we add two positive binary numbers that don't require carrying during the course of their addition, we are essentially XOR'ing the bits of the numbers we are adding. When we add positive binary numbers that do require carrying, we can treat this case as the case where no carrying is required, and save the carried bits for another round of XOR until there is no more carrying to be done. Similar, though less intuitive, logic applies to the subtraction case.