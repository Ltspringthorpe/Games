function[Deck,You,Money,Bet,i,Ruperthit,split] = Hitting(Deck,You,Rupert,Money,Bet,i,j,Ruperthit,split)
hit = 1;
while hit == 1
    You(j) = Deck(i); j = j + 1;
    i = i + 1;
    if i == 53
        [Deck i]= Shuffle;
    end
    
    clc; disp(['Money = ', num2str(Money)]);
    
    if sum(You) > 21        
        if split == 0
            disp(' ');disp(['You: ',num2str(You),' (',num2str(sum(You)),')','    Rupert: ',num2str(Rupert)]);disp(' ')
            disp('     Bust');disp(' ');
        end
        if split == 1
            disp(' ');disp(['Hand 1: ',num2str(You),' (',num2str(sum(You)),')','    Rupert: ',num2str(Rupert),'  ?? ']);disp(' ')
            disp('     Bust hand 1');disp(' ');
        end
        if split == 2
            disp(' ');disp(['Hand 2: ',num2str(You),' (',num2str(sum(You)),')','    Rupert: ',num2str(Rupert)]);disp(' ')
            disp('     Bust hand 2');disp(' ');
        end
        hit = 0;
        Money = Money - Bet;
        hit = 0;
        if split == 0
            Ruperthit = 0;
        end
    else
        if split == 0
            disp(' ');disp(['You: ', num2str(You),'    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ')
        end
        if split == 1
            disp(' ');disp(['Hand 1: ', num2str(You),'    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ')
        end
        if split == 2
            disp(' ');disp(['Hand 2: ', num2str(You),'    Rupert: ', num2str(Rupert(1)), '  ?? ']);disp(' ')
        end
        hit = input('Hit? : ');
        while hit ~= 0 && hit ~= 1
            disp(' ');disp(' Dumbass');disp(' ')
            hit = input('Hit? Stay = 0, Hit = 1 : ');            
        end
    end
end
hit = 0;