SMODS.Joker {
	key = 'spamjoker',
	loc_txt = {
		name = 'Spamjoker',
		text = {
			"Earn between {C:red}-$#1#{} and {C:money}$#2#{}",
            "at end of round",
		}
	},
	config = { extra = { dollars_min = -3, dollars_max = 12 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 7 },
	cost = 7,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { -card.ability.extra.dollars_min, card.ability.extra.dollars_max } }
	end,
    calc_dollar_bonus = function(self, card)
        return pseudorandom(
        "j_gb_spamjoker",
        card.ability.extra.dollars_min,
        card.ability.extra.dollars_max
    )
    end,
}