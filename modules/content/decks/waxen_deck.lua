SMODS.Back {
    key = "waxen",
    loc_txt = {
        name = "Waxen Deck",
        text = {
            "When {C:attention}Boss Blind{} is selected,",
            "give {C:attention}#1#{} random cards",
            "in hand random {C:attention}Seals{}",
            "{C:red}X#2#{} base Blind size"
        }
    },
    atlas = "gb_Cards",
    pos = { x = 6, y = 0 },
    config = { extra = { seals = 2, ante_scaling = 1.5 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.seals, self.config.extra.ante_scaling } }
    end,
    calculate = function(self, back, context)
        if context.first_hand_drawn and G.GAME.blind.boss then
            local valid_keys = {}
            for _, seal_center in pairs(G.P_CENTER_POOLS["Seal"]) do
                valid_keys[#valid_keys + 1] = seal_center.key
            end
            for i = 1, self.config.extra.seals do
                local unsealed_cards = {}
                for _, playing_card in ipairs(G.hand.cards) do
                    if not playing_card.seal then
                        table.insert(unsealed_cards, playing_card)
                    end
                end
                local card_to_enhance = pseudorandom_element(unsealed_cards, pseudoseed("gb_waxen"))
                if card_to_enhance then
                    card_to_enhance:set_seal(pseudorandom_element(valid_keys, pseudoseed("gb_waxen")))
                end
            end
        end
    end,
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.extra.ante_scaling
    end
}