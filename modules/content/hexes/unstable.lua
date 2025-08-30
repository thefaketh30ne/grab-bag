GB.Hex {
    key = 'unstable_hex',
    atlas = 'gb_Hexes',
    pos = { x = 1, y = 1 },
    badge_colour = HEX("7B3939"),
    loc_txt = {
        name = "Unstable",
        text = {
            "If {C:attention}3{} or more {C:attention}Unstable",
            "cards are held in hand,",
            "{C:attention}permanently debuff{} all",
            "cards held in hand"
        },
        label = "Unstable",
    },
    calculate = function(self, card, context)
        if context.hand_drawn or context.other_drawn then
            local tally = 0
            for _, playing_card in ipairs(G.hand.cards) do
                local hex_key, _ = GB.get_hex(playing_card)
                if hex_key == "gb_unstable_hex" then
                    tally = tally + 1
                end
            end
            if tally >= 3 then
                for _, playing_card in ipairs(G.hand.cards) do
                    playing_card.ability.perma_debuff = true
                end
            end
        end
    end
}