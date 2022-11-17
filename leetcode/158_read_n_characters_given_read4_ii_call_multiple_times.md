# 158. Read N Characters Given read4 II - Call Multiple Times - Hard

Given a `file` and assume that you can only read the file using a given method `read4`, implement a method `read` to read `n` characters. Your method `read` may be called multiple times.

Method read4:

The API `read4` reads four consecutive characters from `file`, then writes those characters into the buffer array `buf4`.

The return value is the number of actual characters read.

Note that `read4()` has its own file pointer, much like `FILE *fp` in C.

Definition of read4:

```
    Parameter:  char[] buf4
    Returns:    int

buf4[] is a destination, not a source. The results from read4 will be copied to buf4[].
```

Below is a high-level example of how `read4` works:

<img src="../assets/157_example.png" />

```
File file("abcde"); // File is "abcde", initially file pointer (fp) points to 'a'
char[] buf4 = new char[4]; // Create buffer with enough space to store characters
read4(buf4); // read4 returns 4. Now buf4 = "abcd", fp points to 'e'
read4(buf4); // read4 returns 1. Now buf4 = "e", fp points to end of file
read4(buf4); // read4 returns 0. Now buf4 = "", fp points to end of file
```
 
Method `read`:

By using the `read4` method, implement the method read that reads `n` characters from `file` and store it in the buffer array `buf`. Consider that you cannot manipulate `file` directly.

The return value is the number of actual characters read.

Definition of `read`:

```
    Parameters:	char[] buf, int n
    Returns:	int

buf[] is a destination, not a source. You will need to write the results to buf[].
```

##### Note:

- Consider that you cannot manipulate the file directly. The file is only accessible for `read4` but not for `read`.
- The read function may be called multiple times.
- Please remember to RESET your class variables declared in Solution, as static/class variables are persisted across multiple test cases. Please see here for more details.
- You may assume the destination buffer array, `buf`, is guaranteed to have enough space for storing `n` characters.
- It is guaranteed that in a given test case the same buffer `buf` is called by `read`.


##### Example 1:

```
Input: file = "abc", queries = [1,2,1]
Output: [1,2,0]
Explanation: The test case represents the following scenario:
File file("abc");
Solution sol;
sol.read(buf, 1); // After calling your read method, buf should contain "a". We read a total of 1 character from the file, so return 1.
sol.read(buf, 2); // Now buf should contain "bc". We read a total of 2 characters from the file, so return 2.
sol.read(buf, 1); // We have reached the end of file, no more characters can be read. So return 0.
Assume buf is allocated and guaranteed to have enough space for storing all characters from the file.
```

##### Example 2:

```
Input: file = "abc", queries = [4,1]
Output: [3,0]
Explanation: The test case represents the following scenario:
File file("abc");
Solution sol;
sol.read(buf, 4); // After calling your read method, buf should contain "abc". We read a total of 3 characters from the file, so return 3.
sol.read(buf, 1); // We have reached the end of file, no more characters can be read. So return 0.
```

##### Constraints:

- `1 <= file.length <= 500`
- file consist of English letters and digits.
- `1 <= queries.length <= 101`
- `1 <= queries[i] <= 500`

## Solution

```
# Time: O(n)
# Space: O(1)
class Solution:
    buf4 = [None] * 4
    prevread = j = 0
    def read(self, buf: List[str], n: int) -> int:
        i = 0
        while i < n and self.j < self.prevread:
            buf[i] = self.buf4[self.j]
            i += 1
            self.j += 1
        
        while i < n:
            self.j = 0
            self.prevread = read4(self.buf4)
            while self.j < self.prevread:
                buf[i] = self.buf4[self.j]
                i += 1
                self.j += 1
                if i == n:
                    break
            if self.prevread < 4:
                break
        
        return i
```

## Notes
- Main difference between this problem and 157. is the `read` method can be called multiple times. This adds an edge case where there may still be some characters left in our internal buffer `buf4` between calls that need to be added to `buf` before we start getting more calls from the file with `read4`. 
- To handle this edge case, we need to raise `buf4` scope to instance level, as well as the number of characters read from the previous call to `read4` and the current index of `buf4` that has not had its corresponding element added to `buf`. This allows us to always have access to the next character to be copied to `buf` from `buf4` at all times, regardless of which call to `read` characters in `buf4` were added.