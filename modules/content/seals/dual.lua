SMODS.Seal {
    key = 'dual',
    loc_txt = {
        name = "Dual Seal",
        label = "Dual Seal",
        text = {
            "{C:green}#1# in #2#{} chance to",
            "{C:attention}duplicate{} this card",
            "to hand if scoring",
        }
    },
    atlas = "gb_Seals",
    pos = { x = 0, y = 0 },
    config = { extra = { odds = 4 } },
    badge_colour = HEX('6E89C2'),
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, self.config.extra.odds)
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.before 
        and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'gb_dual', 1, self.config.extra.odds) then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copy_card = copy_card(card, nil, nil, G.playing_card)
                copy_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy_card)
                G.hand:emplace(copy_card)
                copy_card.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        copy_card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = localize('k_copied_ex'),
                    colour = HEX("6E89C2"),
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