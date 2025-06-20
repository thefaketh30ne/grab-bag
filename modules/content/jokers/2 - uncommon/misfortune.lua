SMODS.Joker {
	key = 'misfortune',
	loc_txt = {
		name = 'Wheel Of Misfortune',
		text = {
			"{X:mult,C:white}X#1#{} Mult, {C:green}#2# in #3# chance{}",
			"for played hand",
			"to score nothing",
		}
	},
	config = { extra = { xmult = 3, odds = 4 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 1 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
		if context.final_scoring_step then
			if pseudorandom('gb_misfortune') < G.GAME.probabilities.normal / card.ability.extra.odds then		
				hand_chips = 0
				mult = 0
				return {
					message = localize('k_nope_ex'),
					colour = G.C.SECONDARY_SET.Tarot,
					sound = 'cancel'
				}
			end
		end
	end
}