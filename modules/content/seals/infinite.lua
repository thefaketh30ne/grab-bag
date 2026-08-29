SMODS.Seal {
    key = 'infinite',
    loc_txt = {
        name = "Infinite Seal",
        label = "Infinite Seal",
        text = {
            "If this card is {C:attention}destroyed{},",
            "{C:attention}duplicate{} it and earn {C:money}$#1#{}",
        }
    },
    atlas = "gb_Seals",
    pos = { x = 2, y = 0 },
    config = { extra = { odds = 4, dollars = 5 } },
    badge_colour = HEX('A1A5A6'),
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local being_removed = false
            for _, playing_card in ipairs(context.removed) do
                if playing_card == card and not (card.edition and card.edition.key ~= "e_gb_temporary") then
                    being_removed = true
                end
            end
            if being_removed then
                SMODS.copy_card(card)
                ease_dollars(self.config.extra.dollars)
            end
        end
    end
}