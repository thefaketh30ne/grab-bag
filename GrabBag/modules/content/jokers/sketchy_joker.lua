SMODS.Joker {
	key = 'sketchy_joker',
	loc_txt = {
		name = 'Sketchy Joker',
		text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "for every {C:attention}#4#{} cards drawn",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult) (#3#/#4#)",
		}
	},
	config = { extra = { mult = 0, mult_mod = 1, draw_tally = 0, draws = 7 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 3 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult, card.ability.extra.draw_tally, card.ability.extra.draws } }
	end,
	calculate = function(self, card, context)
		if context.hand_drawn then
			local upgraded = false
			for _, playing_card in ipairs(context.hand_drawn) do
				card.ability.extra.draw_tally = card.ability.extra.draw_tally + 1
				if card.ability.extra.draw_tally >= card.ability.extra.draws then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					card.ability.extra.draw_tally = card.ability.extra.draw_tally - card.ability.extra.draws
					upgraded = true
				end
			end
			if upgraded == true then
				return {
					message = localize('k_upgrade_ex'),
                	colour = G.C.MULT
				}
			end
		end
		if context.other_drawn then
			local upgraded = false
			for _, playing_card in ipairs(context.other_drawn) do
				card.ability.extra.draw_tally = card.ability.extra.draw_tally + 1
				if card.ability.extra.draw_tally >= card.ability.extra.draws then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					card.ability.extra.draw_tally = card.ability.extra.draw_tally - card.ability.extra.draws
					upgraded = true
				end
			end
			if upgraded == true then
				return {
					message = localize('k_upgrade_ex'),
                	colour = G.C.MULT
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}