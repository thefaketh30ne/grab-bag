SMODS.Back {
    key = "tech",
    atlas = "Cards",
    pos = { x = 3, y = 0 },
    loc_txt = {
        name = "Tech Deck",
        text = {
            "{C:attention}+#1#{} Joker slots",
            "Win on {C:attention}Ante #2#{}",
        },
    },
    config = { extra = { joker_slot = 2, ante = 10 } },
      loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.joker_slot, self.config.extra.ante } }
    end,
    apply = function(self, back)
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.extra.joker_slot
        G.GAME.win_ante = self.config.extra.ante
    end
}