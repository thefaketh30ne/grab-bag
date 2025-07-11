SMODS.Joker {
    key = "qubits",
    loc_txt = {
		name = 'Qubits',
		text = {
			"The first scored card",
            "of each {C:attention}Suit{}",
            "gives {C:mult}+#1#{} Mult",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_Jokers',
	pos = { x = 8, y = 1 },
    rarity = 1,
    cost = 4,
    config = { extra = { mult = 6, scored_suits = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            card.ability.extra.scored_suits = {}
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit 
            and not card.ability.extra.scored_suits[context.other_card.base.suit] 
            then 
                card.ability.extra.scored_suits[context.other_card.base.suit] = true 
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}