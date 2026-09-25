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
        local mult = (25 - G.GAME.dollars) * card.ability.extra.mult_mod
        if mult < 0 then mult = 0 end
        card.ability.extra.mult = mult
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            local mult = (25 - G.GAME.dollars) * card.ability.extra.mult_mod
            if mult < 0 then mult = 0 end
            card.ability.extra.mult = mult
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}