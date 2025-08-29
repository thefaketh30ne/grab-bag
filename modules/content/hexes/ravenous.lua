GB.Hex {
    key = 'ravenous_hex',
    atlas = 'gb_Hexes',
    pos = { x = 5, y = 0 },
    badge_colour = HEX("864F2F"),
    loc_txt = {
        name = "Ravenous",
        text = {
            "When held in hand,",
            "remove {C:attention}Enhancement{} of a",
            "random played card"
        },
        label = "Ravenous",
    },
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.hand then
            local enhanced_cards = {}
            for _, playing_card in ipairs(context.full_hand) do
                if next(SMODS.get_enhancements(playing_card))
                and not playing_card.debuff
                and not playing_card.vampired then
                    table.insert(enhanced_cards, playing_card)
                end
            end
            local card_to_unenhance = pseudorandom_element(enhanced_cards, pseudoseed("gb_ravenous"))
            if card_to_unenhance then
                card_to_unenhance.vampired = true
                card_to_unenhance:set_ability('c_base', nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_to_unenhance:juice_up()
                        card_to_unenhance.vampired = nil
                        return true
                    end
                }))
            end
        end
    end
}