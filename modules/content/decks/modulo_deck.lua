SMODS.Back {
    key = "modulo",
    loc_txt = {
        name = "Modulo Deck",
        text = {
            "Start with two of every",
            "odd {C:clubs}Club{} and {C:diamonds}Diamond{}",
            "and two of every",
            "even {C:spades}Spade{} and {C:hearts}Heart{}",
        }
    },
    atlas = "gb_Cards",
    pos = { x = 0, y = 1 },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local cards_to_remove = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_suit('Clubs')
                        or playing_card:is_suit('Diamonds') then
                        if not (
                           playing_card:get_id() == 3 
                           or playing_card:get_id() == 5
                           or playing_card:get_id() == 7
                           or playing_card:get_id() == 9
                           or playing_card:get_id() == 14
                        ) then
                            table.insert(cards_to_remove, playing_card)
                        end
                    elseif playing_card:is_suit('Hearts')
                        or playing_card:is_suit('Spades') then
                        if not (
                           playing_card:get_id() == 2
                           or playing_card:get_id() == 4
                           or playing_card:get_id() == 6
                           or playing_card:get_id() == 8
                           or playing_card:get_id() == 10
                        ) then
                            table.insert(cards_to_remove, playing_card)
                        end
                    else
                        table.insert(cards_to_remove, playing_card)
                    end
                end
                for _, card_to_remove in ipairs(cards_to_remove) do
                    card_to_remove:remove()
                end
                local cards_to_add = {}
                for _, dupe_card in ipairs(G.playing_cards) do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(dupe_card, nil, nil, G.playing_card)
                    table.insert(cards_to_add, _card)
                end
                for _, card_to_add in ipairs(cards_to_add) do
                    card_to_add:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, card_to_add)
                    G.deck:emplace(card_to_add)
                end
                G.GAME.starting_deck_size = 40
                return true
            end
        }))
    end
}