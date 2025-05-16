SMODS.Joker {
	key = 'impostor',
	loc_txt = {
		name = 'Impostor',
		text = {
			"{C:common}Common{} {C:attention}Jokers{}",
			"give {C:mult}+#1#{} Mult each",
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}