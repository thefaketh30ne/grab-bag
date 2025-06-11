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
	atlas = 'gb_Jokers',
	pos = { x = 6, y = 3 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
			if pseudorandom('gb_boing_ball') < G.GAME.probabilities.normal / card.ability.extra.odds then		
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}