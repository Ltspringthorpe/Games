function[deck, i] = Shuffle
clear deck;
cards = (1:52);
for i = 1:52;
    coordinate = randi(length(cards));
    deck(i) = cards(coordinate);
    cards(coordinate) = [];
    while deck(i) > 13;
        deck(i) = deck(i) - 13;
    end
    while deck(i) > 10;
        deck(i) = 10;
    end
end
i = 1;