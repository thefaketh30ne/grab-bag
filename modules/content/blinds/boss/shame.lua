blind_skipped_this_ante = false

SMODS.Blind {
    key = "shame",
    loc_txt = {
        name = "The Shame",
        text = {
            "All cards debuffed",
            "if Blind not skipped",
            "this ante",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 8 },
    boss = { min = 1 },
    boss_colour = HEX("6935bc"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and not blind_skipped_this_ante then
                return {
                    debuff = true
                }
            end
        end
    end
}