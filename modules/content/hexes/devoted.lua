GB.Hex {
    key = 'devoted_hex',
    atlas = 'gb_Hexes',
    pos = { x = 6, y = 0 },
    badge_colour = HEX("7B4F77"),
    loc_txt = {
        name = "Devoted",
        text = {
            "If one {C:attention}Devoted{} card",
            "is destroyed,",
            "All {C:attention}Devoted{} cards",
            "are destroyed"
        },
        label = "Devoted",
    },
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local being_removed = false
            for _, playing_card in ipairs(context.removed) do
                if playing_card == card then
                    being_removed = true
                end
            end
            if being_removed then
                local cards_to_destroy = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if GB.has_hex(playing_card, "devoted") and not playing_card.getting_sliced then
                        playing_card.getting_sliced = true
                        table.insert(cards_to_destroy, playing_card)
                    end
                end
                if #cards_to_destroy > 0 then
                    SMODS.destroy_cards(cards_to_destroy)
                end
            end
        end
    end
}