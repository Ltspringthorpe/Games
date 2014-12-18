if exist('done','var')
    if done == 0
        Restorepuzzle = input('Restore puzzle from last session? Yes = 1 / No = 0 : ');
    else
        Restorepuzzle = 0;
    end
else
    Restorepuzzle = 0;
end
clc;

if Restorepuzzle == 0

clear all; close all;
n = 0; z = 0; t = 1; s = 0;
A = 0*rand(9,9,9); B = 0*rand(9);
Restorepuzzle = 0;
for k = 2:10
    A(:,:,k) = k - 1;
end

%Creating the Finished Solution
while n<81
    row = ceil(rand*9);
    col = ceil(rand*9);
    yes = 0;
    if A(row,col,1) == 0
        while yes == 0
            yes = 1; num = 0; x = 0;
            while num == 0
                x = x + 1;
                kk = ceil(rand*9);
                num = A(row,col,kk+1);
                if x == 50
                    n = 0; z = 0; t = 1; s = 0; num = 50;
                    A =0*rand(9,9,9); B = 0*rand(9);
                    for k = 2:10
                        A(:,:,k) = k - 1;
                    end
                end
            end
            for i = 1:9
                if A(i,col,1) == num
                    yes = 0;
                    A(i,col,num+1) = 0;
                end
                if A(row,i,1) == num
                    yes = 0;
                    A(row,i,num+1) = 0;
                end
            end
            rowbox = floor((row - 1)/3) + 1;
            colbox = floor((col - 1)/3) + 1;
            for a = 0:2
                for b = 0:2
                    if A(3*rowbox - a, 3*colbox - b,1) == num;
                        yes = 0;
                        A(3*rowbox - a, 3*colbox - b,num+1) = 0;
                    end
                end
            end
            if num == 50
                yes = 0;
            end
            if yes == 1
                A(row,col,1) = num;
                 n = n + 1; t = 1;
                 B(row,col) = A(row,col,1);
                 for i = 1:9
                     A(row,i,num+1) = 0;
                 end
                 for i = 1:9
                     A(i,col,num+1) = 0;
                 end
                 for i = 1:9
                    A(row,col,i+1) = 0;
                 end
                 rowbox = floor((row - 1)/3) + 1;
                 colbox = floor((col - 1)/3) + 1;
                 for a = 0:2
                     for b = 0:2
                         A(3*rowbox - a, 3*colbox - b,num+1) = 0;
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
                val = find(A(i,j,:));
                if length(val) == 1    
                    if val > 1
                        A(i,j,1) = val - 1;
                        n = n + 1; t = 1; z = z + 1;
                        for a = 1:9
                            A(i,a,val) = 0;
                        end
                        for b = 1:9
                            A(b,j,val) = 0;
                        end
                        rowbox = floor((i - 1)/3) + 1;
                        colbox = floor((j - 1)/3) + 1;
                        for c = 0:2
                            for d = 0:2
                                A(3*rowbox - c, 3*colbox - d,val) = 0;
                            end
                        end
                     end
                end
            end
        end
        for k = 2:10
            for i = 1:9
                val = find(A(i,:,k));
                if length(val) == 1
                    A(i,val,1) = k - 1;
                    n = n + 1; t = 1;
                    for a = 2:10
                        A(i,val,a) = 0;
                    end
                    for b = 1:9
                        A(b,val,k) = 0;
                    end
                    rowbox = floor((i - 1)/3) + 1;
                    colbox = floor((val - 1)/3) + 1;
                    for c = 0:2
                        for d = 0:2
                            A(3*rowbox - c, 3*colbox - d,k) = 0;
                        end
                    end
                end
            end
        end
        for k = 2:10
            for j = 1:9
                val = find(A(:,j,k));
                if length(val) == 1
                    A(val,j,1) = k - 1;
                    n = n + 1; t = 1;
                    for a = 1:9
                        A(val,a,k) = 0;
                    end
                    for b = 2:10
                        A(val,j,b) = 0;
                    end
                    rowbox = floor((val - 1)/3) + 1;
                    colbox = floor((j - 1)/3) + 1;
                    for c = 0:2
                        for d = 0:2
                            A(3*rowbox - c, 3*colbox - d,k) = 0;
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
    C = 0*rand(9); 
    D = C + B;
end
Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',D(1,1),D(1,2),D(1,3),D(1,4),D(1,5),D(1,6),D(1,7),D(1,8),D(1,9),D(2,1),D(2,2),D(2,3),D(2,4),D(2,5),D(2,6),D(2,7),D(2,8),D(2,9),D(3,1),D(3,2),D(3,3),D(3,4),D(3,5),D(3,6),D(3,7),D(3,8),D(3,9),D(4,1),D(4,2),D(4,3),D(4,4),D(4,5),D(4,6),D(4,7),D(4,8),D(4,9),D(5,1),D(5,2),D(5,3),D(5,4),D(5,5),D(5,6),D(5,7),D(5,8),D(5,9),D(6,1),D(6,2),D(6,3),D(6,4),D(6,5),D(6,6),D(6,7),D(6,8),D(6,9),D(7,1),D(7,2),D(7,3),D(7,4),D(7,5),D(7,6),D(7,7),D(7,8),D(7,9),D(8,1),D(8,2),D(8,3),D(8,4),D(8,5),D(8,6),D(8,7),D(8,8),D(8,9),D(9,1),D(9,2),D(9,3),D(9,4),D(9,5),D(9,6),D(9,7),D(9,8),D(9,9))
done = 0; reset = 0;
while done == 0;
    v = 100;
    while v ==100
        i = input('Row : ');
        if i == 0
            disp(' ');
            reset = input('Reset? Yes = 1 / No = 0 : ');
            if reset == 1
                C = 0*rand(9);
                D = B + C;
                clc; 
                Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',D(1,1),D(1,2),D(1,3),D(1,4),D(1,5),D(1,6),D(1,7),D(1,8),D(1,9),D(2,1),D(2,2),D(2,3),D(2,4),D(2,5),D(2,6),D(2,7),D(2,8),D(2,9),D(3,1),D(3,2),D(3,3),D(3,4),D(3,5),D(3,6),D(3,7),D(3,8),D(3,9),D(4,1),D(4,2),D(4,3),D(4,4),D(4,5),D(4,6),D(4,7),D(4,8),D(4,9),D(5,1),D(5,2),D(5,3),D(5,4),D(5,5),D(5,6),D(5,7),D(5,8),D(5,9),D(6,1),D(6,2),D(6,3),D(6,4),D(6,5),D(6,6),D(6,7),D(6,8),D(6,9),D(7,1),D(7,2),D(7,3),D(7,4),D(7,5),D(7,6),D(7,7),D(7,8),D(7,9),D(8,1),D(8,2),D(8,3),D(8,4),D(8,5),D(8,6),D(8,7),D(8,8),D(8,9),D(9,1),D(9,2),D(9,3),D(9,4),D(9,5),D(9,6),D(9,7),D(9,8),D(9,9))
            else
                clc;
               	Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',D(1,1),D(1,2),D(1,3),D(1,4),D(1,5),D(1,6),D(1,7),D(1,8),D(1,9),D(2,1),D(2,2),D(2,3),D(2,4),D(2,5),D(2,6),D(2,7),D(2,8),D(2,9),D(3,1),D(3,2),D(3,3),D(3,4),D(3,5),D(3,6),D(3,7),D(3,8),D(3,9),D(4,1),D(4,2),D(4,3),D(4,4),D(4,5),D(4,6),D(4,7),D(4,8),D(4,9),D(5,1),D(5,2),D(5,3),D(5,4),D(5,5),D(5,6),D(5,7),D(5,8),D(5,9),D(6,1),D(6,2),D(6,3),D(6,4),D(6,5),D(6,6),D(6,7),D(6,8),D(6,9),D(7,1),D(7,2),D(7,3),D(7,4),D(7,5),D(7,6),D(7,7),D(7,8),D(7,9),D(8,1),D(8,2),D(8,3),D(8,4),D(8,5),D(8,6),D(8,7),D(8,8),D(8,9),D(9,1),D(9,2),D(9,3),D(9,4),D(9,5),D(9,6),D(9,7),D(9,8),D(9,9))
            end
        else
            while i > 9 || i< 1 || floor(i) ~= i
                disp(' ');disp('Must be a number 1 - 9.');disp(' ');
                i = input('Row : ');
            end
            j = input('Column : ');
            while j > 9 || j < 1 || floor(j) ~= j
                disp(' ');disp('Must be a number 1 - 9.');disp(' ');
                j = input('Column : ');                
            end
            if B(i,j) ~= 0;
                disp(' '); disp('Cannot change an original number.'); disp(' ');
            else                
                v = input('Value : ');
                while v > 9 || v < 0 || floor(v) ~= v
                    disp(' ');disp('Must be a number 0 - 9.');disp(' ');
                    v = input('Value : ');
                end
                C(i,j) = v;
                D = C + B;                
            end
        end
    end
    clc;
    Puzzle = sprintf('     1  2  3   4  5  6   7  8  9\n    -----------------------------\n 1 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 2 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 3 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 4 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 5 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 6 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------\n 7 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 8 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n 9 | %d  %d  %d | %d  %d  %d | %d  %d  %d |\n    -----------------------------',D(1,1),D(1,2),D(1,3),D(1,4),D(1,5),D(1,6),D(1,7),D(1,8),D(1,9),D(2,1),D(2,2),D(2,3),D(2,4),D(2,5),D(2,6),D(2,7),D(2,8),D(2,9),D(3,1),D(3,2),D(3,3),D(3,4),D(3,5),D(3,6),D(3,7),D(3,8),D(3,9),D(4,1),D(4,2),D(4,3),D(4,4),D(4,5),D(4,6),D(4,7),D(4,8),D(4,9),D(5,1),D(5,2),D(5,3),D(5,4),D(5,5),D(5,6),D(5,7),D(5,8),D(5,9),D(6,1),D(6,2),D(6,3),D(6,4),D(6,5),D(6,6),D(6,7),D(6,8),D(6,9),D(7,1),D(7,2),D(7,3),D(7,4),D(7,5),D(7,6),D(7,7),D(7,8),D(7,9),D(8,1),D(8,2),D(8,3),D(8,4),D(8,5),D(8,6),D(8,7),D(8,8),D(8,9),D(9,1),D(9,2),D(9,3),D(9,4),D(9,5),D(9,6),D(9,7),D(9,8),D(9,9))
    done = 1;
    if length(find(D)) ~= 81
        done = 0;
    else
        E = A(:,:,1) - B(:,:) - C(:,:);
        if find(E) > 0
            disp('You lose! Good day sir!'); disp(' '); disp('(Sorry, something is wrong. Keep trying.)'); disp(' ');
            done = 0;
        end
    end
end
disp('Huzzah! You rock!'); disp(' '); disp('<fireworks>'); disp(' ');
done = 1;