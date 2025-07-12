SMODS.Blind {
    key = "cross",
    loc_txt = {
        name = "The Cross",
        text = {
            "Sets all listed",
            "probabilities to 0",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 9 },
    boss = { min = 4 },
    boss_colour = HEX("53c45c"),
    calculate = function(self, blind, context)
        if not blind.disabled and context.fix_probability then
            return {
                numerator = 0
            }
        end
    end,
}