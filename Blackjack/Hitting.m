function[deck,you,yourMoney,bet,i,rupertHit,split] = Hitting(deck,you,rupert,yourMoney,bet,i,j,rupertHit,split)
hit = 1;
while hit == 1
    you(j) = deck(i); j = j + 1;
    i = i + 1;
    if i == 53
        [deck, i]= Shuffle;
    end
    
    clc; disp(['Your money = ', num2str(yourMoney)]);
    
    if sum(you) > 21
        % go over 21 and ya lose
        if split == 0
            disp(' ');disp(['You: ',num2str(you),' (',num2str(sum(you)),')','    Rupert: ',num2str(rupert)]);disp(' ')
            disp('     Bust');disp(' ');
        end
        if split == 1
            disp(' ');disp(['Hand 1: ',num2str(you),' (',num2str(sum(you)),')','    Rupert: ',num2str(rupert),'  ?? ']);disp(' ')
            disp('     Bust hand 1');disp(' ');
            pause
        end
        if split == 2
            disp(' ');disp(['Hand 2: ',num2str(you),' (',num2str(sum(you)),')','    Rupert: ',num2str(rupert)]);disp(' ')
            disp('     Bust hand 2');disp(' ');
        end
        hit = 0;
        yourMoney = yourMoney - bet;
        hit = 0;
        if split == 0
            rupertHit = 0;
        end
    else
        if split == 0
            disp(' ');disp(['You: ', num2str(you),'    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ')
        end
        if split == 1
            disp(' ');disp(['Hand 1: ', num2str(you),'    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ')
        end
        if split == 2
            disp(' ');disp(['Hand 2: ', num2str(you),'    Rupert: ', num2str(rupert(1)), '  ?? ']);disp(' ')
        end
        % after you've already hit once, you cannot double down or split
        str = input('Hit? : ','s');
        hit = str2double(str);
        while hit ~= 0 && hit ~= 1 || isnan(hit)
            disp(' ');disp(' Dumbass');disp(' ')
            str = input('Hit? Stay = 0, Hit = 1 : ','s');
            hit = str2double(str);
        end
    end
end
hit = 0;