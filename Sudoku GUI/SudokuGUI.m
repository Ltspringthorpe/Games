clc;
clear all; close all; warning off;
n = 0; z = 0; t = 1; s = 0;
AnswerGrid = 0*rand(9,9,9); ComputerGrid = 0*rand(9);
Restorepuzzle = 0;
for k = 2:10
    AnswerGrid(:,:,k) = k - 1;
end

%Creating the Finished Solution
while n<81
    row = ceil(rand*9);
    col = ceil(rand*9);
    yes = 0;
    if AnswerGrid(row,col,1) == 0
        while yes == 0
            yes = 1; num = 0; x = 0;
            while num == 0
                x = x + 1;
                kk = ceil(rand*9);
                num = AnswerGrid(row,col,kk+1);
                if x == 50
                    n = 0; z = 0; t = 1; s = 0; num = 50;
                    AnswerGrid =0*rand(9,9,9); ComputerGrid = 0*rand(9);
                    for k = 2:10
                        AnswerGrid(:,:,k) = k - 1;
                    end
                end
            end
            for i = 1:9
                if AnswerGrid(i,col,1) == num
                    yes = 0;
                    AnswerGrid(i,col,num+1) = 0;
                end
                if AnswerGrid(row,i,1) == num
                    yes = 0;
                    AnswerGrid(row,i,num+1) = 0;
                end
            end
            rowbox = floor((row - 1)/3) + 1;
            colbox = floor((col - 1)/3) + 1;
            for a = 0:2
                for b = 0:2
                    if AnswerGrid(3*rowbox - a, 3*colbox - b,1) == num;
                        yes = 0;
                        AnswerGrid(3*rowbox - a, 3*colbox - b,num+1) = 0;
                    end
                end
            end
            if num == 50
                yes = 0;
            end
            if yes == 1
                AnswerGrid(row,col,1) = num;
                n = n + 1; t = 1;
                ComputerGrid(row,col) = AnswerGrid(row,col,1);
                for i = 1:9
                    AnswerGrid(row,i,num+1) = 0;
                end
                for i = 1:9
                    AnswerGrid(i,col,num+1) = 0;
                end
                for i = 1:9
                    AnswerGrid(row,col,i+1) = 0;
                end
                rowbox = floor((row - 1)/3) + 1;
                colbox = floor((col - 1)/3) + 1;
                for a = 0:2
                    for b = 0:2
                        AnswerGrid(3*rowbox - a, 3*colbox - b,num+1) = 0;
                    end
                end
            end
            if num == 50
                yes = 1;
            end
            if yes == 0
            end
        end
    end
    if num == 50
        t = 0;
    end
    while t == 1
        t = 0;
        for i = 1:9
            for j = 1:9
                val = find(AnswerGrid(i,j,:));
                if length(val) == 1
                    if val > 1
                        AnswerGrid(i,j,1) = val - 1;
                        n = n + 1; t = 1; z = z + 1;
                        for a = 1:9
                            AnswerGrid(i,a,val) = 0;
                        end
                        for b = 1:9
                            AnswerGrid(b,j,val) = 0;
                        end
                        rowbox = floor((i - 1)/3) + 1;
                        colbox = floor((j - 1)/3) + 1;
                        for c = 0:2
                            for d = 0:2
                                AnswerGrid(3*rowbox - c, 3*colbox - d,val) = 0;
                            end
                        end
                    end
                end
            end
        end
        for k = 2:10
            for i = 1:9
                val = find(AnswerGrid(i,:,k));
                if length(val) == 1
                    AnswerGrid(i,val,1) = k - 1;
                    n = n + 1; t = 1;
                    for a = 2:10
                        AnswerGrid(i,val,a) = 0;
                    end
                    for b = 1:9
                        AnswerGrid(b,val,k) = 0;
                    end
                    rowbox = floor((i - 1)/3) + 1;
                    colbox = floor((val - 1)/3) + 1;
                    for c = 0:2
                        for d = 0:2
                            AnswerGrid(3*rowbox - c, 3*colbox - d,k) = 0;
                        end
                    end
                end
            end
        end
        for k = 2:10
            for j = 1:9
                val = find(AnswerGrid(:,j,k));
                if length(val) == 1
                    AnswerGrid(val,j,1) = k - 1;
                    n = n + 1; t = 1;
                    for a = 1:9
                        AnswerGrid(val,a,k) = 0;
                    end
                    for b = 2:10
                        AnswerGrid(val,j,b) = 0;
                    end
                    rowbox = floor((val - 1)/3) + 1;
                    colbox = floor((j - 1)/3) + 1;
                    for c = 0:2
                        for d = 0:2
                            AnswerGrid(3*rowbox - c, 3*colbox - d,k) = 0;
                        end
                    end
                end
            end
        end
    end
end

%User Solving the Puzzle
UserGrid = 0*rand(9);
TotalGrid = UserGrid + ComputerGrid;
    
EditGUI(UserGrid,ComputerGrid,AnswerGrid)