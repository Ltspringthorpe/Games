if exist('done','var')
    if done == 0
        str = input('Restore puzzle from last session? y/n: ','s');
        if strcmp(str,'y') == 1 || strcmp(str,'Y') == 1 || strcmp(str,'yes') == 1 || strcmp(str,'Yes') == 1
            Restorepuzzle = 1;
        else
            Restorepuzzle = 0;
        end
    end
else
    Restorepuzzle = 0;
end
clc;

if Restorepuzzle == 0
    
    clear all; close all;
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
end

%User Solving the Puzzle
if Restorepuzzle == 0
    UserGrid = 0*rand(9);
    TotalGrid = UserGrid + ComputerGrid;
end
Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',TotalGrid(1,1),TotalGrid(1,2),TotalGrid(1,3),TotalGrid(1,4),TotalGrid(1,5),TotalGrid(1,6),TotalGrid(1,7),TotalGrid(1,8),TotalGrid(1,9),TotalGrid(2,1),TotalGrid(2,2),TotalGrid(2,3),TotalGrid(2,4),TotalGrid(2,5),TotalGrid(2,6),TotalGrid(2,7),TotalGrid(2,8),TotalGrid(2,9),TotalGrid(3,1),TotalGrid(3,2),TotalGrid(3,3),TotalGrid(3,4),TotalGrid(3,5),TotalGrid(3,6),TotalGrid(3,7),TotalGrid(3,8),TotalGrid(3,9),TotalGrid(4,1),TotalGrid(4,2),TotalGrid(4,3),TotalGrid(4,4),TotalGrid(4,5),TotalGrid(4,6),TotalGrid(4,7),TotalGrid(4,8),TotalGrid(4,9),TotalGrid(5,1),TotalGrid(5,2),TotalGrid(5,3),TotalGrid(5,4),TotalGrid(5,5),TotalGrid(5,6),TotalGrid(5,7),TotalGrid(5,8),TotalGrid(5,9),TotalGrid(6,1),TotalGrid(6,2),TotalGrid(6,3),TotalGrid(6,4),TotalGrid(6,5),TotalGrid(6,6),TotalGrid(6,7),TotalGrid(6,8),TotalGrid(6,9),TotalGrid(7,1),TotalGrid(7,2),TotalGrid(7,3),TotalGrid(7,4),TotalGrid(7,5),TotalGrid(7,6),TotalGrid(7,7),TotalGrid(7,8),TotalGrid(7,9),TotalGrid(8,1),TotalGrid(8,2),TotalGrid(8,3),TotalGrid(8,4),TotalGrid(8,5),TotalGrid(8,6),TotalGrid(8,7),TotalGrid(8,8),TotalGrid(8,9),TotalGrid(9,1),TotalGrid(9,2),TotalGrid(9,3),TotalGrid(9,4),TotalGrid(9,5),TotalGrid(9,6),TotalGrid(9,7),TotalGrid(9,8),TotalGrid(9,9))
done = 0; reset = 0;
while done == 0;
    v = 100;
    while v ==100
        str = input('Row : ','s');
        i = str2double(str);
        if i == 0
            disp(' ');
            str = input('Reset? y/n: ','s');
            if strcmp(str,'y') == 1 || strcmp(str,'Y') == 1 || strcmp(str,'yes') == 1 || strcmp(str,'Yes') == 1
                reset = 1;
                UserGrid = 0*rand(9);
                TotalGrid = ComputerGrid + UserGrid;
                clc;
                Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',TotalGrid(1,1),TotalGrid(1,2),TotalGrid(1,3),TotalGrid(1,4),TotalGrid(1,5),TotalGrid(1,6),TotalGrid(1,7),TotalGrid(1,8),TotalGrid(1,9),TotalGrid(2,1),TotalGrid(2,2),TotalGrid(2,3),TotalGrid(2,4),TotalGrid(2,5),TotalGrid(2,6),TotalGrid(2,7),TotalGrid(2,8),TotalGrid(2,9),TotalGrid(3,1),TotalGrid(3,2),TotalGrid(3,3),TotalGrid(3,4),TotalGrid(3,5),TotalGrid(3,6),TotalGrid(3,7),TotalGrid(3,8),TotalGrid(3,9),TotalGrid(4,1),TotalGrid(4,2),TotalGrid(4,3),TotalGrid(4,4),TotalGrid(4,5),TotalGrid(4,6),TotalGrid(4,7),TotalGrid(4,8),TotalGrid(4,9),TotalGrid(5,1),TotalGrid(5,2),TotalGrid(5,3),TotalGrid(5,4),TotalGrid(5,5),TotalGrid(5,6),TotalGrid(5,7),TotalGrid(5,8),TotalGrid(5,9),TotalGrid(6,1),TotalGrid(6,2),TotalGrid(6,3),TotalGrid(6,4),TotalGrid(6,5),TotalGrid(6,6),TotalGrid(6,7),TotalGrid(6,8),TotalGrid(6,9),TotalGrid(7,1),TotalGrid(7,2),TotalGrid(7,3),TotalGrid(7,4),TotalGrid(7,5),TotalGrid(7,6),TotalGrid(7,7),TotalGrid(7,8),TotalGrid(7,9),TotalGrid(8,1),TotalGrid(8,2),TotalGrid(8,3),TotalGrid(8,4),TotalGrid(8,5),TotalGrid(8,6),TotalGrid(8,7),TotalGrid(8,8),TotalGrid(8,9),TotalGrid(9,1),TotalGrid(9,2),TotalGrid(9,3),TotalGrid(9,4),TotalGrid(9,5),TotalGrid(9,6),TotalGrid(9,7),TotalGrid(9,8),TotalGrid(9,9))
            else
                clc;
                Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',TotalGrid(1,1),TotalGrid(1,2),TotalGrid(1,3),TotalGrid(1,4),TotalGrid(1,5),TotalGrid(1,6),TotalGrid(1,7),TotalGrid(1,8),TotalGrid(1,9),TotalGrid(2,1),TotalGrid(2,2),TotalGrid(2,3),TotalGrid(2,4),TotalGrid(2,5),TotalGrid(2,6),TotalGrid(2,7),TotalGrid(2,8),TotalGrid(2,9),TotalGrid(3,1),TotalGrid(3,2),TotalGrid(3,3),TotalGrid(3,4),TotalGrid(3,5),TotalGrid(3,6),TotalGrid(3,7),TotalGrid(3,8),TotalGrid(3,9),TotalGrid(4,1),TotalGrid(4,2),TotalGrid(4,3),TotalGrid(4,4),TotalGrid(4,5),TotalGrid(4,6),TotalGrid(4,7),TotalGrid(4,8),TotalGrid(4,9),TotalGrid(5,1),TotalGrid(5,2),TotalGrid(5,3),TotalGrid(5,4),TotalGrid(5,5),TotalGrid(5,6),TotalGrid(5,7),TotalGrid(5,8),TotalGrid(5,9),TotalGrid(6,1),TotalGrid(6,2),TotalGrid(6,3),TotalGrid(6,4),TotalGrid(6,5),TotalGrid(6,6),TotalGrid(6,7),TotalGrid(6,8),TotalGrid(6,9),TotalGrid(7,1),TotalGrid(7,2),TotalGrid(7,3),TotalGrid(7,4),TotalGrid(7,5),TotalGrid(7,6),TotalGrid(7,7),TotalGrid(7,8),TotalGrid(7,9),TotalGrid(8,1),TotalGrid(8,2),TotalGrid(8,3),TotalGrid(8,4),TotalGrid(8,5),TotalGrid(8,6),TotalGrid(8,7),TotalGrid(8,8),TotalGrid(8,9),TotalGrid(9,1),TotalGrid(9,2),TotalGrid(9,3),TotalGrid(9,4),TotalGrid(9,5),TotalGrid(9,6),TotalGrid(9,7),TotalGrid(9,8),TotalGrid(9,9))
            end
        else
            while i > 9 || i < 1 || floor(i) ~= i
                disp(' ');disp('Must be a number 1 - 9.');disp(' ');
                str = input('Row : ','s');
                i = str2double(str);
            end
            str = input('Column : ','s');
            j = str2double(str);
            while j > 9 || j < 1 || floor(j) ~= j
                disp(' ');disp('Must be a number 1 - 9.');disp(' ');
                str = input('Column : ','s');
                j = str2double(str);
            end
            if ComputerGrid(i,j) ~= 0;
                disp(' '); disp('Cannot change an original number.'); disp(' ');
            else
                str = input('Value : ','s');
                v = str2double(str);
                while v > 9 || v < 0 || floor(v) ~= v
                    disp(' ');disp('Must be a number 0 - 9.');disp(' ');
                    str = input('Value : ','s');
                    v = str2double(str);
                end
                UserGrid(i,j) = v;
                TotalGrid = UserGrid + ComputerGrid;
            end
        end
    end
    clc;
    Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',TotalGrid(1,1),TotalGrid(1,2),TotalGrid(1,3),TotalGrid(1,4),TotalGrid(1,5),TotalGrid(1,6),TotalGrid(1,7),TotalGrid(1,8),TotalGrid(1,9),TotalGrid(2,1),TotalGrid(2,2),TotalGrid(2,3),TotalGrid(2,4),TotalGrid(2,5),TotalGrid(2,6),TotalGrid(2,7),TotalGrid(2,8),TotalGrid(2,9),TotalGrid(3,1),TotalGrid(3,2),TotalGrid(3,3),TotalGrid(3,4),TotalGrid(3,5),TotalGrid(3,6),TotalGrid(3,7),TotalGrid(3,8),TotalGrid(3,9),TotalGrid(4,1),TotalGrid(4,2),TotalGrid(4,3),TotalGrid(4,4),TotalGrid(4,5),TotalGrid(4,6),TotalGrid(4,7),TotalGrid(4,8),TotalGrid(4,9),TotalGrid(5,1),TotalGrid(5,2),TotalGrid(5,3),TotalGrid(5,4),TotalGrid(5,5),TotalGrid(5,6),TotalGrid(5,7),TotalGrid(5,8),TotalGrid(5,9),TotalGrid(6,1),TotalGrid(6,2),TotalGrid(6,3),TotalGrid(6,4),TotalGrid(6,5),TotalGrid(6,6),TotalGrid(6,7),TotalGrid(6,8),TotalGrid(6,9),TotalGrid(7,1),TotalGrid(7,2),TotalGrid(7,3),TotalGrid(7,4),TotalGrid(7,5),TotalGrid(7,6),TotalGrid(7,7),TotalGrid(7,8),TotalGrid(7,9),TotalGrid(8,1),TotalGrid(8,2),TotalGrid(8,3),TotalGrid(8,4),TotalGrid(8,5),TotalGrid(8,6),TotalGrid(8,7),TotalGrid(8,8),TotalGrid(8,9),TotalGrid(9,1),TotalGrid(9,2),TotalGrid(9,3),TotalGrid(9,4),TotalGrid(9,5),TotalGrid(9,6),TotalGrid(9,7),TotalGrid(9,8),TotalGrid(9,9))
    done = 1;
    if length(find(TotalGrid)) ~= 81
        done = 0;
    else
        E = AnswerGrid(:,:,1) - ComputerGrid(:,:) - UserGrid(:,:);
        if find(E) > 0
            disp('You lose! Good day sir!'); disp(' '); disp('(Sorry, something is wrong. Keep trying.)'); disp(' ');
            done = 0;
        end
    end
end
disp('Huzzah! You rock!'); disp(' '); disp('<fireworks>'); disp(' ');
done = 1;