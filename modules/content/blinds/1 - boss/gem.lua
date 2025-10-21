SMODS.Blind {
    key = "gem",
    loc_txt = {
        name = "The Gem",
        text = {
            "All #1# cards",
            "are debuffed",
            "Changes after",
            "hand played"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 33 },
    boss = { min = 1 },
    boss_colour = HEX("9688d5"),
    config = { extra = { suit = "Diamonds" } },
    loc_vars = function(self)
        return { vars = { localize(self.config.extra.suit, 'suits_singular') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { "[suit]" } }
    end,
    calculate = function(self, blind, context)
        if context.setting_blind then
            self.config.extra.base_blind_chips = G.GAME.blind.chips / G.GAME.blind.mult
        end
        if context.after then
            local suit_tally = {}
            for _, playing_card in ipairs(G.playing_cards) do
                suit_tally[playing_card.base.suit] = playing_card.base.suit
            end
            suit_tally[self.config.extra.suit] = nil
            local chosen_suit = pseudorandom_element(suit_tally, pseudoseed("gb_gem"))
            if chosen_suit then
                self.config.extra.suit = chosen_suit
            end
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card.base.suit == self.config.extra.suit then
                    SMODS.debuff_card(playing_card, true, "gb_gem")
                else
                    SMODS.debuff_card(playing_card, false, "gb_gem")
                end
            end
        end
    end,
    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "gb_gem")
        end
    end,
    defeat = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "gb_gem")
        end
    end
}