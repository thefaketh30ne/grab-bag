SMODS.Joker {
	key = 'morose_joker',
	loc_txt = {
		name = 'Morose Joker',
		text = {
			"Gives {C:mult}+#1#{} Mult",
			"if played hand",
			"does not contain a {C:attention}Pair{}"
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 2, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult} }
	end,
	calculate = function(self, card, context)
		if context.joker_main and not next(context.poker_hands['Pair']) then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}