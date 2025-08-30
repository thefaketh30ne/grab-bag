GB.Hex {
    key = 'cowardly_hex',
    atlas = 'gb_Hexes',
    pos = { x = 2, y = 0 },
    badge_colour = HEX("605679"),
    loc_txt = {
        name = "Cowardly",
        text = {
            "Always drawn {C:attention}face down"
        },
        label = "Cowardly",
    },
    calculate = function(self, card, context)
        if context.stay_flipped 
        and context.other_card == card 
        and context.to_area == G.hand then
            return {
                stay_flipped = true
            }
        end
    end
}