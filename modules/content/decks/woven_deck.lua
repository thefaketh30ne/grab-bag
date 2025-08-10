SMODS.Back {
    key = "woven",
    atlas = "gb_Decks",
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Woven Deck",
        text = {
            "Start on {C:attention}Ante #1#{}",
            "Win on {C:attention}Ante #2#{}",
            "Start with {C:inactive,T:v_blank}Blank{}"
        },
    },
    config = { voucher = 'v_blank', extra = { start_ante = 0, win_ante = 9 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.start_ante, self.config.extra.win_ante } }
    end,
    apply = function(self, back)
        G.GAME.win_ante = self.config.extra.win_ante
        G.GAME.round_resets.ante = self.config.extra.start_ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.ante
    end
}