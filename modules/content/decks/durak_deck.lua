SMODS.Back {
    key = "durak",
    atlas = "gb_Decks",
    pos = { x = 1, y = 1 },
    loc_txt = {
        name = "Durak Deck",
        text = {
            "Start with no cards",
            "from {C:attention}2{} through {C:attention}5{}",
            "A random {C:attention}Suit{} is {C:attention}Wild"
        },
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local cards_to_remove = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:get_id() >= 2
                    and playing_card:get_id() <= 5 then
                        table.insert(cards_to_remove, playing_card)
                    end
                end
                for _, card_to_remove in ipairs(cards_to_remove) do
                    card_to_remove:remove()
                end
                local wild_suit = pseudorandom_element({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }, pseudoseed('gb_durak'))
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit(wild_suit) then
                        playing_card:set_ability("m_wild", nil, nil)
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end
        }))
    end
}