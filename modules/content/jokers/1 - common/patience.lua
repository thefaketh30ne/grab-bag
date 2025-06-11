SMODS.Joker {
	key = 'patience',
	loc_txt = {
		name = 'Patience',
		text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "for every played hand this round",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
		}
	},
	config = { extra = { mult = 0, mult_mod = 5 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 3 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
        end
        if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.mult = 0
        end
	end
}