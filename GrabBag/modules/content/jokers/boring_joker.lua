SMODS.Joker {
	key = 'boring_joker',
	loc_txt = {
		name = 'Boring Joker',
		text = {
			"Retrigger all scoring {C:attention}unenhanced{} cards",
		}
	},
	config = { extra = { repetitions = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 5, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if not next(SMODS.get_enhancements(context.other_card)) then		
                return {
                    repetitions = card.ability.extra.repetitions
                }
			end
		end
	end
}
