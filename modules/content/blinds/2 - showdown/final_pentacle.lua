SMODS.Blind {
    key = "final_pentacle",
    loc_txt = {
        name = "Golden Pentacle",
        text = {
            "Debuffs #1# in #2#",
            "played cards",
            "before scoring",
        }
    },
    dollars = 8,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 18 },
    boss = { showdown = true },
    boss_colour = HEX("f2cc00"),
    loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, 2)
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled and context.before then
            for _, playing_card in ipairs(context.scoring_hand) do
                if SMODS.pseudorandom_probability(blind, 'gb_final_pentacle', 1, 2) then
                    playing_card:juice_up()
                    SMODS.debuff_card(playing_card, true, "gb_final_pentacle")
                end
            end
        end
        if context.end_of_round then
            for _, playing_card in ipairs(G.playing_cards) do
                SMODS.debuff_card(playing_card, "reset", "gb_final_pentacle")
            end
        end
    end
}