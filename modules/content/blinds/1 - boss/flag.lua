SMODS.Blind {
    key = "flag",
    loc_txt = {
        name = "The Flag",
        text = {
            "Cards held in hand",
            "at end of round are",
            "permanently debuffed",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 7 },
    boss = { min = 3 },
    boss_colour = HEX("6d6b89"),
    calculate = function(self, blind, context)
        if not blind.disabled and context.end_of_round and context.cardarea == G.hand then
            for _, playing_card in pairs(G.hand.cards) do
                playing_card.ability.perma_debuff = true
                playing_card:juice_up()
            end
        end
    end,
}