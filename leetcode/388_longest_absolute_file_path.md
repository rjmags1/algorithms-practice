# 388. Longest Absolute File Path - Medium

Suppose we have a file system that stores both files and directories. An example of one system is represented in the following picture:

![](../assets/388-mdir.jpg)

Here, we have `dir` as the only directory in the root. `dir` contains two subdirectories, `subdir1` and `subdir2`. `subdir1` contains a file `file1.ext` and subdirectory `subsubdir1`. `subdir2` contains a subdirectory `subsubdir2`, which contains a file `file2.ext`.

In text form, it looks like this (with ⟶ representing the tab character):

```
dir
⟶ subdir1
⟶ ⟶ file1.ext
⟶ ⟶ subsubdir1
⟶ subdir2
⟶ ⟶ subsubdir2
⟶ ⟶ ⟶ file2.ext
```

If we were to write this representation in code, it will look like this: `"dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"`. Note that the `'\n'` and `'\t'` are the new-line and tab characters.

Every file and directory has a unique absolute path in the file system, which is the order of directories that must be opened to reach the file/directory itself, all concatenated by `'/'`s. Using the above example, the absolute path to `file2.ext` is `"dir/subdir2/subsubdir2/file2.ext"`. Each directory name consists of letters, digits, and/or spaces. Each file name is of the form `name.extension`, where `name` and `extension` consist of letters, digits, and/or spaces.

Given a string `input` representing the file system in the explained format, return the length of the longest absolute path to a file in the abstracted file system. If there is no file in the system, return `0`.

Note that the testcases are generated such that the file system is valid and no file or directory name has length `0`.

##### Example 1:

```
Input: input = "dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext"
Output: 20
Explanation: We have only one file, and the absolute path is "dir/subdir2/file.ext" of length 20.
```

##### Example 2:

```
Input: input = "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
Output: 32
Explanation: We have two files:
"dir/subdir1/file1.ext" of length 21
"dir/subdir2/subsubdir2/file2.ext" of length 32.
We return 32 since it is the longest absolute path to a file.
```

##### Example 3:

```
Input: input = "a"
Output: 0
Explanation: We do not have any files, just a single directory named "a".
```

##### Constraints:

- <code>1 <= input.length <= 10<sup>4</sup></code>
- `input` may contain lowercase or uppercase English letters, a new line character `'\n'`, a tab character `'\t'`, a dot `'.'`, a space `' '`, and digits.
- All file and directory names have positive length.

## Solution

```
# Time: O(n * e) where e is number of entries (files or directories)
# Space: O(n)
class Solution:
    def getlevel(self, s, i, n):
        level = 0
        while i < n and s[i] in "\n\t":
            if s[i] == "\t":
                level += 1
            i += 1
        return level, i

    def entryinfo(self, s, i, n):
        level, i = self.getlevel(s, i, n)
        length, isfile = 0, False
        while i < n and s[i] != '\n':
            if s[i] == ".":
                isfile = True
            length += 1
            i += 1
        return level, length, isfile, i

    def lengthLongestPath(self, input: str) -> int:
        n, stack = len(input), [(-1, 0)]
        i = result = 0
        while i < n:
            level, length, isfile, i = self.entryinfo(input, i, n)
            if isfile:
                currlen = length + sum(d[1] + 1 for d in stack if d[0] < level) - 1
                result = max(result, currlen)
            while stack and stack[-1][0] >= level:
                stack.pop()
            stack.append((level, length))

        return result
```

## Notes
- Conceptually simple but difficult for a medium in terms of correctly parsing the string and handling edge cases. We store all directories currently being explored on the stack, along with the lengths of the directories to efficiently determine the absolute path for a file. Don't forget to handle `/` interpolation when calculating absolute path lengths, and do not assume there is only one directory in the root level, and do not assume the root level only has one directory.
- Note the time complexity could be trivially reduced to `O(n)` if we kept track of the length of the slash-interpolated path to the current entry as well as the index of the parent directory of the current entry for each entry added to the stack. This would allow us to calculate path length in constant time as opposed to `O(e)` time.