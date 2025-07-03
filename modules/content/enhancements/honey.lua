SMODS.Enhancement {
    key = 'honey',
    loc_txt = {
		name = 'Honey Card',
		text = {
			"When drawn, {C:green}#1# in #2#{} chance",
            "to draw another {C:attention}Honey Card{}",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 2, y = 0 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            for _, search_card in ipairs(context.hand_drawn) do
                if search_card == card then
                    if pseudorandom('gb_honey') < G.GAME.probabilities.normal / card.ability.extra.odds then
                        local honey_cards = {}
                        for _, playing_card in ipairs(G.deck.cards) do
                            if SMODS.has_enhancement(playing_card, 'm_gb_honey')
                            and not playing_card.ability.honey_drawn then
                                honey_cards[#honey_cards + 1] = playing_card
                            end
                        end
                        if honey_cards and #honey_cards > 0 then
                            local chosen_card = pseudorandom_element(honey_cards, pseudoseed('gb_honey'))
                            if chosen_card then
                                chosen_card.ability.honey_drawn = true
                                draw_card(G.deck, G.hand, 100, 'up', true, chosen_card)
                                SMODS.calculate_context({hand_drawn = { chosen_card }})
                            end
                        end
                    end
                break
                end
            end
        end
        if context.end_of_round then
            card.ability.already_drawn = nil
        end
    end
}
