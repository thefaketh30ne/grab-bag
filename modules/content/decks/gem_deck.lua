SMODS.Back {
    key = "gem",
    loc_txt = {
        name = "Gem Deck",
        text = {
            "Start with an extra {C:money}$#1#{}",
            "and {C:money}Clearance Sale{}",
            "{s:0.85,C:inactive}Thank you to @squidguset",
            "{s:0.85,C:inactive} for the deck effect!",

        }
    },
    atlas = "Cards",
    pos = { x = 1, y = 0 },
    config = { extra = { dollars = 5, vouchers = { 'v_clearance_sale' } } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.dollars } }
    end,
    apply = function(self, back)
        G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + self.config.extra.dollars
        for k, v in pairs(self.config.extra.vouchers) do
            G.GAME.used_vouchers[v] = true
            G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
        end
    end
}