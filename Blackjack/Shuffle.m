function[Deck i] = Shuffle
clear Deck;
Cards = (1:52);
for i = 1:52;
    coord = randi(length(Cards));
    Deck(i) = Cards(coord);
    Cards(coord) = [];
    while Deck(i) > 13;
        Deck(i) = Deck(i) - 13;
    end
    while Deck(i) > 10;
        Deck(i) = 10;
    end
end
i = 1;