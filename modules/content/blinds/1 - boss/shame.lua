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
            if context.debuff_card and context.debuff_card.area ~= G.jokers then
                if not G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE then
                    return {
                        debuff = true
                    }
                elseif G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE <= 0 then
                    return {
                        debuff = true
                    }
                end
            end
        end
    end
}