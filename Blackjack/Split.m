function[deck,youSplit1,youSplit2,yourMoney,bet,i,j,rupertHit,split] = Split(deck,you,rupert,yourMoney,bet,i,rupertHit)
split = 1; j = 3; doublesplit = 0;

% Hand 1

split1 = deck(i);
% you are given one card from your original hand and a new card from the
% deck as your first split hand
i = i + 1;
if i == 53
    [deck, i]= Shuffle;
end
youSplit1 = [you(1) split1];
hit = 20;

clc; disp(['Your money = ', num2str(yourMoney)]);
if you(1) == 1
    hit = 0;
else
    disp(' ');disp(['Hand 1: ', num2str(youSplit1),'    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ')
end

while hit ~= 0;
    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
    hit = str2double(str);
    while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
        disp(' ');disp(' Dumbass');disp(' ');
        str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
        hit = str2double(str);
    end
    
    %Double Down & Split
    go = 0;
    while go == 0
        go  = 1;
        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
            go = 0;
            disp(' ');disp(' Dumbass');disp(' ')
            str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
            hit = str2double(str);
        end
        if hit == 2 || hit == 3
            if sum(you) ~= 9 && sum(you) ~= 10 && sum(you) ~= 11 || length(you) > 2
                while hit == 2
                    go = 0;
                    disp(' ');disp(' To double down, your cards must total 9, 10, or 11.');disp(' ');
                    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                    hit = str2double(str);                
                end
            end
            while hit == 3
                go = 0;
                disp('  ');disp(' Rupert aint that good yet.');disp('  ')
                str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                hit = str2double(str);            
            end
            if yourMoney - 3*bet < 0
                while hit == 2
                    go = 0;
                    disp(' ');disp(' You dont have enough money to double down');disp(' ');
                    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                    hit = str2double(str);                
                end
            end
        end
        if hit == 0 || hit == 1
            go = 1;
        end     
    end
    
    if hit == 2
        doublesplit = 1;
        [deck, youSplit1, i] = Double(deck,you,rupert,i);
        hit = 0;
    end
    
    if hit == 1
        j = 3;
        [deck, youSplit1, yourMoney, bet, i, rupertHit, split] = Hitting(deck,you,rupert,yourMoney,bet,i,j,rupertHit,split);
        hit = 0;
    end
end


% Hand 2

split2 = deck(i);
% you are given the second card from your original hand and a new card from the
% deck as your second split hand
i = i + 1;
if i == 53
    [deck, i]= Shuffle;
end
youSplit2 = [you(2) split2];

clc; disp(['Your money = ', num2str(yourMoney)]);
if you(1) == 1
    hit = 0;
else
    disp(' ');disp(['Hand 2: ', num2str(youSplit2),'    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ');
    hit = 20;
end
you = youSplit2; split = 2;

while hit ~= 0;
    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
    hit = str2double(str);    
    while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
        disp(' ');disp(' Dumbass');disp(' ')
        str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
        hit = str2double(str);    
    end
    
    %Double Down & Split
    go = 0;
    while go == 0
        go  = 1;
        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
            go = 0;
            disp(' ');disp(' Dumbass');disp(' ')
            str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
            hit = str2double(str);        
        end
        if hit == 2 || hit == 3
            if sum(you) ~= 9 && sum(you) ~= 10 && sum(you) ~= 11 || length(you) > 2
                while hit == 2
                    go = 0;
                    disp(' ');disp(' To double down, your cards must total 9, 10, or 11.');disp(' ');
                    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                    hit = str2double(str);                
                end
            end
            while hit == 3
                go = 0;
                disp('  ');disp(' Rupert aint that good yet');disp('  ')
                str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                hit = str2double(str);            
            end
            if yourMoney - 3*bet < 0
                while hit == 2
                    go = 0;
                    disp(' ');disp(' You dont have enough money to double down');disp(' ');
                    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                    hit = str2double(str);                
                end
            end
            if doublesplit == 1 && yourMoney - 4*bet < 0
                while hit == 2
                    go = 0;
                    disp(' ');disp(' You dont have enough money to double down');disp(' ');
                    str = input('Hit? Stay = 0, Hit = 1, Double Down = 2 : ','s');
                    hit = str2double(str);                
                end
            end
        end
        if hit == 0 || hit == 1
            go = 1;
        end
    end
    
    if hit == 2
        [deck, youSplit2, i] = Double(deck,you,rupert,i);
        hit = 0;
    end
    
    if hit == 1
        j = 3;
        [deck, youSplit2, yourMoney, bet, i, rupertHit, split] = Hitting(deck,you,rupert,yourMoney,bet,i,j,rupertHit,split);
        hit = 0;
    end
end
hit = 0; split = 1;