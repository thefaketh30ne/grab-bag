SMODS.Back {
    key = "enhanced",
    loc_txt = {
        name = "Enhanced Deck",
        text = {
            "When {C:attention}Blind{} is selected,",
            "enhance up to {C:attention}#1#{}",
            "random cards in full deck",
            "{C:red}X#2#{} base Blind size"
        }
    },
    atlas = "gb_Cards",
    pos = { x = 5, y = 0 },
    config = { extra = { enhancements = 2, ante_scaling = 1.5 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.enhancements, self.config.extra.ante_scaling } }
    end,
    calculate = function(self, back, context)
        if context.setting_blind then
            local valid_keys = {}
            for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if enhancement_center.key ~= {
                    'm_stone',
                    'm_gb_honey'
                    }
                    and not enhancement_center.overrides_base_rank then
                    valid_keys[#valid_keys + 1] = enhancement_center.key
                end
            end
            for i = 1, self.config.extra.enhancements do
                local unenhanced_cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not next(SMODS.get_enhancements(playing_card)) then
                        table.insert(unenhanced_cards, playing_card)
                    end
                end
                local card_to_enhance = pseudorandom_element(unenhanced_cards, pseudoseed("gb_enhanced"))
                if card_to_enhance then
                    card_to_enhance:set_ability(pseudorandom_element(valid_keys, pseudoseed('gb_enhanced')), nil, nil)
                end
            end
        end
    end,
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.extra.ante_scaling
    end,
}