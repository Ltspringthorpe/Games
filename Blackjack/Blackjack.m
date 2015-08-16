% Play BlackJack with Rupert as dealer! He's pretty relentless, so good luck.


clear all; clc;
[deck, i]= Shuffle;
yourMoney = 1000;

disp('Welcome to Black Jack!');disp('Rupert will be glad to take all of your Money now.');disp(' ');

% The Round
while yourMoney > 0;
    
    % Bet
    disp(['Your money = ', num2str(yourMoney)]);
    disp(' ');str = input('Bet : ','s');
    bet = str2double(str);
    
    while isnan(bet) || bet > yourMoney || bet <= 0
        if isnan(bet)
            disp(' ');disp(' A real number would be nice...');
        end
        if bet > yourMoney || bet <= 0
            disp(' ');disp(' Cheater');
        end
        disp(' ');str = input('Bet : ','s');
        bet = str2double(str);
    end
    
    % The Initial Deal
    you(1) = deck(i);
    i = i + 1; % i is a variable that keeps track of the number of cards in the deck we've used
    if i == 53
        [deck, i]= Shuffle; % Rupert shuffles the deck if we've gone through 52 cards
    end
    rupert(1) = deck(i);
    i = i + 1;
    if i == 53
        [deck, i]= Shuffle;
    end
    you(2) = deck(i);
    i = i + 1;
    if i == 53
        [deck, i]= Shuffle;
    end
    rupert(2) = deck(i);
    i = i + 1;
    if i == 53
        [deck, i]= Shuffle;
    end
    clc; 
    disp(['Your money = ', num2str(yourMoney)]); % display our hands, but one of Rupert's cards is kept hidden
    if rupert(1) == 1 && rupert(1) ~= 10
        disp(' ');disp(['You: ', num2str(you), '    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ');
    end
    hit = 1; split = 0; hasAce = 0; bj = 0;
    
    % Insurance
    rupertHit = 1;
    if rupert(1) == 1
        str = input('Insurance? y/n : ','s');disp(' ')
        while strcmp(str,'n') ~= 1 && strcmp(str,'N') ~= 1 && strcmp(str,'no') ~= 1 && strcmp(str,'No') ~= 1 && strcmp(str,'y') ~= 1 && strcmp(str,'Y') ~= 1 && strcmp(str,'yes') ~= 1 && strcmp(str,'Yes') ~= 1
            disp(' Dumbass');disp(' ')
            str = input('Insurance? y/n : ','s');disp(' ')
        end
        if strcmp(str,'y') == 1 || strcmp(str,'Y') == 1 || strcmp(str,'yes') == 1 || strcmp(str,'Yes') == 1
            insurance = 1;
        end
        if strcmp(str,'n') == 1 || strcmp(str,'N') == 1 || strcmp(str,'no') == 1 || strcmp(str,'No') == 1
            insurance = 0;
        end
        if insurance == 1;
            if rupert(2) == 10 ;
                % if you buy insurance and Rupert has blackjack, your money
                % doesn't change and the round is over
                hit = 0; rupertHit = 0;
                disp(['You: ',num2str(you),'    Rupert: ',num2str(rupert)]);disp(' ')
                disp('     Rupert has blackjack');disp(' ')
            else
                % if you buy insurance and Rupert doen't have blackjack,
                % you lose your insurance money (half of your bet) and play
                % proceeds as normal
                yourMoney = yourMoney - bet/2;
                disp(' No blackjack for Rupert');disp(' ')
                disp(['Your money = ', num2str(yourMoney)]);disp(' ');
            end
        else
            if rupert(2) == 10;
                % if you don't buy insurance and Rupert has blackjack, you
                % lose your bet and the round is over
                disp(['You: ',num2str(you),'    Rupert: ',num2str(rupert)]);disp(' ')
                disp('     Rupert has blackjack');disp(' ')
                yourMoney = yourMoney - bet;
                hit = 0; rupertHit = 0;
            else
                % if you don't buy insurance and Rupert doesn't have
                % blackjack, your money doesn't change and play proceeds as
                % normal
                disp(' No blackjack for Rupert');disp(' ')
            end
        end
    end
    
    % Black Jack
    if hit == 1;
        if you(1) == 1 && you(2) == 10
            disp(' ');disp(['You: ',num2str(you),'    Rupert: ',num2str(rupert)]);disp(' ');
            disp('     Black Jack!');disp(' ')
            hit = 0;
            yourMoney = yourMoney + 1.5*bet;
            rupertHit = 0;
            bj = 1;
           % you have blackjack! yay! you are paid 150% of your bet 
           
        end
        if you(1) == 10 && you(2) == 1
            disp(' ');disp(['You: ',num2str(you),'    Rupert: ',num2str(rupert)]);disp(' ');
            disp('     Black Jack!');disp(' ')
            hit = 0;
            yourMoney = yourMoney + 1.5*bet;
            rupertHit = 0;
            bj = 1;
            % you have blackjack! yay! you are paid 150% of your bet 
        end
    end
    if rupert(1) == 10
        if rupert(2) == 1
            if bj ~= 1
                disp(' ');disp(['You: ',num2str(you),'    Rupert: ',num2str(rupert)])
                disp(' ');disp('     Rupert has blackjack');disp(' ')
                yourMoney = yourMoney - bet;
                hit = 0; rupertHit = 0;
                % if Rupert is showing a face card (10) and has blackjack,
                % you do not get offered insurance and you immediately lose
            else
                disp('     Rupert also has blackjack. That sucks');disp(' ')
                yourMoney = yourMoney - 1.5*bet;
                % if Rupert is showing a face card (10) and has blackjack,
                % you do not get offered insurance, but you have a
                % blackjack too, so it's a push! (you lose the money that
                % you were just awarded for your blackjack)
            end
        end
        if bj ~= 1 && rupert(2) ~= 1
            disp(' ');disp(['You: ', num2str(you), '    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ')
        end
    end
    
    if bj == 0 && hit == 1 && rupert(1) ~= 10 && rupert(1) ~= 1
        disp(' ');disp(['You: ', num2str(you), '    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ')
    end
    
    % Hitting!
    while hit ~= 0;
        str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
        hit = str2double(str);
        j = 3;
        
        % Double Down & Split
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
                        % if the sum of your 2 cards equals 9, 10, or 11,
                        % you can double down, which means you get only one
                        % card and double your bet
                        go = 0;
                        disp(' ');disp(' To double down, your cards must total 9, 10, or 11.');disp(' ');
                        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
                            disp(' ');disp(' Dumbass');disp(' ')
                            str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                            hit = str2double(str);
                        end
                        str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                        hit = str2double(str);
                    end
                end
                if you(1) ~= you(2) || length(you) > 2
                    while hit == 3
                        % if your 2 cards have the same value, you can
                        % split them into 2 separate hands. your bet is
                        % effectively doubled since you have 2 hands now
                        go = 0;
                        disp('  ');disp(' Your cards must be the same to split.');disp('  ')
                        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
                            disp(' ');disp(' Dumbass');disp(' ')
                            str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                            hit = str2double(str);
                        end
                        str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                        hit = str2double(str);
                    end
                end
                if yourMoney - 2*bet < 0
                    % you need to have at least twice the amount of your
                    % bet in the bank (including your bet) to double down
                    % or split
                    while hit == 2
                        go = 0;
                        disp(' ');disp(' You dont have enough Money to double down');disp(' ');
                        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
                            disp(' ');disp(' Dumbass');disp(' ')
                            str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                            hit = str2double(str);
                        end
                        str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                        hit = str2double(str);
                    end
                    while hit == 3
                        go = 0;
                        disp(' ');disp(' You dont have enough Money to split');disp(' ');
                        while hit ~= 0 && hit ~= 1 && hit~= 2 && hit ~=3 || isnan(hit)
                            disp(' ');disp(' Dumbass');disp(' ')
                            str = input('Hit? Stay = 0, Hit = 1, Double Down = 2, Split = 3 : ','s');
                            hit = str2double(str);
                        end
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
            [deck, you, i] = Double(deck,you,rupert,i);
            hit = 0;
            bet = bet*2;
        end
        
        if hit == 3
            [deck, youSplit1, youSplit2, yourMoney, bet, i, j, rupertHit, split] = Split(deck,you,rupert,yourMoney,bet,i,rupertHit);
            hit = 0;
            if sum(youSplit1) > 21 && sum(youSplit2) > 21
                rupertHit = 0;
            end
        end
        
        % Regular Hit
        if hit == 1
            [deck, you, yourMoney, bet, i, rupertHit, split] = Hitting(deck,you,rupert,yourMoney,bet,i,j,rupertHit,split);
            hit = 0;
        end
    end
    
    aces = find(rupert<2);
    % you can use an ace card as either value 1 or 11
    if ~isempty(aces) && (sum(rupert) + 10) < 22
        rupert(aces(1)) = 11;
        hasAce = 1;
    end
    
    % Rupert Hitting
    if rupertHit ~= 0
        j = 3;
        if hasAce == 0
            aces = find(rupert<2);
            if ~isempty(aces) && (sum(rupert) + 10) < 22
                rupert(aces(1)) = 11;
                hasAce = 1;
            end
        end
        if sum(rupert) == 17 && hasAce == 1
            rupert(aces(1)) = 1;
            % Rupert hits on a soft 17, meaning if he has an ace in his
            % hand that he's using as value 11 and the sum of his cards
            % equals 17, he must use the ace as value 1 and keep hitting
        end
        
        while sum(rupert) < 17
        % Rupert keeps hitting until the sum of his cards equal 17 or
        % greater
            rupert(j) = deck(i); j = j + 1;
            i = i + 1;
            if i == 53
                [deck, i]= Shuffle;
            end
            if hasAce == 0
                aces = find(rupert<2);
                if ~isempty(aces)
                    hasAce = 1;
                end
            end
            if sum(rupert) == 17 && hasAce == 1
                rupert(aces(1)) = 1;
            end
            if hasAce == 1 && sum(rupert) > 21
                rupert(aces(1)) = 1;
            end
        end
        
        % Final Hands
        if split == 0;
            aces = find(you<2);
            % evaluate your aces to see if they should be used as value 1 or 11
            if ~isempty(aces) && (sum(you) + 10) < 22
                you(aces(1)) = 11;
            end
            disp(' ');disp(['You: ',num2str(you),' (',num2str(sum(you)),')','    Rupert: ',num2str(rupert),' (',num2str(sum(rupert)),')'])
        else
            aces = find(youSplit2<2);
            if ~isempty(aces) && (sum(youSplit2) + 10) < 22
                youSplit2(aces(1)) = 11;
            end
            aces = find(youSplit1<2);
            if ~isempty(aces) && (sum(youSplit1) + 10) < 22
                youSplit1(aces(1)) = 11;
            end
            disp(' ');disp(['Hand 1: ',num2str(youSplit1),' (',num2str(sum(youSplit1)),')','    Hand 2: ',num2str(youSplit2),' (',num2str(sum(youSplit2)),')','    Rupert: ',num2str(rupert),' (',num2str(sum(rupert)),')',])
        end
        
        % Dinero!
        if sum(rupert) > 21
            % Rupert loses! you get money!
            disp(' ');disp('     Rupert busted');disp(' ');
            rupertBust = 1;
            if split == 0
                yourMoney = yourMoney + bet;
            end
            if split == 1 && sum(youSplit1) < 22
                yourMoney = yourMoney + bet;
            end
            if split == 1 && sum(youSplit2) < 22
                yourMoney = yourMoney + bet;
            end
        end
        if sum(rupert) < 22
            rupertBust = 0;
        end
        
        if rupertBust == 0
            if split == 0
                if sum(you) > sum(rupert)
                    yourMoney = yourMoney + bet;
                    disp(' ');disp('     Win!');disp(' ')
                end
                if sum(you) < sum(rupert)
                    yourMoney = yourMoney - bet;
                    disp(' ');disp('     Lose');disp(' ')
                end
                if sum(you) == sum(rupert)
                    disp(' ');disp('     Push');disp(' ')
                end
            else
                if sum(youSplit1) > sum(rupert) && sum(youSplit1) < 22
                    yourMoney = yourMoney + bet;
                    disp(' ');disp('     Win hand 1!');
                end
                if sum(youSplit1) < sum(rupert) && sum(youSplit1) < 22
                    yourMoney = yourMoney - bet;
                    disp(' ');disp('     Lose hand 1');
                end
                if sum(youSplit1) == sum(rupert) && sum(youSplit1) < 22
                    disp(' ');disp('     Push hand 1');
                end
                if sum(youSplit2) > 21
                    disp(' ')
                end
                if sum(youSplit2) > sum(rupert) && sum(youSplit2) < 22
                    yourMoney = yourMoney + bet;
                    disp(' ');disp('     Win hand 2!');disp(' ')
                end
                if sum(youSplit2) < sum(rupert) && sum(youSplit2) < 22
                    yourMoney = yourMoney - bet;
                    disp(' ');disp('     Lose hand 2');disp(' ')
                end
                if sum(youSplit2) == sum(rupert) && sum(youSplit2) < 22
                    disp(' ');disp('     Push hand 2');disp(' ')
                end
            end
        end
        
    end
    clear you; clear rupert;
    disp(['Your money = ', num2str(yourMoney)]);
    pause; clc;
    if yourMoney == 0
        disp(' ');disp('Haha. you ran out of money. Game over!');disp(' ')
        str = input('Play again? y/n : ','s');
        while strcmp(str,'n') ~= 1 && strcmp(str,'N') ~= 1 && strcmp(str,'no') ~= 1 && strcmp(str,'No') ~= 1 && strcmp(str,'y') ~= 1 && strcmp(str,'Y') ~= 1 && strcmp(str,'yes') ~= 1 && strcmp(str,'Yes') ~= 1
            disp(' ');disp(' Im giving you a second chance here. Dont be an idiot.');disp(' ')
            str = input('Play again? y/n : ','s');
        end
        if strcmp(str,'y') == 1 || strcmp(str,'Y') == 1 || strcmp(str,'yes') == 1 || strcmp(str,'Yes') == 1
            disp(' ');disp('Alright, 1 government bailout coming right up. But only because you''re so cute.');disp(' ');
            yourMoney = 1000;
            pause; clc;
        end
    end
end