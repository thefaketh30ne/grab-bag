GB.Hex {
    key = 'egoistic_hex',
    atlas = 'gb_Hexes',
    pos = { x = 9, y = 0 },
    badge_colour = HEX("2A6488"),
    loc_txt = {
        name = "Egoistic",
        text = {
            "When this card",
            "is drawn, it is",
            "{C:attention}forced to be selected"
        },
        label = "Egoistic",
    },
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