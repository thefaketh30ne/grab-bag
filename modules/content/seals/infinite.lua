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
    atlas = "gb_Cards",
    pos = { x = 7, y = 2 },
    config = { extra = { odds = 4, dollars = 5 } },
    badge_colour = HEX('A1A5A6'),
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local being_removed = false
            for _, playing_card in ipairs(context.removed) do
                if playing_card == card then
                    being_removed = true
                end
            end
            if being_removed then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copy_card = copy_card(card, nil, nil, G.playing_card)
                copy_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy_card)
                if G.hand then
                    G.hand:emplace(copy_card)
                else
                    G.deck:emplace(copy_card)
                end
                copy_card.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        copy_card:start_materialize()
                        return true
                    end
                }))
                ease_dollars(self.config.extra.dollars)
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end
}