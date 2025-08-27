GB.Hex {
    key = 'egoistic',
    atlas = 'gb_Hexes',
    pos = { x = 9, y = 0 },
    badge_colour = HEX("2A6488"),

    calculate = function(self, card, context)
        if context.hand_drawn then
            for _, playing_card in pairs(context.hand_drawn) do
                if playing_card == card then
                    card.ability.forced_selection = true
                end
            end
        end    
        if context.end_of_round and context.main_eval then
            card.ability.forced_selection = nil
        end
    end
}