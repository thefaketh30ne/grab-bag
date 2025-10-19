SMODS.Joker {
	key = 'fried_egg',
	loc_txt = {
		name = 'Fried Egg',
		text = {
			"Earn {C:money}$#1#{} at end of round",
            "Payout decreases by {C:money}$#2#{}",
            "when a Joker is {C:attention}sold",
		}
	},
	config = { extra = { dollars = 7, dollars_mod = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 4, y = 8 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_mod } }
	end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "dollars_mod",
                operation = "-",
                no_message = true
            })
            if card.ability.extra.dollars <= 0 then
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
                    message = 'Eaten!',
                    colour = G.C.FILTER
                }
            else
                return {
                    message = 'Downgraded!',
                    colour = G.C.FILTER
                }
            end
        end
    end
}