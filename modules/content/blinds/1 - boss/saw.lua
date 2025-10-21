SMODS.Blind {
    key = "saw",
    loc_txt = {
        name = "The Saw",
        text = {
            "Discarding decreases",
            "the level of #1#",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 32 },
    boss = { min = 5 },
    boss_colour = HEX("e4b86b"),
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.pre_discard then
                SMODS.smart_level_up_hand(
                    G.GAME.current_round.most_played_poker_hand,
                    false,
                    -1
                )
            end
        end
    end,
}