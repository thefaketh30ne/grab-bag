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
            if context.consumeable_used then
                G.GAME.blind.chips = G.GAME.blind.chips * 2
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                play_sound("cancel")
                SMODS.juice_up_blind()
            end
        end
    end,
}