function[Deck,Yousplit1,Yousplit2,Money,Bet,i,j,Ruperthit,split] = Split(Deck,You,Rupert,Money,Bet,i,Ruperthit)
split = 1; j = 3; doublesplit = 0;

%Hand 1
split1 = Deck(i);
i = i + 1;
if i == 53
    [Deck i]= Shuffle;
end
Yousplit1 = [You(1) split1];
hit = 20;

%Hand 2
split2 = Deck(i);
i = i + 1;
if i == 53
    [Deck i]= Shuffle;
end
Yousplit2 = [You(2) split2];

%Hand 1
clc; disp(['Money = ', num2str(Money)]);
if You(1) == 1
    hit = 0;
else
    disp(' ');disp(['Hand 1: ', num2str(Yousplit1),'    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ')
end

while hit ~= 0;
    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
    while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3
        disp(' ');disp(' Dumbass');disp(' ')
        hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
    end
    
    %Double Down & Split
    go = 0;
    while go == 0
        go  = 1;
        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3
            go = 0;
            disp(' ');disp(' Dumbass');disp(' ')
            hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
        end
        if hit == 2 || hit == 3
            if sum(You) ~= 9 && sum(You) ~= 10 && sum(You) ~= 11 || length(You) > 2
                while hit == 2
                    go = 0;
                    disp(' ');disp(' To double down, your cards must total 9, 10, or 11.');disp(' ');
                    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                end
            end
            while hit == 3
                go = 0;
                disp('  ');disp(' Rupert aint that good yet.');disp('  ')
                hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
            end
            if Money - 3*Bet < 0
                while hit == 2
                    go = 0;
                    disp(' ');disp(' You dont have enough money to double down');disp(' ');
                    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                end
            end
        end
        if hit == 0 || hit == 1
            go = 1;
        end
    end
    
    if hit == 2
        doublesplit = 1;
        [Deck Yousplit1 i] = Double(Deck,You,Rupert,i);
        hit = 0;
    end
    
    if hit == 1
        j = 3;
        [Deck Yousplit1 Money Bet i Ruperthit split] = Hitting(Deck,You,Rupert,Money,Bet,i,j,Ruperthit,split);
        hit = 0;
    end
end


%Hand 2
clc; disp(['Money = ', num2str(Money)]);
if You(1) == 1
    hit = 0;
else
    disp(' ');disp(['Hand 2: ', num2str(Yousplit2),'    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ');
    hit = 20;
end
You = Yousplit2; split = 2;

while hit ~= 0;
    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
    while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3
        disp(' ');disp(' Dumbass');disp(' ')
        hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
    end
    
    %Double Down & Split
    go = 0;
    while go == 0
        go  = 1;
        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3
            go = 0;
            disp(' ');disp(' Dumbass');disp(' ')
            hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
        end
        if hit == 2 || hit == 3
            if sum(You) ~= 9 && sum(You) ~= 10 && sum(You) ~= 11 || length(You) > 2
                while hit == 2
                    go = 0;
                    disp(' ');disp(' To double down, your cards must total 9, 10, or 11.');disp(' ');
                    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                end
            end
            while hit == 3
                go = 0;
                disp('  ');disp(' Rupert aint that good yet');disp('  ')
                hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
            end
            if Money - 3*Bet < 0
                while hit == 2
                    go = 0;
                    disp(' ');disp(' You dont have enough money to double down');disp(' ');
                    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                end
            end
            if doublesplit == 1 && Money - 4*Bet < 0
                while hit == 2
                    go = 0;
                    disp(' ');disp(' You dont have enough money to double down');disp(' ');
                    hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2 : ');
                end
            end
        end
        if hit == 0 || hit == 1
            go = 1;
        end
    end
    
    if hit == 2
        [Deck Yousplit2 i] = Double(Deck,You,Rupert,i);
        hit = 0;
    end
    
    if hit == 1
        j = 3;
        [Deck Yousplit2 Money Bet i Ruperthit split] = Hitting(Deck,You,Rupert,Money,Bet,i,j,Ruperthit,split);
        hit = 0;
    end
end
hit = 0; split = 1;