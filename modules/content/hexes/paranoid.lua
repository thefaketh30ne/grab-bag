GB.Hex {
    key = 'paranoid_hex',
    atlas = 'gb_Hexes',
    pos = { x = 0, y = 0 },
    badge_colour = HEX("6D2E86"),
    loc_txt = {
        name = "Paranoid",
        text = {
            "If this is the only",
            "played {C:attention}Paranoid{} card,",
            "reduce the level of",
            "played {C:attention}poker hand"

        },
        label = "Paranoid",
    },
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            local tally = 0
            for _, playing_card in ipairs(context.full_hand) do
                if GB.has_hex(playing_card, "paranoid") == true then
                    tally = tally + 1
                end
            end
            if tally == 1 then
                return {
                    level_up = -1
                }
            end
        end
    end
}