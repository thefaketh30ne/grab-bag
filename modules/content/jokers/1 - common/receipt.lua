SMODS.Joker {
	key = 'receipt',
	loc_txt = {
		name = 'Receipt',
		text = {
			"This Joker gains {C:chips}+#1#{} Chips",
			"for every {C:money}$1{} spent",
			"in the {C:attention}previous shop",
			"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
		}
	},
	config = { extra = { chips = 0, chips_mod = 5 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 2 },
	cost = 4,
	blueprint_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.money_altered
		and context.money_altered < 0
		and context.from_shop == true then
			SMODS.scale_card(card, {
                ref_value = "chips",
				ref_table = card.ability.extra,
	            scalar_value = "chips_mod",
                scalar_table = card.ability.extra,
                operation = function(ref_table, ref_value, initial, change)
	                ref_table[ref_value] = initial - context.money_altered * card.ability.extra.chips_mod
                end,
            })
		end
		if context.starting_shop then
			card.ability.extra.chips = 0
			return {
				message = localize("k_reset"),
				colour = G.C.FILTER
			}
		end
        if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}
