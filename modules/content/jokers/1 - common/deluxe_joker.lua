SMODS.Joker {
	key = 'deluxe_joker',
	loc_txt = {
		name = 'Deluxe Joker',
		text = {
            "{C:mult}+#1#{} Mult"
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 8 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}