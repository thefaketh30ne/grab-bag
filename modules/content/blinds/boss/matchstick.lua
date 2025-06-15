SMODS.Blind {
    key = "matchstick",
    loc_txt = {
        name = "The Matchstick",
        text = {
            "Start with half of",
            "hands and discards",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 13 },
    boss = { min = 3 },
    boss_colour = HEX("85675d"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.discards_sub = math.floor(G.GAME.current_round.discards_left / 2)
                blind.hands_sub = math.floor(G.GAME.current_round.hands_left / 2)
                ease_hands_played(-blind.discards_sub)
                ease_discard(-blind.hands_sub)
            end
        end
    end,
    disable = function(self)
        ease_discard(G.GAME.blind.discards_sub)
        ease_hands_played(G.GAME.blind.hands_sub)
    end
}