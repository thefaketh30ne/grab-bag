SMODS.Blind {
    key = "cull",
    loc_txt = {
        name = "The Cull",
        text = {
            "Using a consumable",
            "doubles the Blind size",         
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 28 },
    boss = { min = 3 },
    boss_colour = HEX("aa6db8"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.using_consumeable then
                return {
                    xblindsize = 2
                }
            end
        end
    end,
}