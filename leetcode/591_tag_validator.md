# 591. Tag Validator - Hard

Given a string representing a code snippet, implement a tag validator to parse the code and return whether it is valid.

A code snippet is valid if all the following rules hold:

- The code must be wrapped in a valid closed tag. Otherwise, the code is invalid.
- A closed tag (not necessarily valid) has exactly the following format : `<TAG_NAME>TAG_CONTENT</TAG_NAME>`. Among them, `<TAG_NAME>` is the start tag, and `</TAG_NAME>` is the end tag. The TAG_NAME in start and end tags should be the same. A closed tag is valid if and only if the TAG_NAME and TAG_CONTENT are valid.
- A valid `TAG_NAME` only contain upper-case letters, and has length in range [1,9]. Otherwise, the `TAG_NAME` is invalid.
- A valid `TAG_CONTENT` may contain other valid closed tags, cdata and any characters (see note1) EXCEPT unmatched `<`, unmatched start and end tag, and unmatched or closed tags with invalid TAG_NAME. Otherwise, the `TAG_CONTENT` is invalid.
- A start tag is unmatched if no end tag exists with the same TAG_NAME, and vice versa. However, you also need to consider the issue of unbalanced when tags are nested.
- A `<` is unmatched if you cannot find a subsequent `>`. And when you find a `<` or `</`, all the subsequent characters until the next `>` should be parsed as TAG_NAME (not necessarily valid).
- The cdata has the following format: `<![CDATA[CDATA_CONTENT]]>`. The range of `CDATA_CONTENT` is defined as the characters between `<![CDATA[` and the first subsequent `]]>`.
- `CDATA_CONTENT` may contain any characters. The function of cdata is to forbid the validator to parse `CDATA_CONTENT`, so even it has some characters that can be parsed as tag (no matter valid or invalid), you should treat it as regular characters.

##### Example 1:

```
Input: code = "<DIV>This is the first line <![CDATA[<div>]]></DIV>"
Output: true
Explanation: 
The code is wrapped in a closed tag : <DIV> and </DIV>. 
The TAG_NAME is valid, the TAG_CONTENT consists of some characters and cdata. 
Although CDATA_CONTENT has an unmatched start tag with invalid TAG_NAME, it should be considered as plain text, not parsed as a tag.
So TAG_CONTENT is valid, and then the code is valid. Thus return true.
```

##### Example 2:

```
Input: code = "<DIV>>>  ![cdata[]] <![CDATA[<div>]>]]>]]>>]</DIV>"
Output: true
Explanation:
We first separate the code into : start_tag|tag_content|end_tag.
start_tag -> "<DIV>"
end_tag -> "</DIV>"
tag_content could also be separated into : text1|cdata|text2.
text1 -> ">>  ![cdata[]] "
cdata -> "<![CDATA[<div>]>]]>", where the CDATA_CONTENT is "<div>]>"
text2 -> "]]>>]"
The reason why start_tag is NOT "<DIV>>>" is because of the rule 6.
The reason why cdata is NOT "<![CDATA[<div>]>]]>]]>" is because of the rule 7.
```

##### Constraints:

- `1 <= code.length <= 500`
- `code` consists of English letters, digits, `'<'`, `'>'`, `'/'`, `'!'`, `'['`, `']'`, `'.'`, and `' '`.

## Solution

```
import string

# Time: O(n)
# Space: O(d) where d is max nesting depth
class Solution:
    def isValid(self, code: str) -> bool:
        n = len(code)
        def parsetag(i, opening):
            if i == n - 1:
                return None, None
            if (opening and code[i + 1] == '/') or (not opening and code[i + 1] != '/'):
                return None, None
            start = i + 1 if opening else i + 2
            if code[start] == '>':
                return None, None
            for k in range(start, min(start + 10, n)):
                if code[k] == '>':
                    return k + 1, code[start:k + 1]
                if code[k] not in string.ascii_uppercase:
                    break
            return None, None

        def parsecdata(i):
            datastart = i + 9
            if code[i:datastart] != "<![CDATA[":
                return None
            for k in range(datastart, n - 2):
                if code[k:k + 3] == "]]>":
                    return k + 3
            return None
            
        def rec(i):
            if i == n or code[i] != '<':
                return -1, False
            x = i
            i, opentag = parsetag(i, True)
            if opentag is None or i == n:
                return -1, False
            
            while i < n:
                c = code[i]
                if c != '<':
                    i += 1
                    continue
                if i == n - 1:
                    return -1, False
                if code[i + 1] == '/':
                    i, closetag = parsetag(i, False)
                    return i, closetag == opentag
                if code[i + 1] == '!':
                    i = parsecdata(i)
                    if i is None:
                        break
                else:
                    i, validnestedtag = rec(i)
                    if not validnestedtag:
                        break
                        
            return -1, False

        i, validnesting = rec(0)
        return validnesting and i == n
```

## Notes
- Recursively parse each opening tag; there are alot of edge cases to handle in this one, most of which directly follow from the prompt. Recursion greatly simplifies handling some of these (namely, closing tags prior to the closing tag of the opening tag we are currently considering).