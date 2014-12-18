clear all; clc;
[Deck i]= Shuffle;
Money = 1000;

disp('Welcome to Black Jack!');disp('Rupert will be glad to take all of your money now.');disp(' ');

%The Round
while Money > 0;
    
    %Bet
    disp(['Money = ', num2str(Money)]);
    disp(' ');Bet = input('Bet : ');
    while Bet > Money || Bet <= 0
        disp(' ');disp(' Cheater');disp(' ');
        Bet = input('Bet : ');
    end
    
    %The Initial Deal
    You(1) = Deck(i);
    i = i + 1;
    if i == 53
        [Deck i]= Shuffle;
    end
    Rupert(1) = Deck(i);
    i = i + 1;
    if i == 53
        [Deck i]= Shuffle;
    end
    You(2) = Deck(i);
    i = i + 1;
    if i == 53
        [Deck i]= Shuffle;
    end
    Rupert(2) = Deck(i);
    i = i + 1;
    if i == 53
        [Deck i]= Shuffle;
    end
    clc;
    disp(['Money = ', num2str(Money)]);
    if Rupert(1) == 1 && Rupert(1) ~= 10
        disp(' ');disp(['You: ', num2str(You), '    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ');
    end
    hit = 1; split = 0; ace = 0; bj = 0;
    
    %Insurance
    Ruperthit = 1;
    if Rupert(1) == 1
        insurance = input('Insurance? Yes = 1, No = 0 : ');disp(' ')
        while insurance ~= 1 && insurance ~= 0
            disp(' Dumbass');disp(' ')
            insurance = input('Insurance? Yes = 1, No = 0 : ');disp(' ')
        end
        if insurance == 1;
            insuranceamount = input('How much? (Up to one half of your bet) : ');disp(' ')
            while insuranceamount > Bet/2 || insuranceamount < 0 || Money - Bet - insuranceamount < 0
                disp(' Not valid');disp(' ')
                insuranceamount = input('How much? : ');disp(' ');
            end
            if Rupert(2) == 10 ;
                Money = Money - Bet + 2*insuranceamount;
                hit = 0; Ruperthit = 0;
                disp(['You: ',num2str(You),'    Rupert: ',num2str(Rupert)]);disp(' ')
                disp('     Rupert has blackjack');disp(' ')
            else
                Money = Money - insuranceamount;
                disp(' No blackjack for Rupert');disp(' ')
            end
        else
            if Rupert(2) == 10;
                disp(['You: ',num2str(You),'    Rupert: ',num2str(Rupert)]);disp(' ')
                disp('     Rupert has blackjack');disp(' ')
                Money = Money - Bet;
                hit = 0; Ruperthit = 0;
            else
                disp(' No blackjack for Rupert');disp(' ')
            end
        end
    end
    
    %Black Jack
    if hit == 1;
        if You(1) == 1 && You(2) == 10
            disp(' ');disp(['You: ',num2str(You),'    Rupert: ',num2str(Rupert)]);disp(' ');
            disp('     Black Jack!');disp(' ')
            hit = 0;
            Money = Money + 1.5*Bet;
            Ruperthit = 0;
            bj = 1;
        end
        if You(1) == 10 && You(2) == 1
            disp(' ');disp(['You: ',num2str(You),'    Rupert: ',num2str(Rupert)]);disp(' ');
            disp('     Black Jack!');disp(' ')
            hit = 0;
            Money = Money + 1.5*Bet;
            Ruperthit = 0;
            bj = 1;
        end
    end
    if Rupert(1) == 10
        if Rupert(2) == 1
            if bj ~= 1
                disp(' ');disp(['You: ',num2str(You),'    Rupert: ',num2str(Rupert)])
                disp(' ');disp('     Rupert has blackjack');disp(' ')
                Money = Money - Bet;
                hit = 0; Ruperthit = 0;
            else
                disp('     Rupert also has blackjack. That sucks');disp(' ')
                Money = Money - 1.5*Bet;
            end
        end
        if bj ~= 1 && Rupert(2) ~= 1
            disp(' ');disp(['You: ', num2str(You), '    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ')
        end
    end
    
    if bj == 0 && hit == 1 && Rupert(1) ~= 10 && Rupert(1) ~= 1
        disp(' ');disp(['You: ', num2str(You), '    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ')
    end
    
    %You Hitting!
    while hit ~= 0;
        hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
        j = 3;
        
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
                if You(1) ~= You(2) || length(You) > 2
                    while hit == 3
                        go = 0;
                        disp('  ');disp(' Your cards must be the same to split.');disp('  ')
                        hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                    end
                end
                if Money - 2*Bet < 0
                    while hit == 2
                        go = 0;
                        disp(' ');disp(' You dont have enough money to double down');disp(' ');
                        hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                    end
                    while hit == 3
                        go = 0;
                        disp(' ');disp(' You dont have enough money to split');disp(' ');
                        hit = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ');
                    end
                end
            end
            if hit == 0 || hit == 1
                go = 1;
            end
        end
        
        if hit == 2
            [Deck You i] = Double(Deck,You,Rupert,i);
            hit = 0;
            Bet = Bet*2;
        end
        
        if hit == 3
            [Deck Yousplit1 Yousplit2 Money Bet i j Ruperthit split] = Split(Deck,You,Rupert,Money,Bet,i,Ruperthit);
            hit = 0;
            if sum(Yousplit1) > 21 && sum(Yousplit2) > 21
                Ruperthit = 0;
            end
        end
        
        %Regular Hit
        if hit == 1
            [Deck You Money Bet i Ruperthit split] = Hitting(Deck,You,Rupert,Money,Bet,i,j,Ruperthit,split);
            hit = 0;
        end
    end
    
    aces = find(Rupert<2);
    if ~isempty(aces) && (sum(Rupert) + 10) < 22
        Rupert(aces(1)) = 11;
        ace = 1;
    end
    
    %Rupert Hitting
    if Ruperthit ~= 0
        j = 3;
        if ace == 0
            aces = find(Rupert<2);
            if ~isempty(aces) && (sum(Rupert) + 10) < 22
                Rupert(aces(1)) = 11;
                ace = 1;
            end
        end
        if sum(Rupert) == 17 && ace == 1
            Rupert(aces(1)) = 1;
        end
        while sum(Rupert) < 17
            Rupert(j) = Deck(i); j = j + 1;
            i = i + 1;
            if i == 53
                [Deck i]= Shuffle;
            end
            if ace == 0
                aces = find(Rupert<2);
                if ~isempty(aces)
                    ace = 1;
                end
            end
            if sum(Rupert) == 17 && ace == 1
                Rupert(aces(1)) = 1;
            end
            if ace == 1 && sum(Rupert) > 21
                Rupert(aces(1)) = 1;
            end
        end
        
        %Final Hands
        if split == 0;
            aces = find(You<2);
            if ~isempty(aces) && (sum(You) + 10) < 22
                You(aces(1)) = 11;
            end
            disp(' ');disp(['You: ',num2str(You),' (',num2str(sum(You)),')','    Rupert: ',num2str(Rupert),' (',num2str(sum(Rupert)),')'])
        else
            aces = find(Yousplit2<2);
            if ~isempty(aces) && (sum(Yousplit2) + 10) < 22
                Yousplit2(aces(1)) = 11;
            end
            aces = find(Yousplit1<2);
            if ~isempty(aces) && (sum(Yousplit1) + 10) < 22
                Yousplit1(aces(1)) = 11;
            end
            disp(' ');disp(['Hand 1: ',num2str(Yousplit1),' (',num2str(sum(Yousplit1)),')','    Hand 2: ',num2str(Yousplit2),' (',num2str(sum(Yousplit2)),')','    Rupert: ',num2str(Rupert),' (',num2str(sum(Rupert)),')',])
        end
        
        % Dinero!
        if sum(Rupert) > 21
            disp(' ');disp('     Rupert busted');disp(' ');
            Rupertbust = 1;
            if split == 0
                Money = Money + Bet;
            end
            if split == 1 && sum(Yousplit1) < 22
                Money = Money + Bet;
            end
            if split == 1 && sum(Yousplit2) < 22
                Money = Money + Bet;
            end
        end
        if sum(Rupert) < 22
            Rupertbust = 0;
        end
        
        if Rupertbust == 0
            if split == 0
                if sum(You) > sum(Rupert)
                    Money = Money + Bet;
                    disp(' ');disp('     Win!');disp(' ')
                end
                if sum(You) < sum(Rupert)
                    Money = Money - Bet;
                    disp(' ');disp('     Lose');disp(' ')
                end
                if sum(You) == sum(Rupert)
                    disp(' ');disp('     Push');disp(' ')
                end
            else
                if sum(Yousplit1) > sum(Rupert) && sum(Yousplit1) < 22
                    Money = Money + Bet;
                    disp(' ');disp('     Win hand 1!');
                end
                if sum(Yousplit1) < sum(Rupert) && sum(Yousplit1) < 22
                    Money = Money - Bet;
                    disp(' ');disp('     Lose hand 1');
                end
                if sum(Yousplit1) == sum(Rupert) && sum(Yousplit1) < 22
                    disp(' ');disp('     Push hand 1');
                end
                if sum(Yousplit2) > 21
                    disp(' ')
                end
                if sum(Yousplit2) > sum(Rupert) && sum(Yousplit2) < 22
                    Money = Money + Bet;
                    disp(' ');disp('     Win hand 2!');disp(' ')
                end
                if sum(Yousplit2) < sum(Rupert) && sum(Yousplit2) < 22
                    Money = Money - Bet;
                    disp(' ');disp('     Lose hand 2');disp(' ')
                end
                if sum(Yousplit2) == sum(Rupert) && sum(Yousplit2) < 22
                    disp(' ');disp('     Push hand 2');disp(' ')
                end
            end
        end
        
    end
    clear You; clear Rupert;
    disp(['Money = ', num2str(Money)]);
    pause; clc;
    if Money == 0
        disp(' ');disp('Haha. You ran out of money. Game over!');disp(' ')
        playagain = input('Play again? Yes = 1 No = 0 : ');
        while playagain ~= 1 && playagain ~= 0
            disp(' ');disp(' Im giving you a second chance here. Dont be a dumbass.');disp(' ')
            playagain = input('Play again? Yes = 1 No = 0 : ');
        end
        if playagain == 1
            disp(' ');disp('Alright, 1 government bailout coming right up. But only because youre so cute.');disp(' ');
            Money = 1000;
        end
    end
end