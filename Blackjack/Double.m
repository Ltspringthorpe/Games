function[Deck,You,i] = Double(Deck,You,Rupert,i)
You(3) = Deck(i);
i = i + 1;
if i == 53
    [Deck i]= Shuffle;
end
hit = 0;