SMODS.Blind {
    key = "final_pentacle",
    loc_txt = {
        name = "Golden Pentacle",
        text = {
            "Debuffs half",
            "of played cards",
            "before scoring",
        }
    },
    dollars = 8,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 18 },
    boss = { showdown = true },
    boss_colour = HEX("f2cc00"),
    calculate = function(self, blind, context)
        if not blind.disabled and context.before then
            for _, playing_card in ipairs(context.scoring_hand) do
                if pseudorandom("gb_final_pentacle") < 0.5 then
                    playing_card:juice_up()
                    SMODS.debuff_card(playing_card, true, "gb_final_pentacle")
                end
            end
        end
    end
}