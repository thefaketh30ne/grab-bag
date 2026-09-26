SMODS.Joker {
	key = 'disrespectful_joker',
	loc_txt = {
		name = 'Disrespectful Joker',
		text = {
            "{C:mult}+#1#{} Mult for each",
            "{C:money}dollar{} less than {C:money}$25",
            "you have",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
	config = { extra = { mult_mod = 2, mult = 0 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 8, y = 8 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        card.ability.extra.mult = math.min(
			0, (25 - G.GAME.dollars) * card.ability.extra.mult_mod
		)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.mult = math.min(
				0, (25 - G.GAME.dollars) * card.ability.extra.mult_mod
			)
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}