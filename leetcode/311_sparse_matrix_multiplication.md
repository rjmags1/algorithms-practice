# 311. Sparse Matrix Multiplication - Medium

Given two sparse matrices `mat1` of size `m x k` and `mat2` of size `k x n`, return the result of `mat1 x mat2`. You may assume that multiplication is always possible.

##### Example 1:

```
Input: mat1 = [[1,0,0],[-1,0,3]], mat2 = [[7,0,0],[0,0,0],[0,0,1]]
Output: [[7,0,0],[-7,0,3]]
```

##### Example 2:

```
Input: mat1 = [[0]], mat2 = [[0]]
Output: [[0]]
```

##### Constraints:

- `m == mat1.length`
- `k == mat1[i].length == mat2.length`
- `n == mat2[i].length`
- `1 <= m, n, k <= 100`
- `-100 <= mat1[i][j], mat2[i][j] <= 100`

## Solution 1

```
# Time: O(mnk)
# Space: O(mnk)
class Solution:
    def multiply(self, mat1: List[List[int]], mat2: List[List[int]]) -> List[List[int]]:
        m, n, k = len(mat1), len(mat2[0]), len(mat1[0])
        result = []
        for row in range(m):
            result.append([])
            for col in range(n):
                curr = 0
                for c in range(k):
                    curr += mat1[row][c] * mat2[c][col]
                result[-1].append(curr)
        return result
```

## Notes
- Basic matrix multiplication. To be able to multiply `2` matrices, the first must have dimensions `m * k` and the second must have dimensions `k * n`; in other words, the width of the first matrix must equal the height of the second matrix. This product will be a matrix of dimensions `m * n`, where each cell in the product is the sum of the products of the elements of a matrix 1 row multiplied by the corresponding elements of a matrix 2 column. There will be a 1-1 correspondence of elements in these product sums because the first matrix width is the same as the second matrix heights.
- This question is kind of goofy because it wants people to treat the question as though we were reading a large matrix from a file and didn't want to copy the whole thing into memory. If this were the case, we would only want to read in the positions of nonzero elements in the first and second matrix into memory, for which the methodology is shown below. However, this is still weird because we will still be generating a matrix of potentially very large size for all inputs where `k` is of a similar magnitude order of `m`, and `n`. But we just do what the question wants.

## Solution 2

```
# Time: O(mnk)
# Space: O(mnk)
class Solution:
    def multiply(self, mat1: List[List[int]], mat2: List[List[int]]) -> List[List[int]]:
        m, n, k = len(mat1), len(mat2[0]), len(mat1[0])
        m1rows = []
        for i in range(m):
            m1rows.append([i, []])
            nz, elems = False, m1rows[-1][1]
            for j in range(k):
                num = mat1[i][j]
                if num == 0:
                    continue
                nz = True
                elems.append((j, num))
            if not nz:
                m1rows.pop()
        
        m2cols = []
        for j in range(n):
            m2cols.append([j, []])
            nz, elems = False, m2cols[-1][1]
            for i in range(k):
                num = mat2[i][j]
                if num == 0:
                    continue
                nz = True
                elems.append((i, num))
            if not nz:
                m2cols.pop()
        
        result = []
        i = 0
        for ri in range(m):
            nxtnzrow = m1rows[i][0] if i < len(m1rows) else None
            if ri != nxtnzrow:
                result.append([0] * n)
                continue
                
            result.append([])
            j = 0
            for ci in range(n):
                nxtnzcol = m2cols[j][0] if j < len(m2cols) else None
                if ci != nxtnzcol:
                    result[-1].append(0)
                    continue
                    
                nzr, nzc = m1rows[i][1], m2cols[j][1]
                curr = x = y = 0
                for rci in range(k):
                    nxtr = nzr[x] if x < len(nzr) else None
                    nxtc = nzc[y] if y < len(nzc) else None
                    if nxtr is None or nxtc is None:
                        break
                    nxtrp, nxtcp = nxtr[0], nxtc[0]
                    if nxtrp == nxtcp == rci:
                        curr += nxtr[1] * nxtc[1]
                    if nxtrp <= rci:
                        x += 1
                    if nxtcp <= rci:
                        y += 1
                    
                result[-1].append(curr)
                j += 1
                
            i += 1
                
        return result
```

## Notes
- Adapt the original solution to only "read in" nonzero values and their positions, and then generate the result matrix with this compressed data. Note how we only ever perform multiplication on matching nonzero cells.