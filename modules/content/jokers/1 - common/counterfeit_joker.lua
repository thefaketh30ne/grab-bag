SMODS.Joker {
	key = 'counterfeit_joker',
	loc_txt = {
		name = 'Counterfeit Joker',
		text = {
			"Gives {C:mult}+#1#{} Mult,",
			"lose {C:red}-$#2#{} at end of round",
		}
	},
	config = { extra = { mult = 15, money = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 2 },
	cost = 2,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.money } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
	calc_dollar_bonus = function(self, card)
        return -card.ability.extra.money
    end
}