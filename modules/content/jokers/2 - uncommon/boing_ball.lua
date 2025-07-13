SMODS.Joker {
	key = 'boing_ball',
	loc_txt = {
		name = 'Boing Ball',
		text = {
			"{C:green}#1# in #2# chance{} for",
			"played cards to retrigger",
		}
	},
	config = { extra = { odds = 2, repetitions = 1 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 6, y = 3 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
			if SMODS.pseudorandom_probability(card, 'gb_boing_ball', 1, card.ability.extra.odds) then		
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}