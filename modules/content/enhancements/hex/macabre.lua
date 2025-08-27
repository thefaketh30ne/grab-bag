SMODS.Enhancement {
    key = 'macabre',
    loc_txt = {
		name = 'Macabre Card',
		text = {
			"Gains {C:mult}+#1#{} Mult",
			"when discarded",
            "{C:green}#2# in #3#{} chance to be",
            "{C:attention}destroyed{} after playing",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 0, y = 0 },
    config = { mult = 0, extra = { mult_mod = 10, odds = 8 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { card.ability.extra.mult_mod, new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "mult",
                scalar_table = card.ability.extra,
                scalar_value = "mult_mod",
                message_colour = G.C.MULT
            })
        end
        if context.destroy_card
        and context.destroy_card == card
        and context.card_area == G.play
        and SMODS.pseudorandom_probability(card, 'gb_macabre', 1, card.ability.extra.odds) then
            return {
                remove = true
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
