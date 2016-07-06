clear;
clc;
standard = [1;2;3;4;5;6;7;8;9];
sudoku = load('data.txt')
%%
[zrow,~] = find(sudoku==0);
len = length(zrow);                                         %find out the amount of zero elements.
solveunit = cell(9);
smat = cell(3);

for i = 0:2
    for j = 0:2
        mattemp = sudoku(3*i+1:3*i+3,3*j+1:3*j+3);          %divide the sudo to 9 blocks which each contaions 3X3 elements. and find the missing elements for each 3X3
        smat{i+1,j+1} = setdiff(standard,mattemp);          
    end
end

while len                                                   %while loop
    for i = 1:9
        block_row = fix((i)/3.5)+1;                         %find out which block row does the i row belongs to.
        for j = 1:9
            block_col = fix(j/3.5)+1;
            srowp{j} = setdiff(standard,sudoku(j,:));       %find out the missing elements in j row
            scolp{j} = setdiff(standard,sudoku(:,j));       %find out the missing elements in j column
            if sudoku(i,j)                                  
                solveunit{i,j} = [];                        %if this postion is not zero, clear the solveunit's elements, solveunit contains the missing elements for each position in soduku, which means this matrix is 9X9, 
            else
                solveunit{i,j} = intersect(intersect(srowp{i},scolp{j}),smat{block_row,block_col});     %else, update the solveunit's elements
            end
            if(rem(i,3)==0&&rem(j,3)==0)
                mat = solveunit(i-2:i,j-2:j);
                for ii = 1:3
                    for jj = 1:3
                        solve = solvecheck(mat,ii,jj);
                        if length(solve)==1
                            sudoku(i+ii-3,j+jj-3) = solve;
                            solveunit{i+ii-3,j+jj-3} = [];
                            smat{block_row,block_col} = setdiff(smat{block_row,block_col},solve);
                            len = len - 1;
                        end
                    end
                end
            end
        end
    end
end
sudoku        
