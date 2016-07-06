function solve = solvecheck(mat,row,col)

test = mat{row,col};
if length(test)==1
    solve = test;
else
    if isempty(test)
        solve = [];
    else
        mattemp = mat;
        mattemp{row,col} = [];
        solve = test;
        for i = 1:3
            for j = 1:3
                solve = intersect(solve,setdiff(test,mattemp{i,j}));
            end
        end
    end
end
end