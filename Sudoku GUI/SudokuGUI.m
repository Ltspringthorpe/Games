% This sudoku puzzle generator works by generating random numbers into a
% grid. After each computer generated number is placed, the program runs
% through all of its known solving techniques to shake out other numbers.
% When no more numbers can be logically solved for, the computer generates
% another random number, etc. The puzzle that is then presented to the user
% to solve is all of the computer generated random numbers, leaving out all
% of the numbers that the computer was able to determine logically. 



clc;
clear all; close all; warning on; warning('off','MATLAB:warn_r14_stucture_assignment')
n = 0; t = 1; s = 0;
answerGrid = 0*rand(9,9,10); computerGrid = answerGrid(:,:,1);
for k = 2:10
    answerGrid(:,:,k) = k - 1;
end


% Computer Generating the Finished Solution

% randomly generates grid values
while n<81 % n is number of squares in the 9x9 solution that are empty. solution will be done when every square has a value (when n = 81).
    row = ceil(rand*9); % randomly picks a row and column number to put a new value in
    col = ceil(rand*9);
    yes = 0;
    if answerGrid(row,col,1) == 0 % makes sure current square is empty
        while yes == 0
            yes = 1;
            % yes is a place holder variable that keeps track of whether the
            % number i want to place into the finished solution is a legal sudoku move
            
            x = 0;
            % keeps track of the number of iterations the code goes through without finding a legal number to add
            
            num = 0;
            % if num is zero the value is still allowed. if num is nonzero, in will create an impossible puzzle
            while num == 0
                x = x + 1;
                num = answerGrid(row,col,ceil(rand*9)+1);  % num now is the value i am trying to place into the grid
                if x == 50
                    n = 0; t = 1; s = 0; num = 50; yes = 0;
                    answerGrid = 0*rand(9,9,9); computerGrid = 0*rand(9);
                    for k = 2:10
                        answerGrid(:,:,k) = k - 1;
                    end
                end
            end
            
            % testing to see if putting num in the grid at coordinate (row,col) is a legal sudoku move
            if num~= 50
                for i = 1:9
                    if answerGrid(i,col,1) == num % checks all other squares in the same column for num
                        yes = 0;
                        answerGrid(i,col,num+1) = 0;
                    end
                    if answerGrid(row,i,1) == num % checks all other squares in the same row for num
                        yes = 0;
                        answerGrid(row,i,num+1) = 0;
                    end
                end
                rowBox = floor((row - 1)/3) + 1; % defines the 3x3 squares used in sudoku
                columnBox = floor((col - 1)/3) + 1;
                for a = 0:2
                    for b = 0:2
                        if answerGrid(3*rowBox - a, 3*columnBox - b,1) == num; % checks all other squares in the same 3x3 square for num
                            yes = 0;
                            answerGrid(3*rowBox - a, 3*columnBox - b,num+1) = 0;
                        end
                    end
                end
            else
                yes = 0;
            end
            if yes == 1
                answerGrid(row,col,1) = num; % places the new value into the square, woo-hoo!
                n = n + 1; t = 1;
                computerGrid(row,col) = answerGrid(row,col,1); % since this is a computer generated square, it copies over to the user's puzzle
                for i = 1:9
                    answerGrid(row,i,num+1) = 0; % with the new value in place, the code flags moves that are now ilegal in the same row
                end
                for i = 1:9
                    answerGrid(i,col,num+1) = 0; % with the new value in place, the code flags moves that are now ilegal in the same column
                end
                for i = 1:9
                    answerGrid(row,col,i+1) = 0; % with the new value in place, the code flags moves that are now ilegal in the same square
                end
                rowBox = floor((row - 1)/3) + 1; % with the new value in place, the code flags moves that are now ilegal in the same 3x3 square
                columnBox = floor((col - 1)/3) + 1;
                for a = 0:2
                    for b = 0:2
                        answerGrid(3*rowBox - a, 3*columnBox - b,num+1) = 0;
                    end
                end
            end
            if num == 50
                yes = 1;
            end
        end
    end
    if num == 50
        t = 0;
    end
    
    % searches for values in the grid that can be logically solved for
    % (runs through this algorithm until no more values can be logically
    % solved for, then returns you to section to create another random
    % generated grid value)
    while t == 1
        t = 0;
        for i = 1:9
            for j = 1:9
                val = find(answerGrid(i,j,:));
                if length(val) == 1 % determines if there is only 1 legal value remaining for each indivindual square
                    if val > 1 % if so, apply that value!
                        answerGrid(i,j,1) = val - 1;
                        n = n + 1; t = 1;
                        
                        % flags the new ilegal moves based on this new number
                        for a = 1:9
                            answerGrid(i,a,val) = 0;
                        end
                        for b = 1:9
                            answerGrid(b,j,val) = 0;
                        end
                        rowBox = floor((i - 1)/3) + 1;
                        columnBox = floor((j - 1)/3) + 1;
                        for c = 0:2
                            for d = 0:2
                                answerGrid(3*rowBox - c, 3*columnBox - d,val) = 0;
                            end
                        end
                    end
                end
            end
        end
        for k = 2:10
            for i = 1:9
                val = find(answerGrid(i,:,k));
                if length(val) == 1  % determines if there is only 1 remaining legal square in a row for each value
                    answerGrid(i,val,1) = k - 1; % if so, apply it!
                    n = n + 1; t = 1;
                    % flags the new ilegal moves based on this new number
                    for a = 2:10
                        answerGrid(i,val,a) = 0;
                    end
                    for b = 1:9
                        answerGrid(b,val,k) = 0;
                    end
                    rowBox = floor((i - 1)/3) + 1;
                    columnBox = floor((val - 1)/3) + 1;
                    for c = 0:2
                        for d = 0:2
                            answerGrid(3*rowBox - c, 3*columnBox - d,k) = 0;
                        end
                    end
                end
            end
            for j = 1:9
                val = find(answerGrid(:,j,k)); % determines if there is only 1 remaining legal square in a column for each value
                if length(val) == 1
                    answerGrid(val,j,1) = k - 1; % if so, apply it!
                    n = n + 1; t = 1;
                    % flags the new ilegal moves based on this new number
                    for a = 1:9
                        answerGrid(val,a,k) = 0;
                    end
                    for b = 2:10
                        answerGrid(val,j,b) = 0;
                    end
                    rowBox = floor((val - 1)/3) + 1;
                    columnBox = floor((j - 1)/3) + 1;
                    for c = 0:2
                        for d = 0:2
                            answerGrid(3*rowBox - c, 3*columnBox - d,k) = 0;
                        end
                    end
                end
            end
            for row = 1:3
                for col = 1:3
                    val = find(answerGrid(3*row-2:3*row,3*col-2:3*col,k)) ;% determines if there is only 1 remaining legal square in a 3x3 square for each value
                    if length(val) == 1
                        columnOffset = 0; newval = val;
                        if 4 <= val && val <= 6
                            newval = val - 3; columnOffset = 1;
                        end
                        if 7 <= val && val <=9
                            newval = val - 6; columnOffset = 2;
                        end
                        i = 3*row - 3 + newval;
                        j = 3*col - 2 + columnOffset;
                        answerGrid(i,j,1) = k-1; % if so, apply it!
                        n = n + 1; t = 1;
                        % flags the new ilegal moves based on this new number
                        for a = 1:9
                            answerGrid(i,a,k) = 0;
                        end
                        for b = 1:9
                            answerGrid(b,j,k) = 0;
                        end
                        for c = 2:10
                            answerGrid(i,j,c) = 0;
                        end
                    end
                end
            end
        end
    end
end

%Letting the User Solve the Puzzle

userGrid = 0*rand(9);
totalGrid = userGrid + computerGrid;

EditGUI(userGrid,computerGrid,answerGrid)