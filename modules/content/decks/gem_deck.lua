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
    atlas = "gb_Cards",
    pos = { x = 1, y = 0 },
    config = { dollars = 5, voucher = 'v_clearance_sale' },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.dollars } }
    end
}