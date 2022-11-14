# 190. Reverse Bits - Easy

Reverse bits of a given 32 bits unsigned integer.

Note:

    Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
    In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 2 above, the input represents the signed integer `-3` and the output represents the signed integer `-1073741825`.


##### Example 1:

```
Input: n = 00000010100101000001111010011100
Output:    964176192 (00111001011110000010100101000000)
Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.
```

##### Example 2:

```
Input: n = 00000010100101000001111010011100
Output:    964176192 (00111001011110000010100101000000)
Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.
```

##### Constraints:

- The input must be a binary string of length `32`

Follow-up: If this function is called many times, how would you optimize it?

## Solution 1

```
# Time: O(1)
# Space: O(1)
class Solution:
    def reverseBits(self, n: int) -> int:
        res, k = 0, 32
        while k:
            res = (res << 1) | (n & 1)
            n >>= 1
            k -= 1
        return res
```

## Notes
- Reverse bit by bit by getting each bit of `n` right to left and putting it into `res` left to right. Input size is always `32` so we use constant runtime and space.

## Solution 2

```
# Time: O(1)
# Space: O(1)
class Solution:
    def reverseBits(self, n: int) -> int:
        n = (n >> 16) | (n << 16)
        n = ((n & 0b11111111000000001111111100000000) >> 8) | ((n & 0b00000000111111110000000011111111) << 8)
        n = ((n & 0b11110000111100001111000011110000) >> 4) | ((n & 0b00001111000011110000111100001111) << 4)
        n = ((n & 0b11001100110011001100110011001100) >> 2) | ((n & 0b00110011001100110011001100110011) << 2)
        n = ((n & 0b10101010101010101010101010101010) >> 1) | ((n & 0b01010101010101010101010101010101) << 1)
        return n
```

## Notes
- Notice how the combined effect of the mask and bitshift in each step moves every other half over to the left or right depending on parity index. This has the combined effect of reversing the halves. If we reverse each half down to the point when halves are size `1` we will have reversed original bit stream. Easier to understand when masks are represented in binary as opposed to hex. See below:
<img src="../assets/190.jpg" />


## Solution 3

```
# Time: O(1)
# Space: O(1)
class Solution:
    def reverseBits(self, n: int) -> int:
        n = (n >> 16) | (n << 16)
        n = ((n & 0xff00ff00) >> 8) | ((n & 0x00ff00ff) << 8)
        n = ((n & 0xf0f0f0f0) >> 4) | ((n & 0x0f0f0f0f) << 4)
        n = ((n & 0xcccccccc) >> 2) | ((n & 0x33333333) << 2)
        n = ((n & 0xaaaaaaaa) >> 1) | ((n & 0x55555555) << 1)
        return n
```

## Notes
- Masks in hex here instead of binary.