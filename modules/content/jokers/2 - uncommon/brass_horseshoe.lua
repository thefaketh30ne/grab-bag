SMODS.Joker {
	key = 'brass_horseshoe',
	loc_txt = {
		name = 'Brass Horseshoe',
		text = {
            "This Joker gains {C:mult}+#2#{} Mult",
            "when a {C:green}listed probability{C:attention} succeeds{}",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
		}
	},
	config = { extra = { mult = 0, mult_mod = 3 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 6 },
	cost = 7,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
	end,
    calculate = function(self, card, context)
        if context.pseudorandom_result and context.result and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message = localize ("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
	    if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

