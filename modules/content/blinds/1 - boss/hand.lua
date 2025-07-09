SMODS.Blind {
    key = "hand",
    loc_txt = {
        name = "The Hand",
        text = {
            "Permanently debuff",
            "leftmost card",
            "in played hand",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 4 },
    boss = { min = 5 },
    boss_colour = HEX("bc3535"),
    calculate = function(self, blind, context)
        if not blind.disabled and context.final_scoring_step then
            local first_scored_card = G.play.cards[1]
            first_scored_card.ability.perma_debuff = true
            first_scored_card:juice_up()
        end
    end,
}