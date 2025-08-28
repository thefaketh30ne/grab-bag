GB.Hex {
    key = 'haunted_hex',
    atlas = 'gb_Hexes',
    pos = { x = 8, y = 0 },
    badge_colour = HEX("623D88"),
    loc_txt = {
        name = "Haunted",
        text = {
            "When {C:attention}Boss Blind{} is selected,",
            "create a copy of this card",
            "with a random {C:attention}Hex"

        },
        label = "Haunted",
    },
    calculate = function(self, card, context)
        if context.setting_blind
        and context.blind.boss then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(card, nil, nil, G.playing_card)
            GB.set_hex(copy_card, pseudorandom_element(GB.HEX_KEYS, pseudoseed("gb_haunted")))
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.deck:emplace(copy_card)
        end
    end
}