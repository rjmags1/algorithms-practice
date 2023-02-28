# 609. Find Duplicate File In System - Medium

Given a list `paths` of directory info, including the directory path, and all the files with contents in this directory, return all the duplicate files in the file system in terms of their paths. You may return the answer in any order.

A group of duplicate files consists of at least two files that have the same content.

A single directory info string in the input list has the following format:

- `"root/d1/d2/.../dm f1.txt(f1_content) f2.txt(f2_content) ... fn.txt(fn_content)"`

It means there are `n` files `(f1.txt, f2.txt ... fn.txt)` with content `(f1_content, f2_content ... fn_content)` respectively in the directory `"root/d1/d2/.../dm"`. Note that `n >= 1` and `m >= 0`. If `m = 0`, it means the directory is just the root directory.

The output is a list of groups of duplicate file paths. For each group, it contains all the file paths of the files that have the same content. A file path is a string that has the following format:

- `"directory_path/file_name.txt"`


##### Example 1:

```
Input: paths = ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)","root 4.txt(efgh)"]
Output: [["root/a/2.txt","root/c/d/4.txt","root/4.txt"],["root/a/1.txt","root/c/3.txt"]]
```

##### Example 2:

```
Input: paths = ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)"]
Output: [["root/a/2.txt","root/c/d/4.txt"],["root/a/1.txt","root/c/3.txt"]]
```

##### Constraints:

- <code>1 <= paths.length <= 2 * 10<sup>4</sup></code>
- <code>1 <= paths[i].length <= 3000</code>
- <code>1 <= sum(paths[i].length) <= 5 * 10<sup>5</sup></code>
- `paths[i]` consist of English letters, digits, `'/'`, `'.'`, `'('`, `')'`, and `' '`.
- You may assume no files or directories share the same name in the same directory.
- You may assume each given directory info represents a unique directory. A single blank space separates the directory path and file info.

Follow-up:

- Imagine you are given a real file system, how will you search files? DFS or BFS?
- If the file content is very large (GB level), how will you modify your solution?
- If you can only read the file by 1kb each time, how will you modify your solution?
- What is the time complexity of your modified solution? What is the most time-consuming part and memory-consuming part of it? How to optimize?
- How to make sure the duplicated files you find are not false positive?

## Solution

```
from collections import defaultdict

# Time: O(c)
# Space: O(c)
class Solution:
    def findDuplicate(self, paths: List[str]) -> List[List[str]]:
        contents = defaultdict(list)
        for s in paths:
            entries = s.split(" ")
            dirpath = entries[0]
            for i in range(1, len(entries)):
                fileinfo = entries[i]
                k = fileinfo.index(".txt") + 4
                filename = fileinfo[:k]
                filecontents = fileinfo[k + 1:-1]
                contents[filecontents].append(dirpath + "/" + filename)
        return list(l for l in contents.values() if len(l) > 1)
```

## Notes
- Simply parse all of the path strings to determine which files have the same content via hash table, and store lists of full file paths as values in the hash table.
- Followup answers: BFS is preferable because we may end up using less memory due to avoidance of call stack, but also disk seeks times would be minimized, assuming files in the same directory are located closer together on disk. If file content is very large, we would want to use some sort of file signature as the main test for identical contents before actually checking full file content for equality; signatures could include certain metadata such as size and small content slices. If we can only read 1kb at a time, we would need to use a 1kb buffer to continuously load 1kb adjacent slices of file content. Assuming we implement the above two modifications, the time and space complexity does not change in the worst case, but the average runtime is much better because we do not compare full file contents for most comparisons, and the most time consuming part is the continuous reading into a 1kb buffer. To ensure duplicate files are not false positive simply compare full file contents in cases where we do not find a difference in file signatures.