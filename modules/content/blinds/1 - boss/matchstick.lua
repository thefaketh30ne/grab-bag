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
    config = { extra = { discards_sub = 0, hands_sub = 0 } },
    calculate = function(self, blind, context)
        if context.setting_blind then
            self.config.extra.discards_sub = math.floor(G.GAME.current_round.discards_left / 2)
            self.config.extra.hands_sub = math.floor(G.GAME.current_round.hands_left / 2)
        end
        if not blind.disabled then
            if context.setting_blind then
                ease_discard(-self.config.extra.discards_sub)
                ease_hands_played(-self.config.extra.hands_sub)
            end
        end
    end,
    disable = function(self)
        if not self.config.extra.discards_sub and self.config.extra.hands_sub then
            self.config.extra.discards_sub = math.floor(G.GAME.current_round.discards_left / 2)
            self.config.extra.hands_sub = math.floor(G.GAME.current_round.hands_left / 2) 
        end
        ease_discard(self.config.extra.discards_sub)
        ease_hands_played(self.config.extra.hands_sub)
    end
}