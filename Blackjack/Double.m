function[deck,you,i] = Double(deck,you,rupert,i)
you(3) = deck(i);
i = i + 1;
if i == 53
    [deck, i]= Shuffle;
end
hit = 0;