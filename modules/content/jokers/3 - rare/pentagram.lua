SMODS.Joker {
	key = 'pentagram',
	loc_txt = {
		name = 'Pentagram',
		text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "for every {C:attention}consecutive{} hand with",
            "{C:attention}five scoring cards{}",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
		}
	},
	config = { extra = { xmult = 1, xmult_mod = 0.25 } },
	rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 3, y = 0 },
	cost = 8,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local reset = true
            if #context.scoring_hand >= 5 then
                reset = false
            end
            if reset then
                if card.ability.extra.xmult > 1 then
                    card.ability.extra.xmult = 1
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}