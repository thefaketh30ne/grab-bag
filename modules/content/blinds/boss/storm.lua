SMODS.Blind {
    key = "storm",
    loc_txt = {
        name = "The Storm",
        text = {
            "+1 Ante if Blind not",
            "won on final hand",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 11 },
    boss = { min = 2 },
    boss_colour = HEX("424d85"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.end_of_round and context.main_eval and G.GAME.current_round.hands_left ~= 0 then
                ease_ante(1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
            end
        end
    end
}