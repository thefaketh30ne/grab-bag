SMODS.Consumable {
    key = "mirage",
    set = "Ephemeral",
    loc_txt = {
        name = 'Mirage',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{} copies",
            "of a random card in hand to hand",
        }
    },
    config = {extra = { cards_to_create = 3 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 5, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        local card_to_copy = pseudorandom_element(G.hand.cards, pseudoseed("gb_mirage"))
        for k = 1, self.config.extra.cards_to_create do
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(card_to_copy, nil, nil, G.playing_card)
            copy_card.playing_card = G.playing_card
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            copy_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
            G.hand:emplace(copy_card)
            copy_card:set_edition('e_gb_temporary', true, true)
        end
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end,
}