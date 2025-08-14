SMODS.Joker {
    key = '24_carrots',
	loc_txt = {
		name = '24 Carrots',
		text = {
			"The next {C:attention}#1#{} played cards",
            "have a {C:green}#2# in #3# chance",
            "to become {C:attention}Gold{} cards"
		}
	},
	config = { extra = { cards_left = 24, odds = 4 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 7 },
	cost = 4,
	blueprint_compat = true,
    eternal_compat = false,
	loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { card.ability.extra.cards_left, new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.main_eval then
            for _, playing_card in ipairs(context.full_hand) do
                if SMODS.pseudorandom_probability(card, 'gb_24_carrots', 1, card.ability.extra.odds) then
                    playing_card:set_ability('m_gold', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))
                end
                if not context.blueprint then
                    card.ability.extra.cards_left = card.ability.extra.cards_left - 1
                end
                if card.ability.extra.cards_left <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                        message = 'Eaten!'
                    }
                end
            end
        end
    end
}