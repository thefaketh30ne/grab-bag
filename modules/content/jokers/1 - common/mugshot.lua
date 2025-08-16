SMODS.Joker {
	key = 'mugshot',
	loc_txt = {
		name = 'Mugshot',
		text = {
            "{C:attention}Charge{} cards give {C:mult}+#1#{} Mult",
            "while held in hand"
		}
	},
	config = { extra = { mult = 10 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 6, y = 6 },
	cost = 4,
	blueprint_compat = true,
    enhancement_gate = "m_gb_charge",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gb_charge
        return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.hand
        and not context.end_of_round
        and SMODS.has_enhancement(context.other_card, 'm_gb_charge') then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}