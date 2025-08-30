SMODS.Back {
    key = "rushdown",
    atlas = "gb_Decks",
    pos = { x = 6, y = 0 },
    loc_txt = {
        name = "Rushdown Deck",
        text = {
            "Start on {C:attention}Ante #1#{}",
            "All poker hands",
            "start at {C:attention}Lv.#2#{}"
        },
    },
    config = { extra = { start_ante = 2, hand_level = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.start_ante, self.config.extra.hand_level } }
    end,
    apply = function(self, back)
        G.GAME.round_resets.ante = self.config.extra.start_ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.ante
        for key, _ in pairs(G.GAME.hands) do
            level_up_hand(nil, key, true, self.config.extra.hand_level - 1)
        end
    end
}