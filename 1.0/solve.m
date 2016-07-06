function [sudoku, len, sunit, smat, srow, scol, slen] = solve(sudoku, len, sunit, smat, srow, scol, slen)
global standard;
retry = 10;
while len&&retry
    for i = 1:9
        block_row = fix((i)/3.5)+1;
        for j = 1:9
            block_col = fix(j/3.5)+1;
            srow{j} = setdiff(standard,sudoku(j,:));
            scol{j} = setdiff(standard,sudoku(:,j));
            if sudoku(i,j)
                sunit{i,j} = [];
            else
                sunit{i,j} = intersect(intersect(srow{i},scol{j}),smat{block_row,block_col});
            end
            if(rem(i,3)==0&&rem(j,3)==0)
                mat = sunit(i-2:i,j-2:j);
                for ii = 1:3
                    for jj = 1:3
                        solve = solvecheck(mat,ii,jj);
                        slen(i+ii-3,j+jj-3) = length(sunit{i+ii-3,j+jj-3});
                        if slen(i+ii-3,j+jj-3)==1
                            sudoku(i+ii-3,j+jj-3) = solve;
                            sunit{i+ii-3,j+jj-3} = [];
                            smat{block_row,block_col} = setdiff(smat{block_row,block_col},solve);
                            len = len - 1;
                            slen(i+ii-3,j+jj-3) = slen(i+ii-3,j+jj-3) - 1;
                        end
                    end
                end
            end
        end
    end
    retry = retry - 1;
end