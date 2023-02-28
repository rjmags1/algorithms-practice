# 588. Design In-Memory File System - Hard

Design a data structure that simulates an in-memory file system.

Implement the `FileSystem` class:

- `FileSystem()` Initializes the object of the system.
- `List<String> ls(String path)`
    - If `path` is a file path, returns a list that only contains this file's name.
    - If `path` is a directory path, returns the list of file and directory names in this directory.
- The answer should in lexicographic order.
- `void mkdir(String path)` Makes a new directory according to the given `path`. The given directory path does not exist. If the middle directories in the path do not exist, you should create them as well.
- `void addContentToFile(String filePath, String content)`
    - If `filePath` does not exist, creates that file containing given `content`.
    - If `filePath` already exists, appends the given content to original `content`.
- `String readContentFromFile(String filePath)` Returns the content in the file at `filePath`.


##### Example 1:

```
Input
["FileSystem", "ls", "mkdir", "addContentToFile", "ls", "readContentFromFile"]
[[], ["/"], ["/a/b/c"], ["/a/b/c/d", "hello"], ["/"], ["/a/b/c/d"]]
Output
[null, [], null, null, ["a"], "hello"]

Explanation
FileSystem fileSystem = new FileSystem();
fileSystem.ls("/");                         // return []
fileSystem.mkdir("/a/b/c");
fileSystem.addContentToFile("/a/b/c/d", "hello");
fileSystem.ls("/");                         // return ["a"]
fileSystem.readContentFromFile("/a/b/c/d"); // return "hello"
```

##### Constraints:

- `1 <= path.length, filePath.length <= 100`
- `path` and `filePath` are absolute paths which begin with `'/'` and do not end with `'/'` except that the path is just `"/"`.
- You can assume that all directory names and file names only contain lowercase letters, and the same names will not exist in the same directory.
- You can assume that all operations will be passed valid parameters, and users will not attempt to retrieve file content or list a directory or file that does not exist.
- `1 <= content.length <= 50`
- At most `300` calls will be made to `ls`, `mkdir`, `addContentToFile`, and `readContentFromFile`.

## Solution

```
class Entry:
    def __init__(self, name, isdir=True, content=None):
        self.name = name
        self.isdir = isdir
        self.content = content
        self.children = {}
    
    def addtodir(self, entry):
        self.children[entry.name] = entry

# Overall Space: O(n) where n is number of entries
class FileSystem:
    # Time: O(1)
    def __init__(self):
        self.root = Entry("root")

    # Time: O(nlog(n))
    def ls(self, path: str) -> List[str]:
        entries, curr = path.split("/"), self.root
        if path != "/":
            for i in range(1, len(entries)):
                curr = curr.children[entries[i]]
        return sorted(list(curr.children.keys())) if curr.isdir else [curr.name]

    # Time: O(n)
    def mkdir(self, path: str) -> None:
        entries, curr = path.split("/"), self.root
        for i in range(1, len(entries)):
            if entries[i] not in curr.children:
                curr.children[entries[i]] = Entry(entries[i])
            curr = curr.children[entries[i]]

    # Time: O(n)
    def addContentToFile(self, filePath: str, content: str) -> None:
        entries, curr = filePath.split("/"), self.root
        for i in range(1, len(entries)):
            if entries[i] not in curr.children:
                curr.children[entries[i]] = Entry(entries[i])
            curr = curr.children[entries[i]]
        curr.isdir = False
        curr.content = curr.content + content if curr.content is not None else content

    # Time: O(n)
    def readContentFromFile(self, filePath: str) -> str:
        entries, curr = filePath.split("/"), self.root
        for i in range(1, len(entries)):
            if entries[i] not in curr.children:
                curr.children[entries[i]] = Entry(entries[i])
            curr = curr.children[entries[i]]
        return curr.content
```

## Notes
- Straightforward for a hard, nested list of hash tables with some metadata associated with each hash table. Be sure to handle sorting for `ls` as well as the `'/'` special case path.