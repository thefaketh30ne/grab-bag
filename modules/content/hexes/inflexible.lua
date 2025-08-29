GB.Hex {
    key = 'inflexible_hex',
    atlas = 'gb_Hexes',
    pos = { x = 0, y = 1 },
    badge_colour = HEX("2D8269"),
    loc_txt = {
        name = "Inflexible",
        text = {
            "Permanently debuffed",
            "if {C:attention}suit{} or {C:attention}rank{} changes"
        },
        label = "Inflexible",
    },
    calculate = function(self, card, context)
        if (context.change_rank or context.change_suit)
        and context.other_card == card then
            card.ability.perma_debuff = true
        end
    end
}