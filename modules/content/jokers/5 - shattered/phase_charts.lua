SMODS.Joker {
	key = 'phase_charts',
	loc_txt = {
		name = 'Phase Charts',
		text = {
			"This Joker gains {X:mult,C:white}X#1#{} Mult",
            "at end of round, {C:attention}resets{} at {X:mult,C:white}X#3#{}",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	config = { extra = { xmult = 1, xmult_mod = 1, xmult_limit = 5 } },
	blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 4, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult, card.ability.extra.xmult_limit } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            if card.ability.extra.xmult > card.ability.extra.xmult_limit then
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end
    end
}