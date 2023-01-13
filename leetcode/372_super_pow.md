# 372. Super Pow - Medium

Your task is to calculate <code>a<sup>b</sup></code> mod `1337` where `a` is a positive integer and `b` is an extremely large positive integer given in the form of an array.

##### Example 1:

```
Input: a = 2, b = [3]
Output: 8
```

##### Example 2:

```
Input: a = 2, b = [1,0]
Output: 1024
```

##### Example 3:

```
Input: a = 1, b = [4,3,3,8,5,2]
Output: 1
```

##### Constraints:

- <code>1 <= a <= 2<sup>31</sup> - 1</code>
- `1 <= b.length <= 2000`
- `0 <= b[i] <= 9`
- `b` does not contain leading zeros.

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    MOD = lambda self, x: x % 1337
    def pow(self, num, exp):
        if exp < 2:
            return 1 if exp == 0 else num

        result, curr = 1, num
        while exp:
            if exp & 1:
                result = self.MOD(result * curr)
            curr = self.MOD(curr * curr) 
            exp >>= 1
        return result

    def superPow(self, a: int, b: List[int]) -> int:
        a, result = self.MOD(a), 1
        for pd in b:
            result = self.MOD(self.pow(result, 10))
            result = self.MOD(result * self.pow(a, pd))
        return result
```

## Notes
- To solve this we need to apply exponent rules to compute the power of a number to a large exponent, as well as modular math combined with custom power calculation logic from 50. Pow(x, n) to ensure we stay within the 32-bit integer bounds. Recall that <code>x<sup>20</sup> = x<sup>2 * 10</sup> = x<sup>2<sup>10</sup></sup></code>, and <code>x<sup>5</sup> = x<sup>3</sup> * x<sup>2</sup> = x<sup>3 + 2</sup></code>. Putting these ideas together, we get <code>x<sup>423</sup> = x<sup>4 * 10 * 10</sup> + x<sup>2 * 10</sup> + x<sup>3</sup> = x<sup>4<sup>10<sup>10</sup></sup></sup> + x<sup>2<sup>10</sup></sup> + x<sup>3</sup></code>. We can use these rules to handle the large exponent portion of this problem, and the logic for writing our own `pow` function from 50. Pow(x, n) to ensure we stay within the 32-bit integer range by modding as the power of some number `< 1337` raised to some number `< 11` is calculated.