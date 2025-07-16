SMODS.Consumable {
    key = "awaken",
    set = "Spectral",
    loc_txt = {
        name = 'Awaken',
        text = {
            "{C:attention}Convert{} up to {C:attention}#1#{} random cards",
            "in {C:attention}full deck{} to {C:gb_eyes}Eyes{}",
        }
    },
    hidden = true,
    soul_set = "Planet",
    soul_rate = 0.025,
    atlas = 'gb_Consumables',
    pos = { x = 1, y = 0 },
    config = { extra = { cards_to_convert = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_convert } }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local eligible_cards = {}
        for _, playing_card in ipairs(G.playing_cards or {}) do
            table.insert(eligible_cards, playing_card)
        end
        for i = 1, self.config.extra.cards_to_convert do
            if eligible_cards[i] then
                local selected_card, card_index = pseudorandom_element(eligible_cards, 'gb_awaken')
                assert(SMODS.change_base(selected_card, "gb_Eyes", nil))
                table.remove(eligible_cards, card_index)
            end
        end
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            attention_text({
                text = "Awaken!",
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = HEX("673E79"),
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                    'tm' or 'cm',
                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                silent = true
            })
            card:juice_up(0.3, 0.5)
            return true
        end
        }))
    end
}